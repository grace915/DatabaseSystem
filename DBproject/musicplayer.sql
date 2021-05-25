-- MariaDB dump 10.17  Distrib 10.5.6-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: musicplayer
-- ------------------------------------------------------
-- Server version	10.5.6-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `musicplayer`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `musicplayer` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `musicplayer`;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `release_date` date DEFAULT NULL,
  `genre` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,'Only You','2020-12-03','ballade'),(2,'BE','2020-11-20','Rap/Hiphop, Dance, Ballade, R&B/Soul'),(3,'The Fist Collage','2012-11-26','Ballade, Dance'),(4,'Can you feel it?','2017-03-20','Dance'),(5,'Calling You','2017-05-29','Dancd, Ballade, R&B/Soul'),(6,'Love Poem','2019-11-18','Rock/Metal');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album_produce`
--

DROP TABLE IF EXISTS `album_produce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album_produce` (
  `album` int(11) NOT NULL,
  `artist` int(11) NOT NULL,
  PRIMARY KEY (`album`,`artist`),
  KEY `artist` (`artist`),
  CONSTRAINT `album_produce_ibfk_1` FOREIGN KEY (`album`) REFERENCES `album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `album_produce_ibfk_2` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_produce`
--

LOCK TABLES `album_produce` WRITE;
/*!40000 ALTER TABLE `album_produce` DISABLE KEYS */;
INSERT INTO `album_produce` VALUES (1,1),(2,2),(3,1),(4,4),(5,4),(6,5);
/*!40000 ALTER TABLE `album_produce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `debut` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'Yang Yoseab','2009-10-16'),(2,'BTS','2013-06-13'),(3,'V','2013-06-13'),(4,'Highlight','2009-10-16'),(5,'IU','2008-08-18');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_affiliated`
--

DROP TABLE IF EXISTS `artist_affiliated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist_affiliated` (
  `artist` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  PRIMARY KEY (`artist`,`team`),
  KEY `artist_affiliated_ibfk_2` (`team`),
  CONSTRAINT `artist_affiliated_ibfk_1` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `artist_affiliated_ibfk_2` FOREIGN KEY (`team`) REFERENCES `artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_affiliated`
--

LOCK TABLES `artist_affiliated` WRITE;
/*!40000 ALTER TABLE `artist_affiliated` DISABLE KEYS */;
INSERT INTO `artist_affiliated` VALUES (1,4),(3,2);
/*!40000 ALTER TABLE `artist_affiliated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music`
--

DROP TABLE IF EXISTS `music`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `music` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `genre` text DEFAULT NULL,
  `lyrics` text DEFAULT NULL,
  `release_date` date NOT NULL,
  `album` int(11) NOT NULL,
  `shortenLyrics` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `music_ibfk` (`album`),
  CONSTRAINT `music_ibfk` FOREIGN KEY (`album`) REFERENCES `album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music`
--

LOCK TABLES `music` WRITE;
/*!40000 ALTER TABLE `music` DISABLE KEYS */;
INSERT INTO `music` VALUES (1,'Love that I recognized at once','ballade','그대 눈을 바라보면\r\n마음이 떨려요\r\n이 모든 순간이\r\n전부 꿈만 같아요\r\n어느 날 내게로 다가와\r\n운명이란 걸 알게 되었죠\r\nBaby I love you\r\n난 네가 필요해\r\nAnd hold me 내 곁에 있어줄래\r\nMy only you 매일 걱정돼요\r\n혹시 사라질까 봐\r\n그댄 나의 사랑\r\nOnly you\r\n내게 보였던 그 미소\r\n다 너무 예뻐서\r\n더 보고 싶어서\r\n나를 달래고 있죠\r\n한 번에 알아 본 사랑은\r\n내 생에 오직 그대뿐이죠\r\nBaby I love you\r\n난 네가 필요해\r\nAnd hold me 내 곁에 있어 줄래\r\nMy only you 매일 걱정돼요\r\n혹시 사라질까 봐\r\n그댄 나의 사랑\r\nOnly you\r\n푸르고 짙은 계절이 찾아올 때\r\n그대 나의 꽃이 되어 주기를\r\nIn my heart\r\nBaby I love you\r\n나 너를 사랑해\r\nAlways love you 곁에 있어 줄래\r\nMy only you 매일 걱정돼요\r\n혹시 사라질까 봐\r\n그댄 나의 사랑\r\nOnly you','2020-12-03',1,'그대 눈을 바라보면 마음이 떨려요...'),(2,'Caffeine','Ballade','늦었네 자야 되는데\n머릿속에 양은 벌써 다 셌어\n어떻게든 잠들어 보려 했던\n샤워도 또 다시 했어\n천장에 니 얼굴이\n자꾸 그려지고 눈감으면\n끝나버린 우리 Story가\n담긴 책이 펼쳐지고\n넌 떠나간 후에도 날 이렇게 괴롭혀\n어쩌다가 내가 이렇게까지 괴로워\n하게 된 건지 내가 뭘 잘못한 건지\n우리가 왜 이별인건지도 모르는데\nCause Ur like caffeine\n난 밤새 잠 못 들고\n심장은 계속 뛰고\n그러다가 또 니가 너무 밉고\nLike caffeine 멀리하려고 해도\n잊어보려고 해도\n그럴 수가 어쩔 수가 없잖아\nYou’re bad to me so bad to me\noh girl you’re like caffeine\nYou’re bad to me so bad to me\noh girl you’re like caffeine\nYou’re bad to me so bad to me\noh girl you’re like caffeine\nYou’re bad to me so bad to me\nso bad to me yeah\n숨을 쉴 때마다 니가 그립다\n같은 하늘 아래 있다\n생각하니까 더 미친다\n이러면서도 난 널 못 놓아\n저기 창문 밖 다투는 연인들이 보여\n지난 우리 모습 같아 눈물 고여\n이봐요 그러지 말고 그녈 감싸줘요\n날 봐요 이런 내가 어때 보이나요\n널 붙잡을 기회도 내겐 줄 수 없었니\n그렇게 쉽게 끝나버릴 가벼운 사인\n아니었잖니 아님 내 착각인 건지\n우리가 왜 이별인 건지도 모르는데\nCause Ur like caffeine\n난 밤새 잠 못 들고\n심장은 계속 뛰고\n그러다가 또 니가 너무 밉고\nLike caffeine 멀리하려고 해도\n잊어보려고 해도\n그럴 수가 어쩔 수가 없잖아\n이렇게 널 미워하다가도 난\n함께였던 시간\n돌아보면 웃음이 나와\n어쩌면 잊기 싫은 건지도 몰라\n아니 잊기 싫은가 봐\n간직하고 싶은 건가 봐\nCause Ur like caffeine\n난 밤새 잠 못 들고\n심장은 계속 뛰고 그러다가\n또 니가 너무 밉고\nLike caffeine 멀리하려고 해도\n잊어보려고 해도\n그럴 수가 어쩔 수가 없잖아\nYou bad to me so bad to me\noh girl you like caffeine\nYou bad to me so bad to me\noh girl you like caffeine\nYou bad to me so bad to me\noh girl you like caffeine\nYou bad to me so bad to me\nso bad to me yeah\n','2012-11-26',3,'늦었네 자야 되는데 머릿속에 양은 벌써 다 셌어...'),(3,'Plz Dont be Sad','Dance','오늘따라 유난히 웃지 않는\n네가 왠지 슬퍼 보여\n무슨 일이 있냐는 나의 말에\n괜찮다며 고갤 돌려\n너의 눈물 한 방울에\n내 하늘은 무너져 내려\n깊게 내쉬는 한숨이 내 맘을 찢어\n난 너의 빛이 될게\n그림자를 거둬줘 이제\n그 천사 같은 얼굴에\n작은 상처 하나도\n너에겐 생기지 않기를 원해\n너의 슬픔 조차도\n나에게 모두 맡겼으면 해 Ma Baby\n얼굴 찌푸리지 말아요\nBaby 넌 웃는 게 더 예뻐\n그렇게 슬픈 표정하지 말아요\n널 보면 내 맘이 너무 아파 Oh Oh\n그래 그렇게 날 보며 웃어줘 Oh Oh\n그 예쁜 얼굴 찌푸리지 말아줘\n숨기지 말고 내게 말해줘\n아무 말 없이 널 안아줄게\n내 품 안에서\n네 상처 다 아물 수 있게\n늘 아름다운 것만 담아주고 싶어\n예쁜 두 눈에\n미소만 짓게 해줄게 그 입술에\n난 너의 빛이 될게\n그림자를 거둬줘 이제\n그 천사 같은 얼굴에\n작은 상처 하나도\n너에겐 생기지 않기를 원해\n너의 슬픔 조차도\n나에게 모두 맡겼으면 해 Ma Baby\n얼굴 찌푸리지 말아요\nBaby 넌 웃는 게 더 예뻐\n그렇게 슬픈 표정하지 말아요\n널 보면 내 맘이 너무 아파 Oh Oh\n그래 그렇게 날 보며 웃어줘\n그 예쁜 얼굴 찌푸리지 말아줘\n모두가 떠나도 난 너만 있으면 돼\n그렇게 내 안에서 행복하길 원해\n널 지킬 수만 있다면\n아깝지 않아 내 세상마저도\n얼굴 찌푸리지 말아요\nBaby 넌 웃는 게 더 예뻐\n그렇게 슬픈 표정하지 말아요\n널 보면 내 맘이 너무 아파 Oh Oh\n그래 그렇게 날 보며 웃어줘 Oh Oh\n그 예쁜 얼굴 찌푸리지 말아줘\n','2017-03-20',4,'오늘따라 유난히 웃지않는...'),(4,'Its still Beautiful','Ballade','그대가 없는 나란 걸\n이 거리도 안다는 듯이\n나를 감싸 주네요\n낯설어질까 두려웠지만\n이젠 괜찮아요\n내 걱정은 하지 마세요\n그대가 남긴 이별은 쓰라리지만\n사랑만큼 또 소중하죠\n아픔마저도 너라서\n난 웃을 수 있어\n떠나가던 모습조차\n내겐 추억인 거죠\n어쩔 수 없는 상처는\n언젠가 아물 거예요\n머물렀던 모든 곳에\n그대는 떠났지만\n비어버린 빈 자리조차\n그대였기에\n그대로 아름답다\n환하게 웃어보아도\n어딘지 슬퍼 보인대요\n어쩔 수 없는 걸까요\n잘 숨겨놓으려 했지만\n어느새 새어 나와요\n작지 않은 그대라서\n그대가 남긴 이별은 쓰라리지만\n사랑만큼 또 소중하죠\n아픔마저도 너라서\n난 웃을 수 있어\n떠나가던 모습조차\n내겐 추억인 거죠\n어쩔 수 없는 상처는\n언젠가 아물 거예요\n머물렀던 모든 곳에\n그대는 떠났지만\n비어버린 빈 자리조차\n그대였기에\n그대로 아름답다\n아파할 자격조차 없지 난\n뒤돌아보면\n소중하단 말\n사랑한단 말만큼\n잘해준 것조차 없기에\n처음부터 내가 가지기엔\n너무 아름다운 네 맘이었다고\n너와 함께 했던 시간\n모든 게 아름다웠어\n그대가 찾아 왔죠 내 꿈에\n꿈인걸 알면서도 내 뺨엔\n뜨거운 눈물이 흐르네요\n그댄 여전히 아름답네요\n그대가 찾아 왔죠 내 꿈에\n꿈인걸 알면서도 내 뺨엔\n뜨거운 눈물이 흐르네요\n그댄 여전히 아름답네요\n','2017-03-20',4,'그대가 없는 나란 걸...'),(5,'Life Goes On','Rap/Hiphop','어느 날 세상이 멈췄어\n아무런 예고도 하나 없이\n봄은 기다림을 몰라서\n눈치 없이 와버렸어\n발자국이 지워진 거리\n여기 넘어져있는 나\n혼자 가네 시간이\n미안해 말도 없이\n\n오늘도 비가 내릴 것 같아\n흠뻑 젖어버렸네\n아직도 멈추질 않아\n저 먹구름보다 빨리 달려가\n그럼 될 줄 알았는데\n나 겨우 사람인가 봐\n몹시 아프네\n세상이란 놈이 준 감기\n덕분에 눌러보는 먼지 쌓인 되감기\n넘어진 채 청하는 엇박자의 춤\n겨울이 오면 내쉬자\n더 뜨거운 숨\n\n끝이 보이지 않아\n출구가 있긴 할까\n발이 떼지질 않아 않아 oh\n잠시 두 눈을 감아\n여기 내 손을 잡아\n저 미래로 달아나자\n\nLike an echo in the forest\n하루가 돌아오겠지\n아무 일도 없단 듯이\nYeah life goes on\nLike an arrow in the blue sky\n또 하루 더 날아가지\nOn my pillow, on my table\nYeah life goes on\nLike this again\n\n이 음악을 빌려 너에게 나 전할게\n사람들은 말해 세상이 다 변했대\n다행히도 우리 사이는\n아직 여태 안 변했네\n\n늘 하던 시작과 끝 ‘안녕’이란 말로\n오늘과 내일을 또 함께 이어보자고\n멈춰있지만 어둠에 숨지 마\n빛은 또 떠오르니깐\n\n끝이 보이지 않아\n출구가 있긴 할까\n발이 떼지질 않아 않아 oh\n잠시 두 눈을 감아\n여기 내 손을 잡아\n저 미래로 달아나자\n\nLike an echo in the forest\n하루가 돌아오겠지\n아무 일도 없단 듯이\nYeah life goes on\nLike an arrow in the blue sky\n또 하루 더 날아가지\nOn my pillow, on my table\nYeah life goes on\nLike this again\n\nI remember\nI remember\nI remember\nI remember\n','2020-11-20',2,'어느 날 세상이 멈췄어'),(6,'Blue & Grey','Ballade','Where is my angel\n�하루의 끝을 드리운\nSomeone come and save me, please\n지친 하루의 한숨뿐\n\n사람들은 다 행복한가 봐\nCan you look at me? Cuz I am blue & grey\n거울에 비친 눈물의 의미는\n웃음에 감춰진 나의 색깔 blue & grey\n\n어디서부터 잘못됐는지 잘 모르겠어\n나 어려서부터 머릿속엔 파란색 물음표\n어쩜 그래서 치열하게 살았는지 모르지\nBut 뒤를 돌아보니 여기 우두커니 서니\n나를 집어삼켜버리는 저 서슬 퍼런 그림자\n여전히도 파란색 물음표는\n과연 불안인지 우울인지\n어쩜 정말 후회의 동물인지\n아니면은 외로움이 낳은 나일지\n여전히 모르겠어 서슬 퍼런 블루\n잠식되지 않길 바래 찾을 거야 출구\n\nI just wanna be happier\n차가운 날 녹여줘\n수없이 내민 나의 손\n색깔 없는 메아리\nOh this ground feels so heavier\nI am singing by myself\nI just wanna be happier\n이것도 큰 욕심일까\n추운 겨울 거리를 걸을 때 느낀\n빨라진 심장의 호흡 소릴\n지금도 느끼곤 해\n\n괜찮다고 하지 마\n괜찮지 않으니까\n제발 혼자 두지 말아 줘 너무 아파\n\n늘 걷는 길과 늘 받는 빛\nBut 오늘은 왠지 낯선 scene\n무뎌진 걸까 무너진 걸까\n근데 무겁긴 하다 이 쇳덩인\n다가오는 회색 코뿔소\n초점 없이 난 덩그러니 서있어\n나답지 않아 이 순간\n그냥 무섭지가 않아\n\n난 확신이란 신 따위 안 믿어\n색채 같은 말은 간지러워\n넓은 회색지대가 편해\n여기 수억 가지 표정의 grey\n비가 오면 내 세상\n이 도시 위로 춤춘다\n맑은 날엔 안개를\n젖은 날엔 함께 늘\n여기 모든 먼지들\n위해 축배를\n\nI just wanna be happier\n내 손의 온길 느껴줘\n따뜻하지가 않아서 네가 더욱 필요해\nOh this ground feels so heavier\nI am singing by myself\n먼 훗날 내가 웃게 되면\n말할게 그랬었다고\n\n허공에 떠도는 말을 몰래 주워 담고 나니\n이제 새벽잠이 드네 good night\n','2020-11-20',2,'Where is my angel'),(7,'그대는 모르죠','Dance','\n하루 종일 그대가 눈에 아른거려요\n그대 때문에 아무것도 할 수가 없죠\n꿈속에까지도 나타나서\n날 흔들어 놓네요\n깨어나면 그댈 찾아 헤매곤 하죠\n길을 걷다가 예쁜 옷을 봐도 난\n그대가 자꾸 떠올라\n맛있는 음식을 먹을 때도 난\n그대가 떠올라\n오늘같이 햇살이 좋은 날\n아름다운 그대와의 데이트는\n얼마나 달콤할까요\n이런 날 그대는 모르죠\n내겐 너무 과분한 당신이라서\n다가 갈 수조차 없어\n하지만 그대가 몰라도\n내 맘 전할 수 없다고 해도\n난 멈출 수가 없네요\n모든 것들이 새롭게 보여요\nBecause of you Woo Hoo\n은은한 바람까지 날 설레게 해\n거리의 연인들을 봐도\n난 그대가 자꾸 떠올라\n할 일 없는 주말이 돼도\n난 그대가 떠올라\n오늘같이 햇살이 좋은 날\n아름다운 그대와의 데이트는\n얼마나 달콤할까요\n이런 날 그대는 모르죠\n내겐 너무 과분한 당신이라서\n다가 갈 수조차 없어\n하지만 그대가 몰라도\n내 맘 전할 수 없다고 해도 난\n멈출 수가 없네요\n그대는 모르죠 내 마음을\n나 혼자 시작한 사랑을\n간절히 원하기에 언젠간\n이뤄질 거라 믿어요\n이런 날 그대는 모르죠\n내겐 너무 과분한 당신이라서\n다가 갈 수조차 없어\n하지만 그대가 몰라도\n내 맘 전할 수 없다고 해도\n난 멈출 수가 없네요\n','2012-11-26',3,'하루 종일 그대가 눈에 아른거려요...'),(8,'그 사람','Rock/Metal','그 사람 돌아보지 않아요\n사랑에 약속하지 않고요\n매일을 춤추듯이 살아서\n한순간도 그에게 눈 뗄 수 없었나 봐요\n\n그 사람 부끄러워 않아요\n쉬운 농담에 쉬이 웃지 않고요\n그러다 한 번 웃어 주면\n아, 난 어쩌지 못하고 밤새 몸달아 했어요\n\n오 날 살게 하던 총명한 말 마디마디\n겨우 미워해 봐도 잊혀지진 않네요\n\n발자국 하나 안 두고\n어디로 바삐 떠나셨나요\n\nWhy do i still love you\nWhy do i sing about you\nWhy do i still wait for you\nSing about you say love you\nBaby i love you\nWhy i love you why you\n\n오 날 덥게 하던\n따뜻한 손 마디마디\n애써 밀어내 봐도 떨쳐지지 않아요\n\n그림자 한 뼘 안 주고\n어찌 숨 가삐 떠나셨나요\n\n그 사람 마주친 적 있나요\n여전히 그렇게 그 던가요\n지금쯤 어디서 어느 누구, 어떤 음악에\n고고히 춤추고 있을까요\n\nWhy do i still love you\nWhy do i sing about you\nWhy do i still wait for you\nSing about you Say love you\nBaby i love you\nwhy i love you why you\n','2019-11-18',6,'그 사람 돌아보지 않아요...'),(9,'시간의 바깥','Rock/Metal','그 사람 돌아보지 않아요\n사랑에 약속하지 않고요\n매일을 춤추듯이 살아서\n한순간도 그에게 눈 뗄 수 없었나 봐요\n\n그 사람 부끄러워 않아요\n쉬운 농담에 쉬이 웃지 않고요\n그러다 한 번 웃어 주면\n아, 난 어쩌지 못하고 밤새 몸달아 했어요\n\n오 날 살게 하던 총명한 말 마디마디\n겨우 미워해 봐도 잊혀지진 않네요\n\n발자국 하나 안 두고\n어디로 바삐 떠나셨나요\n\nWhy do i still love you\nWhy do i sing about you\nWhy do i still wait for you\nSing about you say love you\nBaby i love you\nWhy i love you why you\n\n오 날 덥게 하던\n따뜻한 손 마디마디\n애써 밀어내 봐도 떨쳐지지 않아요\n\n그림자 한 뼘 안 주고\n어찌 숨 가삐 떠나셨나요\n\n그 사람 마주친 적 있나요\n여전히 그렇게 그 던가요\n지금쯤 어디서 어느 누구, 어떤 음악에\n고고히 춤추고 있을까요\n\nWhy do i still love you\nWhy do i sing about you\nWhy do i still wait for you\nSing about you Say love you\nBaby i love you\nwhy i love you why you\n','2019-11-01',6,'서로를 닮아 기울어진 삶...');
/*!40000 ALTER TABLE `music` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music_composer`
--

DROP TABLE IF EXISTS `music_composer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `music_composer` (
  `composer` varchar(15) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`composer`,`music`),
  KEY `music_composer_ibfk_1` (`music`),
  CONSTRAINT `music_composer_ibfk_1` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_composer`
--

LOCK TABLES `music_composer` WRITE;
/*!40000 ALTER TABLE `music_composer` DISABLE KEYS */;
INSERT INTO `music_composer` VALUES ('Good Life',3),('Good Life',4),('Good Life',7),('IU',8),('IU',9),('Jisso Park',6),('Kin',2),('Pdogg',5),('RM',5),('V',6),('Young',2),('이도형',1),('한경수',1);
/*!40000 ALTER TABLE `music_composer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music_release`
--

DROP TABLE IF EXISTS `music_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `music_release` (
  `artist` int(11) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`artist`,`music`),
  KEY `music_release_ibfk_2` (`music`),
  CONSTRAINT `music_release_ibfk_1` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `music_release_ibfk_2` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_release`
--

LOCK TABLES `music_release` WRITE;
/*!40000 ALTER TABLE `music_release` DISABLE KEYS */;
INSERT INTO `music_release` VALUES (1,1),(1,2),(1,7),(2,5),(2,6),(4,3),(4,4),(5,8),(5,9);
/*!40000 ALTER TABLE `music_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music_writer`
--

DROP TABLE IF EXISTS `music_writer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `music_writer` (
  `writer` varchar(15) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`writer`,`music`),
  KEY `music_writer_ibfk_1` (`music`),
  CONSTRAINT `music_writer_ibfk_1` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_writer`
--

LOCK TABLES `music_writer` WRITE;
/*!40000 ALTER TABLE `music_writer` DISABLE KEYS */;
INSERT INTO `music_writer` VALUES ('Good Life',3),('Good Life',4),('Good Life',7),('IU',8),('IU',9),('Jisso Park',6),('Kim',2),('Pdogg',5),('RM',5),('V',6),('Young',2),('한경수',1);
/*!40000 ALTER TABLE `music_writer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlist` (
  `user` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `public` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user`,`name`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
INSERT INTO `playlist` VALUES (1,'favorite',0),(1,'favorite3',1),(2,'favorite',1),(5,'myFavorite',1),(5,'play',0),(8,'bb playlist',1);
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist_registered`
--

DROP TABLE IF EXISTS `playlist_registered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlist_registered` (
  `user` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`user`,`name`,`music`),
  KEY `playlist_registered_ibfk_1` (`music`),
  CONSTRAINT `playlist_registered_ibfk_1` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playlist_registered_ibfk_2` FOREIGN KEY (`user`, `name`) REFERENCES `playlist` (`user`, `name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist_registered`
--

LOCK TABLES `playlist_registered` WRITE;
/*!40000 ALTER TABLE `playlist_registered` DISABLE KEYS */;
INSERT INTO `playlist_registered` VALUES (1,'favorite',2),(1,'favorite',3),(1,'favorite',6),(1,'favorite3',1),(2,'favorite',1),(5,'myFavorite',1),(5,'myFavorite',2),(5,'myFavorite',3),(5,'myFavorite',5),(5,'myFavorite',6),(5,'play',5);
/*!40000 ALTER TABLE `playlist_registered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` text NOT NULL,
  `pw` text NOT NULL,
  `name` text NOT NULL,
  `registration` text NOT NULL,
  `manage` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `registration` (`registration`) USING HASH,
  UNIQUE KEY `Email` (`email`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'grace915@naver.com','1234','grace','000915',1),(2,'broad915@naver.com','1234','Broad','3709724',0),(3,'grace0807@hanyang.ac.kr','1234','gaeun','4709711',1),(4,'grace53942915@gmail.com','1234','gaeun Lee','12345',0),(5,'a','1234','aa','1234',1),(6,'aa','1234','a','4321',1),(7,'b','4321','babo','0',0),(8,'bb','1234','bb','1',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_comment`
--

DROP TABLE IF EXISTS `user_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_comment` (
  `user` int(11) NOT NULL,
  `music` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  PRIMARY KEY (`user`,`music`),
  KEY `user_comment_ibfk_1` (`music`),
  CONSTRAINT `user_comment_ibfk_1` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_comment_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_comment`
--

LOCK TABLES `user_comment` WRITE;
/*!40000 ALTER TABLE `user_comment` DISABLE KEYS */;
INSERT INTO `user_comment` VALUES (1,1,'Perfect!'),(1,2,'Happy'),(1,5,'BTS! BTS!'),(1,8,'IU!!'),(5,1,'Good!'),(5,2,'I want to sleep');
/*!40000 ALTER TABLE `user_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_like`
--

DROP TABLE IF EXISTS `user_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_like` (
  `user` int(11) NOT NULL,
  `album` int(11) NOT NULL,
  PRIMARY KEY (`user`,`album`),
  KEY `album` (`album`),
  CONSTRAINT `user_like_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`),
  CONSTRAINT `user_like_ibfk_2` FOREIGN KEY (`album`) REFERENCES `album` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_like`
--

LOCK TABLES `user_like` WRITE;
/*!40000 ALTER TABLE `user_like` DISABLE KEYS */;
INSERT INTO `user_like` VALUES (1,1),(1,2),(5,1),(5,2);
/*!40000 ALTER TABLE `user_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_play`
--

DROP TABLE IF EXISTS `user_play`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_play` (
  `user` int(11) NOT NULL,
  `music` int(11) NOT NULL,
  `count` int(11) DEFAULT 0,
  PRIMARY KEY (`user`,`music`),
  KEY `user_play_ibfk_2` (`music`),
  CONSTRAINT `user_play_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_play_ibfk_2` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_play`
--

LOCK TABLES `user_play` WRITE;
/*!40000 ALTER TABLE `user_play` DISABLE KEYS */;
INSERT INTO `user_play` VALUES (1,1,45),(1,2,31),(1,3,32),(1,5,38),(1,6,23),(2,6,38),(5,1,42),(5,2,18),(5,3,18),(5,6,18);
/*!40000 ALTER TABLE `user_play` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_recommend`
--

DROP TABLE IF EXISTS `user_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_recommend` (
  `user` int(11) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`user`,`music`),
  KEY `user_recommend_ibfk_2` (`music`),
  CONSTRAINT `user_recommend_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_recommend_ibfk_2` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_recommend`
--

LOCK TABLES `user_recommend` WRITE;
/*!40000 ALTER TABLE `user_recommend` DISABLE KEYS */;
INSERT INTO `user_recommend` VALUES (1,1),(1,5),(1,8),(5,1),(5,2),(5,5),(5,8);
/*!40000 ALTER TABLE `user_recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `musicplayer`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `musicplayer` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `musicplayer`;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `release_date` date DEFAULT NULL,
  `genre` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,'Only You','2020-12-03','ballade'),(2,'BE','2020-11-20','Rap/Hiphop, Dance, Ballade, R&B/Soul'),(3,'The Fist Collage','2012-11-26','Ballade, Dance'),(4,'Can you feel it?','2017-03-20','Dance'),(5,'Calling You','2017-05-29','Dancd, Ballade, R&B/Soul'),(6,'Love Poem','2019-11-18','Rock/Metal');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album_produce`
--

DROP TABLE IF EXISTS `album_produce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album_produce` (
  `album` int(11) NOT NULL,
  `artist` int(11) NOT NULL,
  PRIMARY KEY (`album`,`artist`),
  KEY `artist` (`artist`),
  CONSTRAINT `album_produce_ibfk_1` FOREIGN KEY (`album`) REFERENCES `album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `album_produce_ibfk_2` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_produce`
--

LOCK TABLES `album_produce` WRITE;
/*!40000 ALTER TABLE `album_produce` DISABLE KEYS */;
INSERT INTO `album_produce` VALUES (1,1),(2,2),(3,1),(4,4),(5,4),(6,5);
/*!40000 ALTER TABLE `album_produce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `debut` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'Yang Yoseab','2009-10-16'),(2,'BTS','2013-06-13'),(3,'V','2013-06-13'),(4,'Highlight','2009-10-16'),(5,'IU','2008-08-18');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_affiliated`
--

DROP TABLE IF EXISTS `artist_affiliated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist_affiliated` (
  `artist` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  PRIMARY KEY (`artist`,`team`),
  KEY `artist_affiliated_ibfk_2` (`team`),
  CONSTRAINT `artist_affiliated_ibfk_1` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `artist_affiliated_ibfk_2` FOREIGN KEY (`team`) REFERENCES `artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_affiliated`
--

LOCK TABLES `artist_affiliated` WRITE;
/*!40000 ALTER TABLE `artist_affiliated` DISABLE KEYS */;
INSERT INTO `artist_affiliated` VALUES (1,4),(3,2);
/*!40000 ALTER TABLE `artist_affiliated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music`
--

DROP TABLE IF EXISTS `music`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `music` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `genre` text DEFAULT NULL,
  `lyrics` text DEFAULT NULL,
  `release_date` date NOT NULL,
  `album` int(11) NOT NULL,
  `shortenLyrics` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `music_ibfk` (`album`),
  CONSTRAINT `music_ibfk` FOREIGN KEY (`album`) REFERENCES `album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music`
--

LOCK TABLES `music` WRITE;
/*!40000 ALTER TABLE `music` DISABLE KEYS */;
INSERT INTO `music` VALUES (1,'Love that I recognized at once','ballade','그대 눈을 바라보면\r\n마음이 떨려요\r\n이 모든 순간이\r\n전부 꿈만 같아요\r\n어느 날 내게로 다가와\r\n운명이란 걸 알게 되었죠\r\nBaby I love you\r\n난 네가 필요해\r\nAnd hold me 내 곁에 있어줄래\r\nMy only you 매일 걱정돼요\r\n혹시 사라질까 봐\r\n그댄 나의 사랑\r\nOnly you\r\n내게 보였던 그 미소\r\n다 너무 예뻐서\r\n더 보고 싶어서\r\n나를 달래고 있죠\r\n한 번에 알아 본 사랑은\r\n내 생에 오직 그대뿐이죠\r\nBaby I love you\r\n난 네가 필요해\r\nAnd hold me 내 곁에 있어 줄래\r\nMy only you 매일 걱정돼요\r\n혹시 사라질까 봐\r\n그댄 나의 사랑\r\nOnly you\r\n푸르고 짙은 계절이 찾아올 때\r\n그대 나의 꽃이 되어 주기를\r\nIn my heart\r\nBaby I love you\r\n나 너를 사랑해\r\nAlways love you 곁에 있어 줄래\r\nMy only you 매일 걱정돼요\r\n혹시 사라질까 봐\r\n그댄 나의 사랑\r\nOnly you','2020-12-03',1,'그대 눈을 바라보면 마음이 떨려요...'),(2,'Caffeine','Ballade','늦었네 자야 되는데\n머릿속에 양은 벌써 다 셌어\n어떻게든 잠들어 보려 했던\n샤워도 또 다시 했어\n천장에 니 얼굴이\n자꾸 그려지고 눈감으면\n끝나버린 우리 Story가\n담긴 책이 펼쳐지고\n넌 떠나간 후에도 날 이렇게 괴롭혀\n어쩌다가 내가 이렇게까지 괴로워\n하게 된 건지 내가 뭘 잘못한 건지\n우리가 왜 이별인건지도 모르는데\nCause Ur like caffeine\n난 밤새 잠 못 들고\n심장은 계속 뛰고\n그러다가 또 니가 너무 밉고\nLike caffeine 멀리하려고 해도\n잊어보려고 해도\n그럴 수가 어쩔 수가 없잖아\nYou’re bad to me so bad to me\noh girl you’re like caffeine\nYou’re bad to me so bad to me\noh girl you’re like caffeine\nYou’re bad to me so bad to me\noh girl you’re like caffeine\nYou’re bad to me so bad to me\nso bad to me yeah\n숨을 쉴 때마다 니가 그립다\n같은 하늘 아래 있다\n생각하니까 더 미친다\n이러면서도 난 널 못 놓아\n저기 창문 밖 다투는 연인들이 보여\n지난 우리 모습 같아 눈물 고여\n이봐요 그러지 말고 그녈 감싸줘요\n날 봐요 이런 내가 어때 보이나요\n널 붙잡을 기회도 내겐 줄 수 없었니\n그렇게 쉽게 끝나버릴 가벼운 사인\n아니었잖니 아님 내 착각인 건지\n우리가 왜 이별인 건지도 모르는데\nCause Ur like caffeine\n난 밤새 잠 못 들고\n심장은 계속 뛰고\n그러다가 또 니가 너무 밉고\nLike caffeine 멀리하려고 해도\n잊어보려고 해도\n그럴 수가 어쩔 수가 없잖아\n이렇게 널 미워하다가도 난\n함께였던 시간\n돌아보면 웃음이 나와\n어쩌면 잊기 싫은 건지도 몰라\n아니 잊기 싫은가 봐\n간직하고 싶은 건가 봐\nCause Ur like caffeine\n난 밤새 잠 못 들고\n심장은 계속 뛰고 그러다가\n또 니가 너무 밉고\nLike caffeine 멀리하려고 해도\n잊어보려고 해도\n그럴 수가 어쩔 수가 없잖아\nYou bad to me so bad to me\noh girl you like caffeine\nYou bad to me so bad to me\noh girl you like caffeine\nYou bad to me so bad to me\noh girl you like caffeine\nYou bad to me so bad to me\nso bad to me yeah\n','2012-11-26',3,'늦었네 자야 되는데 머릿속에 양은 벌써 다 셌어...'),(3,'Plz Dont be Sad','Dance','오늘따라 유난히 웃지 않는\n네가 왠지 슬퍼 보여\n무슨 일이 있냐는 나의 말에\n괜찮다며 고갤 돌려\n너의 눈물 한 방울에\n내 하늘은 무너져 내려\n깊게 내쉬는 한숨이 내 맘을 찢어\n난 너의 빛이 될게\n그림자를 거둬줘 이제\n그 천사 같은 얼굴에\n작은 상처 하나도\n너에겐 생기지 않기를 원해\n너의 슬픔 조차도\n나에게 모두 맡겼으면 해 Ma Baby\n얼굴 찌푸리지 말아요\nBaby 넌 웃는 게 더 예뻐\n그렇게 슬픈 표정하지 말아요\n널 보면 내 맘이 너무 아파 Oh Oh\n그래 그렇게 날 보며 웃어줘 Oh Oh\n그 예쁜 얼굴 찌푸리지 말아줘\n숨기지 말고 내게 말해줘\n아무 말 없이 널 안아줄게\n내 품 안에서\n네 상처 다 아물 수 있게\n늘 아름다운 것만 담아주고 싶어\n예쁜 두 눈에\n미소만 짓게 해줄게 그 입술에\n난 너의 빛이 될게\n그림자를 거둬줘 이제\n그 천사 같은 얼굴에\n작은 상처 하나도\n너에겐 생기지 않기를 원해\n너의 슬픔 조차도\n나에게 모두 맡겼으면 해 Ma Baby\n얼굴 찌푸리지 말아요\nBaby 넌 웃는 게 더 예뻐\n그렇게 슬픈 표정하지 말아요\n널 보면 내 맘이 너무 아파 Oh Oh\n그래 그렇게 날 보며 웃어줘\n그 예쁜 얼굴 찌푸리지 말아줘\n모두가 떠나도 난 너만 있으면 돼\n그렇게 내 안에서 행복하길 원해\n널 지킬 수만 있다면\n아깝지 않아 내 세상마저도\n얼굴 찌푸리지 말아요\nBaby 넌 웃는 게 더 예뻐\n그렇게 슬픈 표정하지 말아요\n널 보면 내 맘이 너무 아파 Oh Oh\n그래 그렇게 날 보며 웃어줘 Oh Oh\n그 예쁜 얼굴 찌푸리지 말아줘\n','2017-03-20',4,'오늘따라 유난히 웃지않는...'),(4,'Its still Beautiful','Ballade','그대가 없는 나란 걸\n이 거리도 안다는 듯이\n나를 감싸 주네요\n낯설어질까 두려웠지만\n이젠 괜찮아요\n내 걱정은 하지 마세요\n그대가 남긴 이별은 쓰라리지만\n사랑만큼 또 소중하죠\n아픔마저도 너라서\n난 웃을 수 있어\n떠나가던 모습조차\n내겐 추억인 거죠\n어쩔 수 없는 상처는\n언젠가 아물 거예요\n머물렀던 모든 곳에\n그대는 떠났지만\n비어버린 빈 자리조차\n그대였기에\n그대로 아름답다\n환하게 웃어보아도\n어딘지 슬퍼 보인대요\n어쩔 수 없는 걸까요\n잘 숨겨놓으려 했지만\n어느새 새어 나와요\n작지 않은 그대라서\n그대가 남긴 이별은 쓰라리지만\n사랑만큼 또 소중하죠\n아픔마저도 너라서\n난 웃을 수 있어\n떠나가던 모습조차\n내겐 추억인 거죠\n어쩔 수 없는 상처는\n언젠가 아물 거예요\n머물렀던 모든 곳에\n그대는 떠났지만\n비어버린 빈 자리조차\n그대였기에\n그대로 아름답다\n아파할 자격조차 없지 난\n뒤돌아보면\n소중하단 말\n사랑한단 말만큼\n잘해준 것조차 없기에\n처음부터 내가 가지기엔\n너무 아름다운 네 맘이었다고\n너와 함께 했던 시간\n모든 게 아름다웠어\n그대가 찾아 왔죠 내 꿈에\n꿈인걸 알면서도 내 뺨엔\n뜨거운 눈물이 흐르네요\n그댄 여전히 아름답네요\n그대가 찾아 왔죠 내 꿈에\n꿈인걸 알면서도 내 뺨엔\n뜨거운 눈물이 흐르네요\n그댄 여전히 아름답네요\n','2017-03-20',4,'그대가 없는 나란 걸...'),(5,'Life Goes On','Rap/Hiphop','어느 날 세상이 멈췄어\n아무런 예고도 하나 없이\n봄은 기다림을 몰라서\n눈치 없이 와버렸어\n발자국이 지워진 거리\n여기 넘어져있는 나\n혼자 가네 시간이\n미안해 말도 없이\n\n오늘도 비가 내릴 것 같아\n흠뻑 젖어버렸네\n아직도 멈추질 않아\n저 먹구름보다 빨리 달려가\n그럼 될 줄 알았는데\n나 겨우 사람인가 봐\n몹시 아프네\n세상이란 놈이 준 감기\n덕분에 눌러보는 먼지 쌓인 되감기\n넘어진 채 청하는 엇박자의 춤\n겨울이 오면 내쉬자\n더 뜨거운 숨\n\n끝이 보이지 않아\n출구가 있긴 할까\n발이 떼지질 않아 않아 oh\n잠시 두 눈을 감아\n여기 내 손을 잡아\n저 미래로 달아나자\n\nLike an echo in the forest\n하루가 돌아오겠지\n아무 일도 없단 듯이\nYeah life goes on\nLike an arrow in the blue sky\n또 하루 더 날아가지\nOn my pillow, on my table\nYeah life goes on\nLike this again\n\n이 음악을 빌려 너에게 나 전할게\n사람들은 말해 세상이 다 변했대\n다행히도 우리 사이는\n아직 여태 안 변했네\n\n늘 하던 시작과 끝 ‘안녕’이란 말로\n오늘과 내일을 또 함께 이어보자고\n멈춰있지만 어둠에 숨지 마\n빛은 또 떠오르니깐\n\n끝이 보이지 않아\n출구가 있긴 할까\n발이 떼지질 않아 않아 oh\n잠시 두 눈을 감아\n여기 내 손을 잡아\n저 미래로 달아나자\n\nLike an echo in the forest\n하루가 돌아오겠지\n아무 일도 없단 듯이\nYeah life goes on\nLike an arrow in the blue sky\n또 하루 더 날아가지\nOn my pillow, on my table\nYeah life goes on\nLike this again\n\nI remember\nI remember\nI remember\nI remember\n','2020-11-20',2,'어느 날 세상이 멈췄어'),(6,'Blue & Grey','Ballade','Where is my angel\n�하루의 끝을 드리운\nSomeone come and save me, please\n지친 하루의 한숨뿐\n\n사람들은 다 행복한가 봐\nCan you look at me? Cuz I am blue & grey\n거울에 비친 눈물의 의미는\n웃음에 감춰진 나의 색깔 blue & grey\n\n어디서부터 잘못됐는지 잘 모르겠어\n나 어려서부터 머릿속엔 파란색 물음표\n어쩜 그래서 치열하게 살았는지 모르지\nBut 뒤를 돌아보니 여기 우두커니 서니\n나를 집어삼켜버리는 저 서슬 퍼런 그림자\n여전히도 파란색 물음표는\n과연 불안인지 우울인지\n어쩜 정말 후회의 동물인지\n아니면은 외로움이 낳은 나일지\n여전히 모르겠어 서슬 퍼런 블루\n잠식되지 않길 바래 찾을 거야 출구\n\nI just wanna be happier\n차가운 날 녹여줘\n수없이 내민 나의 손\n색깔 없는 메아리\nOh this ground feels so heavier\nI am singing by myself\nI just wanna be happier\n이것도 큰 욕심일까\n추운 겨울 거리를 걸을 때 느낀\n빨라진 심장의 호흡 소릴\n지금도 느끼곤 해\n\n괜찮다고 하지 마\n괜찮지 않으니까\n제발 혼자 두지 말아 줘 너무 아파\n\n늘 걷는 길과 늘 받는 빛\nBut 오늘은 왠지 낯선 scene\n무뎌진 걸까 무너진 걸까\n근데 무겁긴 하다 이 쇳덩인\n다가오는 회색 코뿔소\n초점 없이 난 덩그러니 서있어\n나답지 않아 이 순간\n그냥 무섭지가 않아\n\n난 확신이란 신 따위 안 믿어\n색채 같은 말은 간지러워\n넓은 회색지대가 편해\n여기 수억 가지 표정의 grey\n비가 오면 내 세상\n이 도시 위로 춤춘다\n맑은 날엔 안개를\n젖은 날엔 함께 늘\n여기 모든 먼지들\n위해 축배를\n\nI just wanna be happier\n내 손의 온길 느껴줘\n따뜻하지가 않아서 네가 더욱 필요해\nOh this ground feels so heavier\nI am singing by myself\n먼 훗날 내가 웃게 되면\n말할게 그랬었다고\n\n허공에 떠도는 말을 몰래 주워 담고 나니\n이제 새벽잠이 드네 good night\n','2020-11-20',2,'Where is my angel'),(7,'그대는 모르죠','Dance','\n하루 종일 그대가 눈에 아른거려요\n그대 때문에 아무것도 할 수가 없죠\n꿈속에까지도 나타나서\n날 흔들어 놓네요\n깨어나면 그댈 찾아 헤매곤 하죠\n길을 걷다가 예쁜 옷을 봐도 난\n그대가 자꾸 떠올라\n맛있는 음식을 먹을 때도 난\n그대가 떠올라\n오늘같이 햇살이 좋은 날\n아름다운 그대와의 데이트는\n얼마나 달콤할까요\n이런 날 그대는 모르죠\n내겐 너무 과분한 당신이라서\n다가 갈 수조차 없어\n하지만 그대가 몰라도\n내 맘 전할 수 없다고 해도\n난 멈출 수가 없네요\n모든 것들이 새롭게 보여요\nBecause of you Woo Hoo\n은은한 바람까지 날 설레게 해\n거리의 연인들을 봐도\n난 그대가 자꾸 떠올라\n할 일 없는 주말이 돼도\n난 그대가 떠올라\n오늘같이 햇살이 좋은 날\n아름다운 그대와의 데이트는\n얼마나 달콤할까요\n이런 날 그대는 모르죠\n내겐 너무 과분한 당신이라서\n다가 갈 수조차 없어\n하지만 그대가 몰라도\n내 맘 전할 수 없다고 해도 난\n멈출 수가 없네요\n그대는 모르죠 내 마음을\n나 혼자 시작한 사랑을\n간절히 원하기에 언젠간\n이뤄질 거라 믿어요\n이런 날 그대는 모르죠\n내겐 너무 과분한 당신이라서\n다가 갈 수조차 없어\n하지만 그대가 몰라도\n내 맘 전할 수 없다고 해도\n난 멈출 수가 없네요\n','2012-11-26',3,'하루 종일 그대가 눈에 아른거려요...'),(8,'그 사람','Rock/Metal','그 사람 돌아보지 않아요\n사랑에 약속하지 않고요\n매일을 춤추듯이 살아서\n한순간도 그에게 눈 뗄 수 없었나 봐요\n\n그 사람 부끄러워 않아요\n쉬운 농담에 쉬이 웃지 않고요\n그러다 한 번 웃어 주면\n아, 난 어쩌지 못하고 밤새 몸달아 했어요\n\n오 날 살게 하던 총명한 말 마디마디\n겨우 미워해 봐도 잊혀지진 않네요\n\n발자국 하나 안 두고\n어디로 바삐 떠나셨나요\n\nWhy do i still love you\nWhy do i sing about you\nWhy do i still wait for you\nSing about you say love you\nBaby i love you\nWhy i love you why you\n\n오 날 덥게 하던\n따뜻한 손 마디마디\n애써 밀어내 봐도 떨쳐지지 않아요\n\n그림자 한 뼘 안 주고\n어찌 숨 가삐 떠나셨나요\n\n그 사람 마주친 적 있나요\n여전히 그렇게 그 던가요\n지금쯤 어디서 어느 누구, 어떤 음악에\n고고히 춤추고 있을까요\n\nWhy do i still love you\nWhy do i sing about you\nWhy do i still wait for you\nSing about you Say love you\nBaby i love you\nwhy i love you why you\n','2019-11-18',6,'그 사람 돌아보지 않아요...'),(9,'시간의 바깥','Rock/Metal','그 사람 돌아보지 않아요\n사랑에 약속하지 않고요\n매일을 춤추듯이 살아서\n한순간도 그에게 눈 뗄 수 없었나 봐요\n\n그 사람 부끄러워 않아요\n쉬운 농담에 쉬이 웃지 않고요\n그러다 한 번 웃어 주면\n아, 난 어쩌지 못하고 밤새 몸달아 했어요\n\n오 날 살게 하던 총명한 말 마디마디\n겨우 미워해 봐도 잊혀지진 않네요\n\n발자국 하나 안 두고\n어디로 바삐 떠나셨나요\n\nWhy do i still love you\nWhy do i sing about you\nWhy do i still wait for you\nSing about you say love you\nBaby i love you\nWhy i love you why you\n\n오 날 덥게 하던\n따뜻한 손 마디마디\n애써 밀어내 봐도 떨쳐지지 않아요\n\n그림자 한 뼘 안 주고\n어찌 숨 가삐 떠나셨나요\n\n그 사람 마주친 적 있나요\n여전히 그렇게 그 던가요\n지금쯤 어디서 어느 누구, 어떤 음악에\n고고히 춤추고 있을까요\n\nWhy do i still love you\nWhy do i sing about you\nWhy do i still wait for you\nSing about you Say love you\nBaby i love you\nwhy i love you why you\n','2019-11-01',6,'서로를 닮아 기울어진 삶...');
/*!40000 ALTER TABLE `music` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music_composer`
--

DROP TABLE IF EXISTS `music_composer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `music_composer` (
  `composer` varchar(15) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`composer`,`music`),
  KEY `music_composer_ibfk_1` (`music`),
  CONSTRAINT `music_composer_ibfk_1` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_composer`
--

LOCK TABLES `music_composer` WRITE;
/*!40000 ALTER TABLE `music_composer` DISABLE KEYS */;
INSERT INTO `music_composer` VALUES ('Good Life',3),('Good Life',4),('Good Life',7),('IU',8),('IU',9),('Jisso Park',6),('Kin',2),('Pdogg',5),('RM',5),('V',6),('Young',2),('이도형',1),('한경수',1);
/*!40000 ALTER TABLE `music_composer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music_release`
--

DROP TABLE IF EXISTS `music_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `music_release` (
  `artist` int(11) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`artist`,`music`),
  KEY `music_release_ibfk_2` (`music`),
  CONSTRAINT `music_release_ibfk_1` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `music_release_ibfk_2` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_release`
--

LOCK TABLES `music_release` WRITE;
/*!40000 ALTER TABLE `music_release` DISABLE KEYS */;
INSERT INTO `music_release` VALUES (1,1),(1,2),(1,7),(2,5),(2,6),(4,3),(4,4),(5,8),(5,9);
/*!40000 ALTER TABLE `music_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music_writer`
--

DROP TABLE IF EXISTS `music_writer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `music_writer` (
  `writer` varchar(15) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`writer`,`music`),
  KEY `music_writer_ibfk_1` (`music`),
  CONSTRAINT `music_writer_ibfk_1` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music_writer`
--

LOCK TABLES `music_writer` WRITE;
/*!40000 ALTER TABLE `music_writer` DISABLE KEYS */;
INSERT INTO `music_writer` VALUES ('Good Life',3),('Good Life',4),('Good Life',7),('IU',8),('IU',9),('Jisso Park',6),('Kim',2),('Pdogg',5),('RM',5),('V',6),('Young',2),('한경수',1);
/*!40000 ALTER TABLE `music_writer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlist` (
  `user` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `public` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user`,`name`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
INSERT INTO `playlist` VALUES (1,'favorite',0),(1,'favorite3',1),(2,'favorite',1),(5,'myFavorite',1),(5,'play',0),(8,'bb playlist',1);
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist_registered`
--

DROP TABLE IF EXISTS `playlist_registered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlist_registered` (
  `user` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`user`,`name`,`music`),
  KEY `playlist_registered_ibfk_1` (`music`),
  CONSTRAINT `playlist_registered_ibfk_1` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playlist_registered_ibfk_2` FOREIGN KEY (`user`, `name`) REFERENCES `playlist` (`user`, `name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist_registered`
--

LOCK TABLES `playlist_registered` WRITE;
/*!40000 ALTER TABLE `playlist_registered` DISABLE KEYS */;
INSERT INTO `playlist_registered` VALUES (1,'favorite',2),(1,'favorite',3),(1,'favorite',6),(1,'favorite3',1),(2,'favorite',1),(5,'myFavorite',1),(5,'myFavorite',2),(5,'myFavorite',3),(5,'myFavorite',5),(5,'myFavorite',6),(5,'play',5);
/*!40000 ALTER TABLE `playlist_registered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` text NOT NULL,
  `pw` text NOT NULL,
  `name` text NOT NULL,
  `registration` text NOT NULL,
  `manage` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `registration` (`registration`) USING HASH,
  UNIQUE KEY `Email` (`email`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'grace915@naver.com','1234','grace','000915',1),(2,'broad915@naver.com','1234','Broad','3709724',0),(3,'grace0807@hanyang.ac.kr','1234','gaeun','4709711',1),(4,'grace53942915@gmail.com','1234','gaeun Lee','12345',0),(5,'a','1234','aa','1234',1),(6,'aa','1234','a','4321',1),(7,'b','4321','babo','0',0),(8,'bb','1234','bb','1',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_comment`
--

DROP TABLE IF EXISTS `user_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_comment` (
  `user` int(11) NOT NULL,
  `music` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  PRIMARY KEY (`user`,`music`),
  KEY `user_comment_ibfk_1` (`music`),
  CONSTRAINT `user_comment_ibfk_1` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_comment_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_comment`
--

LOCK TABLES `user_comment` WRITE;
/*!40000 ALTER TABLE `user_comment` DISABLE KEYS */;
INSERT INTO `user_comment` VALUES (1,1,'Perfect!'),(1,2,'Happy'),(1,5,'BTS! BTS!'),(1,8,'IU!!'),(5,1,'Good!'),(5,2,'I want to sleep');
/*!40000 ALTER TABLE `user_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_like`
--

DROP TABLE IF EXISTS `user_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_like` (
  `user` int(11) NOT NULL,
  `album` int(11) NOT NULL,
  PRIMARY KEY (`user`,`album`),
  KEY `album` (`album`),
  CONSTRAINT `user_like_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`),
  CONSTRAINT `user_like_ibfk_2` FOREIGN KEY (`album`) REFERENCES `album` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_like`
--

LOCK TABLES `user_like` WRITE;
/*!40000 ALTER TABLE `user_like` DISABLE KEYS */;
INSERT INTO `user_like` VALUES (1,1),(1,2),(5,1),(5,2);
/*!40000 ALTER TABLE `user_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_play`
--

DROP TABLE IF EXISTS `user_play`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_play` (
  `user` int(11) NOT NULL,
  `music` int(11) NOT NULL,
  `count` int(11) DEFAULT 0,
  PRIMARY KEY (`user`,`music`),
  KEY `user_play_ibfk_2` (`music`),
  CONSTRAINT `user_play_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_play_ibfk_2` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_play`
--

LOCK TABLES `user_play` WRITE;
/*!40000 ALTER TABLE `user_play` DISABLE KEYS */;
INSERT INTO `user_play` VALUES (1,1,45),(1,2,31),(1,3,32),(1,5,38),(1,6,23),(2,6,38),(5,1,42),(5,2,18),(5,3,18),(5,6,18);
/*!40000 ALTER TABLE `user_play` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_recommend`
--

DROP TABLE IF EXISTS `user_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_recommend` (
  `user` int(11) NOT NULL,
  `music` int(11) NOT NULL,
  PRIMARY KEY (`user`,`music`),
  KEY `user_recommend_ibfk_2` (`music`),
  CONSTRAINT `user_recommend_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_recommend_ibfk_2` FOREIGN KEY (`music`) REFERENCES `music` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_recommend`
--

LOCK TABLES `user_recommend` WRITE;
/*!40000 ALTER TABLE `user_recommend` DISABLE KEYS */;
INSERT INTO `user_recommend` VALUES (1,1),(1,5),(1,8),(5,1),(5,2),(5,5),(5,8);
/*!40000 ALTER TABLE `user_recommend` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-07 18:23:16
