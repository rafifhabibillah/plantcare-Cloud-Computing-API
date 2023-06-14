import jwt
import time
import uuid
import secrets
import numpy as np
import pymysql.cursors
import tensorflow as tf
import cv2
import os
import io
import base64
#============================
from PIL import Image
from io import BytesIO
from pytz import timezone
from flask_cors import CORS
from google.cloud import storage
from google.oauth2 import service_account
from jwt import ExpiredSignatureError
from datetime import datetime, timedelta
from flask import Flask, request, jsonify, render_template, redirect, url_for, session, flash
from flask_jwt_extended.exceptions import JWTDecodeError
from flask_bcrypt import generate_password_hash, check_password_hash
from flask_jwt_extended import JWTManager, jwt_required, create_access_token, decode_token, get_jwt_identity
from tensorflow.python.keras.layers import Dense
from tensorflow import keras
from keras.layers import Dense
from keras.models import Sequential, load_model
from keras.applications.imagenet_utils import preprocess_input, decode_predictions

# Define a flask app
app = Flask(__name__)

# Konfigurasi MySQL
CORS(app)
app.config['MYSQL_HOST'] = '34.101.139.213'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'qwerty123'
app.config['MYSQL_DB'] = 'PlantCare'
app.config['MYSQL_CURSORCLASS'] = 'pymysql.cursors.DictCursor'
app.config['JWT_SECRET_KEY'] = secrets.token_hex(16)
db = pymysql.connections.Connection(
    host=app.config['MYSQL_HOST'],
    user=app.config['MYSQL_USER'],
    password=app.config['MYSQL_PASSWORD'],
    db=app.config['MYSQL_DB'],
    cursorclass=pymysql.cursors.DictCursor
)
jwt = JWTManager(app)

# key json google serviceacc
service_account_key_path = 'serviceaccountkey.json'

# Create credentials using the service account key file
credentials = service_account.Credentials.from_service_account_file(
    service_account_key_path,
    scopes=['https://www.googleapis.com/auth/cloud-platform']
)

# Initialize Google Cloud Storage client with the credentials
storage_client = storage.Client(credentials=credentials)
bucket_name = 'plantcare-test'
bucket = storage_client.bucket(bucket_name)

# Model saved with Keras model.save()
model_bucket = 'plantcare-test'
tomato_model_blob = 'model_tomato_densenet_kaggle_withtest.h5'
apple_model_blob = 'model-nontf.h5'
tomato_model_path = 'model_tomato_densenet_kaggle_withtest.h5'
apple_model_path = 'model-nontf.h5'

def preprocess_image(image):
    # Normalize pixel values to the range [0, 1]
    image = image / 255.0

    # Perform any other preprocessing steps such as resizing, cropping, etc.
    # ...

    return image

def download_model_from_gcs(model_blob, model_path):
    storage_client = storage.Client.from_service_account_json(service_account_key_path)
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(model_blob)
    blob.download_to_filename(model_path)

# Download the tomato model from GCS
download_model_from_gcs(tomato_model_blob, tomato_model_path)

# Download the apple model from GCS
download_model_from_gcs(apple_model_blob, apple_model_path)

# Load the models
tomato_model = load_model(tomato_model_path)
apple_model = load_model(apple_model_path)

# Define class labels
class_labels_tomato = {0: 'Bacterial Spot', 1: 'Late Blight', 2: 'Early Blight',
                      3: 'Leaf Mold', 4: 'Septoria Leaf Spot',
                      5: 'Spider Mites Two-spotted Spider Mite', 6: 'Target Spot', 7: 'Tomato Yellow Leaf Curl Virus',
                      8: 'Tomato mosaic virus', 9: 'Healthy',
                      10: 'Powdery Mildew'}
class_labels_apple = {0: 'Alternaria Leaf Spot', 1: 'Frogeye Leaf Spot', 2: 'Healthy',
                      3: 'Apple Mosaic Virus', 4: 'Powdery Mildew', 5: 'Cedar Apple Rust', 6: 'Apple scab'}

def preprocess_image(image):
    image = image / 255.0
    return image

def validate_token(token):
    if not token:
        return False, 'Missing token'

    try:
        decoded_token = decode_token(token)
        user_id = decoded_token['sub']
        return True, user_id
    except ExpiredSignatureError:
        return False, 'Token has expired. Please log in again.'
    except (JWTDecodeError, KeyError):
        return False, 'Invalid token. Please log in again.'

@app.route('/Dashboard', methods=['GET'])
@jwt_required()
def dashboard():
    token = request.headers.get('Authorization').split()[1]
    is_valid, user_id = validate_token(token)

    if not is_valid:
        return jsonify({'error': True, 'message': user_id})

    cur = db.cursor()
    cur.execute("SELECT * FROM users WHERE user_id = %s", (user_id,))
    dashboard = cur.fetchone()
    cur.close()

    if not dashboard:
        return jsonify({'error': True, 'message': 'User not found'})

    name = dashboard['name']

    return f'Hallo! {name}'

# controller-auth
@app.route('/auth/login', methods=['POST'])
def login():
    email = request.json['email']
    password = request.json['password']

    cur = db.cursor()
    cur.execute("SELECT * FROM users WHERE email = %s", (email,))
    user = cur.fetchone()
    cur.close()

    if user and check_password_hash(user['password'], password):
        exp_time = datetime.utcnow() + timedelta(days=2)  # Set expiration time 2 days from now
        exp_time = int(time.mktime(exp_time.timetuple()))  # Convert to UNIX timestamp
        token = create_access_token(identity=user['user_id'], expires_delta=timedelta(days=2))
        login_result = {
            'email': user['email'],
            'name': user['name'],
            'token': token,
            'userid': user['user_id']
        }
        return jsonify({
            'error': False,
            'loginResult': login_result,
            'message': 'Login Successed !'
        })

    return jsonify({
        'error': True,
        'message': 'Wrong Password or Account not found, please checked again'
    })

@app.route('/auth/register', methods=['POST'])
def register():
    email = request.json['email']
    password = request.json['password']
    name = request.json['name']

    cur = db.cursor()
    cur.execute("SELECT * FROM users WHERE email = %s", (email,))
    user = cur.fetchone()
    cur.close()

    if user:
        return jsonify({'error': True, 'message': 'Email already taken'})

    cur = db.cursor()
    hashed_password = generate_password_hash(password).decode('utf-8')
    cur.execute(
        "INSERT INTO users (email, password, name) VALUES (%s, %s, %s)",
        (email, hashed_password, name))
    db.commit()
    cur.close()

    return jsonify({'error': False, 'message': 'Berhasil Register Akun. Silahkan Login'})

@app.route('/logout', methods=['POST'])
def logout():
    return jsonify({
        'success': True,
        'message': 'Logout berhasil!'
    })

# Route-Users
@app.route('/history', methods=['GET'])
def gethistory():
    cur = db.cursor()
    cur.execute("SELECT * FROM history")
    history = cur.fetchall()
    cur.close()

    return jsonify(history)
        
@app.route('/historyid', methods=['GET'])
@jwt_required()
def gethistorybyid():
    token = request.headers.get('Authorization').split()[1]
    is_valid, user_id = validate_token(token)

    if not is_valid:
        return jsonify({'error': True, 'message': user_id})

    cur = db.cursor()
    cur.execute("SELECT * FROM history WHERE user_id = %s", (user_id,))
    history1 = cur.fetchall()
    cur.close()
        
    return jsonify(history1)

@app.route('/profile', methods=['GET'])
@jwt_required()
def get_profile():
    token = request.headers.get('Authorization').split()[1]
    is_valid, user_id = validate_token(token)

    if not is_valid:
        return jsonify({'error': True, 'message': user_id})

    cur = db.cursor()
    cur.execute("SELECT * FROM users WHERE user_id = %s", (user_id,))
    user = cur.fetchone()
    cur.close()

    if not user:
        return jsonify({'error': True, 'message': 'User not found'})

    profile = {
        'email': user['email'],
        'name': user['name']
    }

    return jsonify({'error': False, 'profile': profile})

# Route-Kategori
@app.route('/category', methods=['GET'])
def getcategory():
    cur = db.cursor()
    cur.execute("SELECT * FROM category_tanaman")
    category = cur.fetchall()
    cur.close()

    return jsonify(category)

@app.route('/insertcategory', methods=['POST'])
def tambah_category():
    # Generate a unique name for the image
    unique_filename = str(uuid.uuid4()) + '.jpg'

    # Get the image file from the request
    image_file = request.files['image']

    # Save the file to a temporary location
    temp_path = 'temp_image.jpg'
    image_file.save(temp_path)

    # Upload the image to Google Cloud Storage
    storage_client = storage.Client.from_service_account_json(service_account_key_path)
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob('images/' + unique_filename)
    blob.upload_from_filename(temp_path)

    # Get the public URL of the uploaded image
    image_url = blob.public_url

    name_plant = request.json['name_plant']
    name_ilmiah = request.json['name_ilmiah']
    description = request.json['description']
    image_hex = image_url


    cur = db.cursor()
    cur.execute(
        "INSERT INTO category_tanaman (name_plant, name_ilmiah, description, img_url) VALUES (%s, %s, %s)",
        (name_plant, name_ilmiah, description)
    )
    db.commit()
    cur.close()

    return jsonify({'error': False, 'message': 'Data Berhasil Ditambahkan'})
# Route Article
@app.route('/articles', methods=['GET'])
def get_articles():
    cur = db.cursor()
    cur.execute("SELECT * FROM articles")
    articles = cur.fetchall()
    cur.close()

    return jsonify({'articles': articles})

# Endpoint /articles/<int:article_id>
@app.route('/articles/<int:article_id>', methods=['GET'])
def get_article(article_id):
    cur = db.cursor()
    cur.execute("SELECT * FROM articles WHERE article_id = %s", (article_id,))
    article = cur.fetchone()
    cur.close()

    if article:
        return jsonify({'artikel': article})
    else:
        return jsonify({'error': 'Artikel tidak ada, silahkan cek kembali id anda'})

# predict tomato dan apple
@app.route('/predict-tomato', methods=['POST'])
@jwt_required()
def predict_tomato():
    token = request.headers.get('Authorization').split()[1]
    is_valid, user_id = validate_token(token)

    if not is_valid:
        return jsonify({'error': True, 'message': user_id})
        
    # Generate a unique name for the image
    unique_filename = str(uuid.uuid4()) + '.jpg'

    # Get the image file from the request
    image_file = request.files['image']

    # Save the file to a temporary location
    temp_path = 'temp_image.jpg'
    image_file.save(temp_path)

    # Upload the image to Google Cloud Storage
    blob = bucket.blob('images/' + unique_filename)
    blob.upload_from_filename(temp_path)

    # Get the public URL of the uploaded image
    image_url = blob.public_url

    # Load and preprocess the image
    image = tf.keras.preprocessing.image.load_img(temp_path, target_size=(256, 256))
    image = tf.keras.preprocessing.image.img_to_array(image)
    image = preprocess_image(image)  # Preprocess the image as per your model's requirements

    # Add a batch dimension to the image
    image = tf.expand_dims(image, axis=0)

    # Perform inference
    predictions1 = tomato_model.predict(image)

    # Process the predictions
    predicted_classes = tf.argmax(predictions1, axis=1)
    predicted_label = class_labels_tomato[predicted_classes[0].numpy()]

    # Convert the image to PIL Image
    image_pil = tf.keras.preprocessing.image.array_to_img(image[0])

    # Create a buffer to save the image
    image_buffer = io.BytesIO()

    # Save the PIL image to the buffer
    image_pil.save(image_buffer, format='JPEG')

    # Get the hexadecimal representation of the image buffer
    image_hex = image_url

    # Delete the temporary file
    os.remove(temp_path)
    
    # menyimpan hasil prediksi
    cur = db.cursor()
    created_at = datetime.now(timezone('Asia/Jakarta'))
    cur.execute(
        "INSERT INTO history (user_id,plant_category, prediction_result, image_url, created_at) VALUES (%s, %s, %s, %s, %s)",
        (user_id,'4', predicted_label, image_hex, created_at)
    )
    db.commit()
    cur.close()

    cur = db.cursor()
    cur.execute("SELECT * FROM penyakit_tanaman WHERE penyakit = %s AND category_id = %s", (predicted_label,'4'))
    desc = cur.fetchone()
    cur.close()

    if not desc:
        return jsonify({'error': True, 'message': 'Penyakit tidak terdeteksi'})

    deskripsi = {
        'penyebab': desc['penyebab'],
        'description': desc['description'],
        'pengobatan': desc['pengobatan'],
        'rekomendasi_obat': desc['rekomendasi_obat']
    }

    # Return the predicted object label and image buffer as the API response
    return jsonify({'predicted_label': predicted_label, 'image_hex': image_hex, 'deskripsi': deskripsi})

@app.route('/predict-apple', methods=['POST'])
@jwt_required()
def predict_apple():
    # Generate a unique name for the image
    unique_filename = str(uuid.uuid4()) + '.jpg'

    # Get the image file from the request
    image_file = request.files['image']

    # Save the file to a temporary location
    temp_path = 'temp_image.jpg'
    image_file.save(temp_path)

    # Upload the image to Google Cloud Storage
    blob = bucket.blob('images/' + unique_filename)
    blob.upload_from_filename(temp_path)

    # Get the public URL of the uploaded image
    image_url = blob.public_url

    # Load and preprocess the image
    image = tf.keras.preprocessing.image.load_img(temp_path, target_size=(256, 256))
    image = tf.keras.preprocessing.image.img_to_array(image)
    image = preprocess_image(image)  # Preprocess the image as per your model's requirements

    # Add a batch dimension to the image
    image = tf.expand_dims(image, axis=0)

    # Perform inference
    predictions1 = apple_model.predict(image)

    # Process the predictions
    predicted_classes = tf.argmax(predictions1, axis=1)
    predicted_label = class_labels_apple[predicted_classes[0].numpy()]

    # Convert the image to PIL Image
    image_pil = tf.keras.preprocessing.image.array_to_img(image[0])

    # Create a buffer to save the image
    image_buffer = io.BytesIO()

    # Save the PIL image to the buffer
    image_pil.save(image_buffer, format='JPEG')

    # Get the hexadecimal representation of the image buffer
    image_hex = image_url

    # Delete the temporary file
    os.remove(temp_path)

    token = request.headers.get('Authorization').split()[1]
    is_valid, user_id = validate_token(token)

    if not is_valid:
        return jsonify({'error': True, 'message': user_id})


    # menyimpan hasil prediksi
    cur = db.cursor()
    created_at = datetime.now(timezone('Asia/Jakarta'))
    cur.execute(
        "INSERT INTO history (user_id,plant_category, prediction_result, image_url, created_at) VALUES (%s, %s, %s, %s, %s)",
        (user_id,'5', predicted_label, image_hex, created_at)
    )
    db.commit()
    cur.close()

    cur = db.cursor()
    cur.execute("SELECT * FROM penyakit_tanaman WHERE penyakit = %s AND category_id = %s", (predicted_label,'5'))
    desc = cur.fetchone()
    cur.close()

    if not desc:
        return jsonify({'error': True, 'message': 'Penyakit tidak terdeteksi'})

    deskripsi = {
        'penyebab': desc['penyebab'],
        'description': desc['description'],
        'pengobatan': desc['pengobatan'],
        'rekomendasi_obat': desc['rekomendasi_obat']
    }
    
    # Return the predicted object label and image buffer as the API response
    return jsonify({'predicted_label': predicted_label, 'image_hex': image_hex, 'deskripsi': deskripsi})

if __name__ == '__main__':
    app.run(port=8080)
