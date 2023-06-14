-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 34.101.139.213    Database: PlantCare
-- ------------------------------------------------------
-- Server version	8.0.26-google

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'd2b2f62e-0757-11ee-85c6-42010a400003:1-47105';

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `articles_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text,
  `img_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`articles_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_tanaman`
--

DROP TABLE IF EXISTS `category_tanaman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_tanaman` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name_plant` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name_ilmiah` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text,
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_tanaman`
--

LOCK TABLES `category_tanaman` WRITE;
/*!40000 ALTER TABLE `category_tanaman` DISABLE KEYS */;
INSERT INTO `category_tanaman` VALUES (4,'Tomato','Solanum lycopersicum','Tomat adalah tanaman tahunan yang berasal dari Amerika Selatan dan termasuk dalam keluarga Solanaceae. Tanaman tomat memiliki batang yang tegak dan daun hijau yang tersusun secara berselang-seling. Buah tomat biasanya berbentuk bulat atau oval dengan beragam warna seperti merah, kuning, hijau, atau oranye, tergantung pada varietasnya.\nTanaman tomat biasanya ditanam sebagai tanaman hortikultura dan merupakan salah satu tanaman pangan yang populer di seluruh dunia. Buah tomat kaya akan nutrisi, termasuk vitamin C, vitamin A, serat, dan likopen, yang memberikan manfaat kesehatan seperti meningkatkan sistem kekebalan tubuh, menjaga kesehatan jantung, dan mengurangi risiko beberapa jenis kanker.',NULL),(5,'Apple','Malus domestica','Tumbuhan apel (Malus domestica) adalah sejenis pohon buah yang berasal dari keluarga Rosaceae. Tumbuhan ini dikenal karena buahnya yang populer di seluruh dunia. Apel memiliki bentuk bulat dengan berbagai variasi warna kulit, termasuk merah, hijau, kuning, atau kombinasi di antaranya. Buah apel memiliki rasa manis atau asam, tergantung pada varietasnya.\n\nApel adalah tumbuhan berdaun hijau yang tumbuh subur di daerah beriklim sedang hingga dingin. Pohon apel dapat tumbuh hingga ketinggian sekitar 4-12 meter, dengan daun berbentuk oval yang tersusun rapi. Bunganya berwarna putih atau merah muda dan mekar pada musim semi. Penyerbukan bunga apel terjadi melalui serangga seperti lebah.\n\nBuah apel mengandung banyak nutrisi penting, termasuk serat, vitamin C, dan antioksidan. Apel juga terkenal dengan kandungan pektin, yang dapat membantu menjaga kesehatan saluran pencernaan. Buah ini sering dikonsumsi segar, diolah menjadi jus, atau digunakan sebagai bahan dalam makanan dan minuman lainnya.',NULL);
/*!40000 ALTER TABLE `category_tanaman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `predict_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `plant_category` varchar(255) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `prediction_result` varchar(255) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `image_url` varchar(255) CHARACTER SET armscii8 COLLATE armscii8_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`predict_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penyakit_tanaman`
--

DROP TABLE IF EXISTS `penyakit_tanaman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `penyakit_tanaman` (
  `penyakit_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `penyakit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `penyebab` text,
  `description` text,
  `pengobatan` text,
  `rekomendasi_obat` text,
  PRIMARY KEY (`penyakit_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `penyakit_tanaman_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category_tanaman` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penyakit_tanaman`
--

LOCK TABLES `penyakit_tanaman` WRITE;
/*!40000 ALTER TABLE `penyakit_tanaman` DISABLE KEYS */;
INSERT INTO `penyakit_tanaman` VALUES (4,4,'Late Blight','Jamur Phytophthora infestans','Late blight adalah penyakit serius pada tanaman tomat yang disebabkan oleh jamur Phytophthora infestans. Gejalanya meliputi bercak coklat atau hitam pada daun, batang, dan buah. Bercak ini berkembang dengan cepat dan dapat diidentifikasi dengan lapisan berbulu putih pada kondisi lembab. Late blight menyebar melalui spora yang dibawa oleh angin dan air. Kelembaban tinggi dan suhu sejuk juga mempengaruhi perkembangan penyakit ini. ','Fungisida tembaga: Gunakan fungisida tembaga sesuai petunjuk untuk mengendalikan late blight.\r\nAplikasi rutin: Lakukan aplikasi fungisida secara teratur.\r\nPerhatikan gejala: Mulai pengobatan segera setelah gejala muncul.\r\nKebersihan kebun: Hapus sisa tanaman terinfeksi dan jaga kebersihan kebun.\r\nIrigasi yang tepat: Hindari penyiraman dari atas dan siram pada akar tanaman.\r\nPengendalian gulma: Bersihkan gulma yang dapat menjadi sumber infeksi.\r\nPemantauan rutin: Periksa tanaman secara teratur untuk deteksi dini.\r\n','Fungisida tembaga: Contoh produk yang mengandung tembaga seperti Kocide Opti, Cupravit, atau Bordelek.\r\n\r\nFungisida klorotalonil: Contoh produk yang mengandung klorotalonil seperti Bravo, Daconil, atau Chlorothalonil.\r\n\r\nFungisida mankozeb: Contoh produk yang mengandung mankozeb seperti Dithane, Mancozeb, atau Manzate.\r\n\r\nFungisida propineb: Contoh produk yang mengandung propineb seperti Antracol atau Preventol.\r\n'),(5,4,'Healthy','Sehat Secara Keseluruhan Tumbuhan','Dicirikan dengan batang tomat yang tumbuh rambut-rambut halus diseluruh permukaannya, daun yang berwarna hijau, berambut, dan mempunyai panjang sekitar 30 cm dan lebar 20 cm, bunga tomat berwarna kuning cerah, buah yang masih muda berwarna hijau muda sampai hijau tua.','Tidak memerlukan pengobatan, cukup dirawat seperti biasa secara rutin','Tidak ada'),(6,4,'Early Blight','Jamur Alternaria solani','Early blight pada tomat disebabkan oleh jamur Alternaria solani. Penyakit ini menghasilkan bercak coklat atau hitam pada daun, batang, dan buah. Bercak ini membesar dengan cincin coklat di sekitarnya. Daun mengering, menguning, dan gugur. Infeksi juga terjadi pada batang dan buah dengan bercak coklat atau hitam yang membusuk. Penyebaran melalui spora yang dibawa angin, air, atau kontak langsung. Kelembaban tinggi, suhu hangat, dan kepadatan tanaman mempengaruhi perkembangan penyakit','Pemangkasan: Potong dan buang bagian tanaman yang terinfeksi.\r\nFungisida: Gunakan fungisida yang direkomendasikan untuk mengendalikan infeksi.\r\nJaga kebersihan: Hapus sisa tanaman terinfeksi dan menjaga kebersihan kebun.\r\nRotasi tanaman: Lakukan rotasi dengan tanaman non-solanaceous.\r\nSpasi tanaman: Tanam tomat dengan jarak yang cukup untuk sirkulasi udara yang baik.\r\nIrigasi yang tepat: Hindari penyiraman dari atas dan usahakan untuk menyiram pada akar tanaman.\r\nPemeliharaan kebersihan: Bersihkan gulma dan sisa tanaman terinfeksi.\r\nVaritas tahan: Pilih varietas tomat yang tahan terhadap early blight.','Kocide Opti: Fungisida tembaga yang mengandung oksiklorida tembaga. Dapat mengendalikan berbagai penyakit jamur termasuk early blight.\r\n\r\nAntracol: Fungisida yang mengandung propineb, efektif dalam mengendalikan early blight dan penyakit jamur lainnya pada tanaman tomat.\r\n\r\nDithane M-45: Fungisida mankozeb yang populer digunakan untuk mengendalikan early blight pada tanaman tomat serta penyakit jamur lainnya.\r\n\r\nBravo: Fungisida klorotalonil yang efektif dalam mengendalikan early blight dan berbagai penyakit jamur pada tanaman termasuk tomat.'),(7,4,'Septoria Leaf Spot','Jamur Septoria lycopersici.','Septoria leaf spot pada tanaman tomat disebabkan oleh jamur Septoria lycopersici. Gejalanya berupa bercak kecil coklat pada daun dengan pusat pucat dan tepi gelap. Bercak ini dapat berkembang menjadi bercak yang lebih besar dan menyebabkan defoliasi. Penyebarannya melalui percikan air, kontak langsung, atau peralatan taman terkontaminasi.','Gunakan fungisida yang direkomendasikan untuk mengendalikan Septoria leaf spot.\r\nAplikasikan fungisida sesuai petunjuk dosis dan jadwal yang disarankan.\r\nPastikan daun terlapisi dengan baik oleh fungisida, termasuk bagian atas dan bawah.\r\nJaga kebersihan kebun dan hilangkan sisa-sisa tanaman yang terinfeksi.\r\nTingkatkan sirkulasi udara dengan memberi ruang antar tanaman.\r\nHindari penyiraman dari atas dan fokus pada penyiraman akar.','Dithane: Fungisida dengan kandungan mankozeb yang efektif mengendalikan Septoria leaf spot.\r\nBravo: Fungisida dengan kandungan klorotalonil yang efektif melawan penyakit jamur termasuk Septoria leaf spot.\r\nAntracol: Fungisida dengan kandungan propineb yang dapat digunakan untuk mengendalikan Septoria leaf spot.\r\nCupravit: Fungisida tembaga yang dapat digunakan untuk pengendalian Septoria leaf spot pada tanaman tomat.\r\n'),(8,4,'Tomato Yellow Leaf Curl Virus','Virus dalam famili Geminivirus (tomato yellow leaf curl virus (TYLCV)) yang disebar melalui whiteflies/kutu kebul (Bemisia tabaci)','Infeksi terjadi pada daun. Ukuran pada daun mengecil, menggulung ke atas, tampak kusut, dan menguning pada urat dan tepi daun.\r\nRuas menjadi lebih pendek dan seluruh tanaman tampak mengerdil dan lebat.\r\nSeluruh tanaman berdiri tegak dengan arah pertumbuhan yang hanya tegak. Bisa jadi, bunga tidak akan berkembang dan rontok.','Tanaman yang telah terinfeksi tidak dapat diobati, karena penyebabnya adalah virus.\r\nBuang tanaman yang terinfeksi dan bakar.\r\nJaga lahan bebas dari gulma.\r\nGunakan perangkap yang lengket berwarna kuning untuk mengontrol whiteflies/kutu kebul.\r\nTanam varietas yang resisten.\r\nPindahkan tanaman yang bebas penyakit dan whiteflies.\r\nSegera tempatkan tanaman yang terlihat terinfeksi ke dalam kantong plastik, terutama selama tiga hingga empat minggu pertama.\r\nJika terlihat whiteflies, semprotkan insektisida.','Insektisida neonicotinoid, seperti dinotefuran (Venom), imidacloprid (AdmirePro, Alias, Nuprid, Widow, dll), atau thiamethoxam (Platinum) untuk mencegah datangnya whiteflies.'),(9,4,'Bacterial Spot','Bakteri Xanthomonas campestris pv. vesicatoria.','Bacterial spot adalah penyakit umum pada tomat. Disebabkan oleh Xanthomonas campestris pv. vesicatoria, menyebabkan bercak air pada daun yang berubah menjadi cokelat atau hitam. Penyebarannya melalui biji, bibit, atau percikan air. Lingkungan lembap dan suhu 24-29°C mendukung perkembangan. ','Pengobatan dan pencegahan bacterial spot pada tanaman tomat meliputi pemangkasan bagian terinfeksi, penggunaan bahan bakterisida tembaga atau streptomisin, serta pemilihan varietas tahan. Lakukan rotasi tanaman, jaga kebersihan kebun, hindari penyiraman dari atas, dan pastikan sirkulasi udara yang baik. Langkah-langkah ini membantu mengurangi penyebaran bakteri dan kejadian penyakit. Konsultasikan dengan ahli pertanian lokal untuk saran yang lebih spesifik. Pencegahan dan pengobatan yang tepat dapat membantu melindungi tanaman tomat dari bacterial spot yang dapat merusak hasil panen.','Bahan bakterisida tembaga dan streptomisin digunakan untuk mengobati bacterial spot pada tomat.\r\nTembaga menghambat pertumbuhan bakteri, sedangkan streptomisin adalah antibiotik yang menghambat pertumbuhan dan perkembangan bakteri.\r\nIkuti petunjuk penggunaan yang tepat dan konsultasikan dengan ahli pertanian sebelum penggunaan.'),(10,4,'Target Spot','Jamur Corynespora cassiicola','Penyakit ini kerap terjadi pada tomat yang ditanam di ladang di daerah tropis dan subtropis.\r\nJamur menginfeksi semua bagian dari tanaman.\r\nPada daun, infeksi awal ditandai dengan bintik-bintik kecil, dan basah. infeksi lanjutan ditandai dengan menyebarnya titik infeksi menjadi lesi nekrotik dengan lingkaran konsentris yang mencolok, tepi gelap, dan pada bagian tengah berwarna coklat muda.\r\nPada buah, infeksi awal ditandai dengan bintik-bintik coklat dan sedikit cekung, tetapi kemudian lesi menjadi semakin besar dan berlubang.','Buang sisa-sisa tanaman dan bakar.\r\nBeri jarak yang lebih lebar antartanaman dan hindari pemberian pupuk nitrogen secara berlebihan.\r\nJika penyakitnya parah, semprotkan fungisida yang sesuai.\r\nGunakan produk yang mengandung chlorothalonil, mancozeb, atau copper oxychloride. Perawatan harus dimulai saat pertama kali gejala infeksi muncul, dilanjutkan dengan interval 10-14 hari hingga 3-4 minggu sebelum panen berakhir.','Produk yang mengandung chlorothalonil, mancozeb, dan copper oxychloride.'),(11,4,'Tomato mosaic virus','virus Tobamovirus ToMV yang masuk melalui daun yang mengalami luka mekanis, seperti gigitan serangga atau cangkok. Selain itu, sisa-sisa tanaman yang telah mati atau terinfeksi yang tidak segera dibersihkan juga dapat menjadi sumber penularan yang umum terjadi.','Tiap bagian dari tanaman dapat terinfeksi.\r\nPada daun, infeksi ditandai dengan bercak atau mosaik berwarna hijau tua atau kuning. Kemudian, daun muda mengerdil atau terdistorsi, jika infeksi parah, daun dapat memiliki area hijau yang menonjol atau timbul.\r\npada buah, hasil panennya akan berkurang. jika buah berwarna hijau, akan muncul bercak kuning atau bintik-bintik nekrotik.\r\ngaris nekrotik berwarna gelap dapat ditemui pada batang, tangkai daun, dan buah.\r\n','Buang tanaman yang telah terinfeksi.\r\nTanam varietas tanaman yang kebal virus.\r\nPanaskan benih pada suhu 70°C selama 4 hari atau pada suhu 82-85°C.\r\nMerendam benih selama 15 menit dalam 100 g/l larutan tri-natrium fosfat (TSP) juga dapat menghilangkan partikel virus, tetapi benih harus dibilas secara menyeluruh dan ditiriskan hingga kering setelah perlakuan ini.\r\nDisinfeksi semua peralatan saat berpindah dari area yang terinfeksi ke area yang bebas penyakit.\r\nTanam tomat dengan rotasi 2 tahun.','Penyakit ini tidak dapat disembuhkan dengan produk kimia karena penyebabnya adalah virus.'),(12,4,'Leaf Mold','Jamur Fulvia fulva atau Cladosporium fulvum.','Leaf mold pada tomat disebabkan oleh jamur Fulvia fulva atau Cladosporium fulvum. Gejalanya meliputi bercak kuning atau kecoklatan pada daun, yang berkembang menjadi lapisan jamur hijau-keabu-abuan. Penyebarannya terjadi di lingkungan lembab dan hangat melalui angin, air, atau peralatan taman terkontaminasi. Leaf mold mengurangi hasil panen dan mempengaruhi pertumbuhan tanaman. ','Gunakan fungisida yang direkomendasikan untuk mengendalikan leaf mold.\r\nAplikasikan fungisida sesuai petunjuk dosis dan jadwal yang disarankan.\r\nPastikan daun terlapisi dengan baik oleh fungisida, termasuk bagian atas dan bawah.\r\nJaga kebersihan kebun dan hindari penumpukan dedaunan basah.\r\nTingkatkan sirkulasi udara dengan memberi ruang antar tanaman.\r\nHindari penyiraman dari atas dan fokus pada penyiraman akar.','Dithane: Fungisida dengan kandungan mankozeb yang efektif mengendalikan leaf mold.\r\nBravo: Fungisida dengan kandungan klorotalonil yang efektif melawan penyakit jamur termasuk leaf mold.\r\nAntracol: Fungisida dengan kandungan propineb yang dapat digunakan untuk mengendalikan leaf mold.\r\nCupravit: Fungisida tembaga yang dapat digunakan untuk pengendalian leaf mold pada tanaman tomat.\r\n'),(13,4,'Powdery Mildew','Jamur Oidium neolycopersici','Pada daun tomat terdapat bercak kuning cerah yang tidak teratur. Selain itu, terdapat spora putih pada permukaan atas atau bawah daun.','Penanganan yang dapat diterima secara organik adalah dengan menggunakan Bacillus pumilus dan beberapa semprotan sulfur. Selain itu, pencegahan dapat dilakukan dengan menanam jenis tanaman yang resistan terhadap penyakit ini. Praktik yang dapat dilakukan untuk mencegah penyakit ini adalah membuang sisa-sisa tanaman pada akhir musim, meningkatkan sirkulasi udara, dan menghindari pupuk dengan kadar nitrogen tinggi. Fungisida juga dapat diberikan sebagai tindak pencegahan.','Fungisida yang dapat digunakan adalah azoxystrobin, chlorothalonil, bicarbonates, cuproc hydroxide, sulfur, dan minyak horikultural.'),(14,4,'Spider Mites Two-spotted Spider Mite','Arachnida yang masih terkait dengan laba laba','Two-spotted spider mite, atau kutu laba-laba berbintik dua, adalah serangga kecil kuning/hijau coklat yang hidup di bawah daun tanaman tomat. Mereka membuat jaring halus di antara daun dan menghisap cairan tanaman, menyebabkan daun menguning, kering, dan keriput. Mereka berkembang pesat di lingkungan kering dan hangat, menyebar melalui angin, peralatan taman terkontaminasi, atau perpindahan dari tanaman terinfeksi.','Jaga kelembaban udara yang cukup dengan penyiraman teratur.\r\nBersihkan tanaman dengan semprotan air untuk menghilangkan hama.\r\nPertahankan kebersihan kebun dan hindari kepadatan tanaman yang berlebihan.\r\nGunakan tanaman pendamping yang menarik predator alami serangga.\r\nGunakan insektisida nabati atau pestisida yang direkomendasikan.\r\nAplikasikan insektisida secara merata di daun bagian bawah dan atas.','Abamectin: Insektisida yang efektif untuk mengatasi hama Two-spotted spider mite.\r\nAcaricide: Produk khusus untuk mengendalikan tungau dan hama serupa, termasuk Two-spotted spider mite.\r\nNeem oil: Minyak neem alami yang dapat digunakan sebagai pestisida nabati untuk mengontrol hama seperti Two-spotted spider mite.\r\ntanaman yang dapat menarik predator alami : \r\nCalendula\r\nDaun bawang\r\nDill\r\nFennel\r\nBunga matahari'),(15,5,'Frogeye Leaf Spot','Penyakit ini disebabkan oleh jamur (Botryosphaeria obtusa). Tahap aseksual dari jamur ini menyebabkan penyakit frogeye leaf spot dan tahap seksual dati jamur ini dapat berkontribusi inokulum terhadap infeksi kanker.','Penyakit ini ditandai dengan bercak berwarna cokelat muda berangsur menjadi warna cokelat tua dibagian tengah, dikelilingi tepian ungu tua.','Biasanya, hanya frogeye leaf spot tidak mengancam kesehatan apel, tetapi hal tersebut dapat menjadi sumber spora untuk infeksi kanker black rot. Buanglah cabang yang terkena kanker ketika kondisinya kering untuk mengurangi inokulum yang tersedia untuk menginisasi frogeye leaf spot dan kanker. Buanglah batang buah yang mungkin tersisa dari pohon setelah panen karena mudah dijajah oleh B. obtusa. ','Gunakan perawatan fungisida untuk mencegah infeksi buah jika sanitasi tidak cukup untuk menekan infeksi bercak.\r\n\r\nFungisida yang dapat digunakan seperti Difolatan 4F, Copper Sandoz, Benomyl, dan Antracol 70 WP.'),(16,5,'Healthy','Sehat secara keseluruhan tumbuhan','Daun apel dalam kondisi sehat memiliki warna hijau yang cerah tanpa adanya bintik-bintik atau kerusakan','Tidak diperlukan pengobatan, cukup dirawat seperti biasa secara rutin','Tidak ada'),(17,5,'Apple Mosaic Virus','penyakit ini disebabkan oleh Apple mosaic virus (ApMV)','Penyakit ini ditandai dengan pola klorosis (menguning) yang khas dan acak pada daun','Pencegahan dapat dilakukan dengan menanam jenis tanaman yang virus-free dan gunakan batang cangkok yang virus-free.','Virus tidak dapat dihilangkan selain membuang pohon'),(18,5,'Powdery Mildew','Penyakit ini disebabkan oleh jamur (Podosphaera leucotricha). Spora jamur ini hidup dalam tunas selama musim dingin dan biasanya menyebar melalui angin. ','Penyakit ini ditandai dengan bercak putih seperti beludru di bagian bawah daun dan pucuk, serta bintik-bintik klorosis di bagian atas daun.','Pencegahan dapat dilakukan dengan menanam jenis apel yang kurang rentan atau memiliki resistansi terhadap beberapa penyakit. Hal tersebut dapat mengurangi penggunaan fungisida dan jumlah buaya dari program penyemprotan selama masa pertumbuhan. Infeksi primer dapat dikontrol dengan membuang sumber inokulum primer. Pangkaslah seluruh puncuk terminal yang memutih selama musim dingin atau di awal musim semi. Infeksi sekunder dan infeksi buah dapat dikontrol dengan pengaplikasian fungisida.','Metode yang dapat diterima secara organik adalah penanganan dengan lime and sulfur, sulfur only, dan minyak hotikiltural. '),(19,5,'Cedar Apple Rust','Penyakit ini disebabkan oleh jamur (Gymnosporangium juniperi-virginianae). Jamur ini membutuhkan dua inang untuk menyelesaikan siklus hidupnya. Jamur ini akan membentuk galls pada Eastern redcedar atau juniper, kemudian sporanya akan terbawa angin ke apel. ','Penyakit ini ditandai dengan bercak kuning ata oranye terang dengan bintik hitam kecil di tengah dan dikelilingi dengan tepian berwarna merah di permukaan atas daun.','Pangkaslah galls pada juniper, walaupun keefektifannya masih diperdebatkan karena spora dapat menempuh jarak jauh melalui angin. Lebih baik untuk mencegah penanaman juniper dan rust-susceptible hosts dalam jarak yang dekat. Pencegahan juga dapat dilakukan dengan menanam jenis apel yang resistan. Pilihan yang lain adalah biarkan tanaman hidup dengan penyakitnya, penyakit ini jarang sekali membunuh pohon, tetapi penyakit ini dapat merusak tanaman jika ranting terinfeksi. Gunakan fungisida untuk pencegahan. Penyemprotan fungisida ditujukan untuk melindungi daun dari galls. Pengaplikasian fungisida tidak diperlukan jika galls kering dan inaktif.','Fungisida yang dapat digunakan antara lain captan, chlorothalonil (Daconil), copper, mancozeb, maneb, sulfur, thiophanate methyl (Cleary 3336), thiram, triadimefon, dan ziram. \r\n\r\nNote: untuk strategi organik, konsultasikan terlebih dahulu fungisida yang dapat dipakai.'),(20,5,'Apple scab','Jamur (Venturia inaequalis). Spora jamur ini dapat tersebar oleh angin. Kelembaban yang tinggi dapat mendorong pertumbuhan jamur.','Penyakit ini ditandai dengan daun yang memillin dan berkerut dan memiliki bercak hitam melingkar di bagian bawah daun. Pada permukaan atas daun, bintik-bintik tampak seperti beludru dan berwarna hijau zaitun, tampak seperti jelaga. Bintik-bintik tersebut dapat berkembang dan menutupi seluruh daun. Seiring perkembangan penyakit, daun akan menguning dan rontok.','Jagalah tanaman agar tetap sehat dengan menyiram tanaman selama periode kering. Bersihkan dan buang daun-daun yang terinfeksi. Jamur hidup di daun yang terinfeksi selama musim dingin, jadi sangatlah penting untuk menyapu dan membuang daun di musim gugur. Pangkaslah tanaman untuk memberikan sirkulasi air yang baik. Menanam tanaman yang resistan terhadap apple scab dapat menjadi pilihan untuk mencegah penyakit ini. Aplikasikan fungisida untuk tanaman yang rentan jika dedaunan bersih diperlukan atau jika defoliasi mengurangi buah.','Fungisida yang dapat digunakan antara lain adalah sulfur, chlorothalonil (Daconil), copper, ferbam, fosety-Al, mancozeb, maneb, thiram, triflumizole, dan ziram. Sulfur dapat digunakan, tetapi harus diaplikasikan sebelum spora jamur berkecambah. Semprotan fungisida harus diaplikasikan sebelum infeksi sebagai pencegahan agar efektif.  \r\n\r\nNote: untuk strategi organik, konsultasikan terlebih dahulu fungisida yang dapat dipakai.'),(21,5,'Alternaria Leaf Spot','Jamur Altenaria yang masuk melalui celah epidermis daun yang disebabkan lesi kecil atau gigitan serangga kecil.','Pada daun, fase awal infeksi ditandai dengan bintik-bintik kecil, bulat, dan berwarna keunguan atau kehitaman. Secara bertahap, bintik membesar hingga berdiameter sekitar 0.6 cm, pola bintik tidak teratur, dan warna lebih gelap. \r\nKetika infeksi terjadi pada tangkai daun, warna daun menjadi menguning dan diharuskan terjadi defoliasi (pemangkasan daun).\r\nPada buah, infeksi ditandai dengan bintik-bintik kecil, gelap, dan agak cekung. jika menginfeksi buah yang rusak, penyakit ini dapat menyebabkan pembusukan.\r\n','Untuk menjaga agar tetap terkendali, gunakan kultivar (sekelompok tumbuhan yang telah dipilih untuk suatu atau beberapa ciri tertentu yang khas) yang resisten.\r\nBuang daun yang terinfeksi. Jika menyentuh daun yang terinfeksi, cuci tangan sebelum kontak dengan bagian tanaman yang sehat.\r\nKendalikan bercak Alternaria dengan fungisida strobilurin jika pada 2 bulan sebelum panen penyakit masih menginfeksi lebih dari 15% tanaman.\r\nJaga kebersihan kebun dengan membersihkan daun atau bagian tanaman lain yang berguguran agar meminimalkan jamur Alternaria dari masa dormansi pada bagian tanaman yang gugur.','Fungisida :\r\nFluxapyroxad 250 G/L + Pyraclostrobin 250 G/L SC\r\nDifenoconazole 8.4% + Cyprodinil 24.1%\r\nPyraclostrobin 12.8%+ Boscalid 25.2% ');
/*!40000 ALTER TABLE `penyakit_tanaman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET armscii8 COLLATE armscii8_bin NOT NULL,
  `password` varchar(255) CHARACTER SET armscii8 COLLATE armscii8_bin NOT NULL,
  `name` varchar(255) COLLATE armscii8_bin DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'coba@gmail.com','12345678','coba123');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-13  6:55:48
