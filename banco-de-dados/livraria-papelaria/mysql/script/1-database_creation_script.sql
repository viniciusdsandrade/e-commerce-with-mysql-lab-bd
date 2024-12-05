CREATE DATABASE IF NOT EXISTS `livraria_papelaria` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION = 'N' */;
USE `livraria_papelaria`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: livraria_papelaria
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */;
/*!40103 SET TIME_ZONE = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

--
-- Table structure for table `app_avaliacao`
--

DROP TABLE IF EXISTS `app_avaliacao`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_avaliacao`
(
    `compra_produto_id` bigint NOT NULL,
    `nota`              varchar(5) DEFAULT NULL,
    `comentario`        longtext,
    PRIMARY KEY (`compra_produto_id`),
    CONSTRAINT `app_avaliacao_compra_produto_id_59018d23_fk_app_compraproduto_id` FOREIGN KEY (`compra_produto_id`) REFERENCES `app_compraproduto` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_avaliacao`
--

LOCK TABLES `app_avaliacao` WRITE;
/*!40000 ALTER TABLE `app_avaliacao`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_avaliacao`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_carrinho`
--

DROP TABLE IF EXISTS `app_carrinho`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_carrinho`
(
    `usuario_id` int NOT NULL,
    PRIMARY KEY (`usuario_id`),
    CONSTRAINT `app_carrinho_usuario_id_f35f9476_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_carrinho`
--

LOCK TABLES `app_carrinho` WRITE;
/*!40000 ALTER TABLE `app_carrinho`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_carrinho`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_carrinhoproduto`
--

DROP TABLE IF EXISTS `app_carrinhoproduto`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_carrinhoproduto`
(
    `id`          bigint       NOT NULL AUTO_INCREMENT,
    `quantidade`  int unsigned NOT NULL,
    `carrinho_id` int          NOT NULL,
    `produto_id`  bigint       NOT NULL,
    PRIMARY KEY (`id`),
    KEY `app_carrinhoproduto_carrinho_id_b5f90a61_fk_app_carri` (`carrinho_id`),
    KEY `app_carrinhoproduto_produto_id_a3639bb2_fk_app_produto_id` (`produto_id`),
    CONSTRAINT `app_carrinhoproduto_carrinho_id_b5f90a61_fk_app_carri` FOREIGN KEY (`carrinho_id`) REFERENCES `app_carrinho` (`usuario_id`),
    CONSTRAINT `app_carrinhoproduto_produto_id_a3639bb2_fk_app_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `app_produto` (`id`),
    CONSTRAINT `app_carrinhoproduto_chk_1` CHECK ((`quantidade` >= 0))
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_carrinhoproduto`
--

LOCK TABLES `app_carrinhoproduto` WRITE;
/*!40000 ALTER TABLE `app_carrinhoproduto`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_carrinhoproduto`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_cartao`
--

DROP TABLE IF EXISTS `app_cartao`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_cartao`
(
    `id`               bigint       NOT NULL AUTO_INCREMENT,
    `numero`           varchar(20)  NOT NULL,
    `validade`         date         NOT NULL,
    `codigo_seguranca` varchar(10)  NOT NULL,
    `nome_dono`        varchar(100) NOT NULL,
    `tipo`             varchar(7)   NOT NULL,
    `usuario_id`       int          NOT NULL,
    PRIMARY KEY (`id`),
    KEY `app_cartao_usuario_id_52492ac9_fk_auth_user_id` (`usuario_id`),
    CONSTRAINT `app_cartao_usuario_id_52492ac9_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_cartao`
--

LOCK TABLES `app_cartao` WRITE;
/*!40000 ALTER TABLE `app_cartao`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_cartao`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_categoria`
--

DROP TABLE IF EXISTS `app_categoria`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_categoria`
(
    `id`   bigint      NOT NULL AUTO_INCREMENT,
    `nome` varchar(50) NOT NULL,
    `tipo` varchar(15) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_categoria`
--

LOCK TABLES `app_categoria` WRITE;
/*!40000 ALTER TABLE `app_categoria`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_categoria`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_categoria_produtos`
--

DROP TABLE IF EXISTS `app_categoria_produtos`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_categoria_produtos`
(
    `id`           bigint NOT NULL AUTO_INCREMENT,
    `categoria_id` bigint NOT NULL,
    `produto_id`   bigint NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `app_categoria_produtos_categoria_id_produto_id_9f3eb5ab_uniq` (`categoria_id`, `produto_id`),
    KEY `app_categoria_produtos_produto_id_d71603eb_fk_app_produto_id` (`produto_id`),
    CONSTRAINT `app_categoria_produtos_categoria_id_0bfb6c02_fk_app_categoria_id` FOREIGN KEY (`categoria_id`) REFERENCES `app_categoria` (`id`),
    CONSTRAINT `app_categoria_produtos_produto_id_d71603eb_fk_app_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `app_produto` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_categoria_produtos`
--

LOCK TABLES `app_categoria_produtos` WRITE;
/*!40000 ALTER TABLE `app_categoria_produtos`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_categoria_produtos`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_compra`
--

DROP TABLE IF EXISTS `app_compra`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_compra`
(
    `id`             bigint      NOT NULL AUTO_INCREMENT,
    `data_realizada` datetime(6) NOT NULL,
    `usuario_id`     int         NOT NULL,
    `endereco_id`    bigint      NOT NULL,
    PRIMARY KEY (`id`),
    KEY `app_compra_endereco_id_32d6e171_fk_app_endereco_id` (`endereco_id`),
    KEY `app_compra_usuario_id_bd65a792_fk_auth_user_id` (`usuario_id`),
    CONSTRAINT `app_compra_endereco_id_32d6e171_fk_app_endereco_id` FOREIGN KEY (`endereco_id`) REFERENCES `app_endereco` (`id`),
    CONSTRAINT `app_compra_usuario_id_bd65a792_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_compra`
--

LOCK TABLES `app_compra` WRITE;
/*!40000 ALTER TABLE `app_compra`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_compra`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_compraproduto`
--

DROP TABLE IF EXISTS `app_compraproduto`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_compraproduto`
(
    `id`         bigint       NOT NULL AUTO_INCREMENT,
    `quantidade` int unsigned NOT NULL,
    `compra_id`  bigint       NOT NULL,
    `produto_id` bigint       NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `app_compraproduto_compra_id_produto_id_cf8bd78a_uniq` (`compra_id`, `produto_id`),
    KEY `app_compraproduto_produto_id_b9ed5886_fk_app_produto_id` (`produto_id`),
    CONSTRAINT `app_compraproduto_compra_id_150ab272_fk_app_compra_id` FOREIGN KEY (`compra_id`) REFERENCES `app_compra` (`id`),
    CONSTRAINT `app_compraproduto_produto_id_b9ed5886_fk_app_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `app_produto` (`id`),
    CONSTRAINT `app_compraproduto_chk_1` CHECK ((`quantidade` >= 0))
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_compraproduto`
--

LOCK TABLES `app_compraproduto` WRITE;
/*!40000 ALTER TABLE `app_compraproduto`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_compraproduto`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_cupom`
--

DROP TABLE IF EXISTS `app_cupom`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_cupom`
(
    `id`          bigint         NOT NULL AUTO_INCREMENT,
    `nome`        varchar(100) DEFAULT NULL,
    `desconto`    decimal(10, 2) NOT NULL,
    `data_inicio` datetime(6)    NOT NULL,
    `data_fim`    datetime(6)    NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_cupom`
--

LOCK TABLES `app_cupom` WRITE;
/*!40000 ALTER TABLE `app_cupom`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_cupom`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_cupom_compras`
--

DROP TABLE IF EXISTS `app_cupom_compras`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_cupom_compras`
(
    `id`        bigint NOT NULL AUTO_INCREMENT,
    `cupom_id`  bigint NOT NULL,
    `compra_id` bigint NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `app_cupom_compras_cupom_id_compra_id_14a1a8a8_uniq` (`cupom_id`, `compra_id`),
    KEY `app_cupom_compras_compra_id_f8f5badb_fk_app_compra_id` (`compra_id`),
    CONSTRAINT `app_cupom_compras_compra_id_f8f5badb_fk_app_compra_id` FOREIGN KEY (`compra_id`) REFERENCES `app_compra` (`id`),
    CONSTRAINT `app_cupom_compras_cupom_id_00827b91_fk_app_cupom_id` FOREIGN KEY (`cupom_id`) REFERENCES `app_cupom` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_cupom_compras`
--

LOCK TABLES `app_cupom_compras` WRITE;
/*!40000 ALTER TABLE `app_cupom_compras`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_cupom_compras`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_endereco`
--

DROP TABLE IF EXISTS `app_endereco`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_endereco`
(
    `id`           bigint     NOT NULL AUTO_INCREMENT,
    `nome`         varchar(20)  DEFAULT NULL,
    `rua`          varchar(100) DEFAULT NULL,
    `numero`       varchar(8)   DEFAULT NULL,
    `bairro`       varchar(100) DEFAULT NULL,
    `cidade`       varchar(100) DEFAULT NULL,
    `estado`       varchar(100) DEFAULT NULL,
    `cep`          varchar(20)  DEFAULT NULL,
    `complemento`  varchar(50)  DEFAULT NULL,
    `is_principal` tinyint(1) NOT NULL,
    `usuario_id`   int        NOT NULL,
    PRIMARY KEY (`id`),
    KEY `app_endereco_usuario_id_0e3fba8e_fk_auth_user_id` (`usuario_id`),
    CONSTRAINT `app_endereco_usuario_id_0e3fba8e_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_endereco`
--

LOCK TABLES `app_endereco` WRITE;
/*!40000 ALTER TABLE `app_endereco`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_endereco`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_entrega`
--

DROP TABLE IF EXISTS `app_entrega`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_entrega`
(
    `compra_produto_id` bigint NOT NULL,
    `codigo_rastreio`   varchar(100) DEFAULT NULL,
    `data_postado`      datetime(6)  DEFAULT NULL,
    `data_transito`     datetime(6)  DEFAULT NULL,
    `data_recebido`     datetime(6)  DEFAULT NULL,
    `estado`            varchar(30)  DEFAULT NULL,
    `transportadora_id` bigint NOT NULL,
    PRIMARY KEY (`compra_produto_id`),
    KEY `app_entrega_transportadora_id_8034867d_fk_app_transportadora_id` (`transportadora_id`),
    CONSTRAINT `app_entrega_compra_produto_id_3edf2466_fk_app_compraproduto_id` FOREIGN KEY (`compra_produto_id`) REFERENCES `app_compraproduto` (`id`),
    CONSTRAINT `app_entrega_transportadora_id_8034867d_fk_app_transportadora_id` FOREIGN KEY (`transportadora_id`) REFERENCES `app_transportadora` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_entrega`
--

LOCK TABLES `app_entrega` WRITE;
/*!40000 ALTER TABLE `app_entrega`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_entrega`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_estoque`
--

DROP TABLE IF EXISTS `app_estoque`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_estoque`
(
    `id`          bigint       NOT NULL AUTO_INCREMENT,
    `quantidade`  int unsigned NOT NULL,
    `localizacao` varchar(70) DEFAULT NULL,
    `produto_id`  bigint       NOT NULL,
    PRIMARY KEY (`id`),
    KEY `app_estoque_produto_id_d8dc6d93_fk_app_produto_id` (`produto_id`),
    CONSTRAINT `app_estoque_produto_id_d8dc6d93_fk_app_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `app_produto` (`id`),
    CONSTRAINT `app_estoque_chk_1` CHECK ((`quantidade` >= 0))
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_estoque`
--

LOCK TABLES `app_estoque` WRITE;
/*!40000 ALTER TABLE `app_estoque`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_estoque`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_listadesejos`
--

DROP TABLE IF EXISTS `app_listadesejos`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_listadesejos`
(
    `usuario_id` int NOT NULL,
    PRIMARY KEY (`usuario_id`),
    CONSTRAINT `app_listadesejos_usuario_id_c276afc3_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_listadesejos`
--

LOCK TABLES `app_listadesejos` WRITE;
/*!40000 ALTER TABLE `app_listadesejos`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_listadesejos`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_listadesejos_produtos`
--

DROP TABLE IF EXISTS `app_listadesejos_produtos`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_listadesejos_produtos`
(
    `id`              bigint NOT NULL AUTO_INCREMENT,
    `listadesejos_id` int    NOT NULL,
    `produto_id`      bigint NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `app_listadesejos_produto_listadesejos_id_produto__49a1a5e2_uniq` (`listadesejos_id`, `produto_id`),
    KEY `app_listadesejos_produtos_produto_id_3ba4793b_fk_app_produto_id` (`produto_id`),
    CONSTRAINT `app_listadesejos_pro_listadesejos_id_f6618497_fk_app_lista` FOREIGN KEY (`listadesejos_id`) REFERENCES `app_listadesejos` (`usuario_id`),
    CONSTRAINT `app_listadesejos_produtos_produto_id_3ba4793b_fk_app_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `app_produto` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_listadesejos_produtos`
--

LOCK TABLES `app_listadesejos_produtos` WRITE;
/*!40000 ALTER TABLE `app_listadesejos_produtos`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_listadesejos_produtos`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_pix`
--

DROP TABLE IF EXISTS `app_pix`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_pix`
(
    `id`         bigint       NOT NULL AUTO_INCREMENT,
    `chave`      varchar(100) NOT NULL,
    `usuario_id` int          NOT NULL,
    PRIMARY KEY (`id`),
    KEY `app_pix_usuario_id_da258565_fk_auth_user_id` (`usuario_id`),
    CONSTRAINT `app_pix_usuario_id_da258565_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_pix`
--

LOCK TABLES `app_pix` WRITE;
/*!40000 ALTER TABLE `app_pix`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_pix`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_produto`
--

DROP TABLE IF EXISTS `app_produto`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_produto`
(
    `id`        bigint         NOT NULL AUTO_INCREMENT,
    `nome`      varchar(50)    NOT NULL,
    `preco`     decimal(10, 2) NOT NULL,
    `descricao` longtext,
    `is_ativo`  tinyint(1)     NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_produto`
--

LOCK TABLES `app_produto` WRITE;
/*!40000 ALTER TABLE `app_produto`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_produto`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_promocao`
--

DROP TABLE IF EXISTS `app_promocao`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_promocao`
(
    `id`          bigint      NOT NULL AUTO_INCREMENT,
    `nome`        varchar(100) DEFAULT NULL,
    `data_inicio` datetime(6) NOT NULL,
    `data_fim`    datetime(6) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_promocao`
--

LOCK TABLES `app_promocao` WRITE;
/*!40000 ALTER TABLE `app_promocao`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_promocao`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_promocaoproduto`
--

DROP TABLE IF EXISTS `app_promocaoproduto`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_promocaoproduto`
(
    `id`          bigint         NOT NULL AUTO_INCREMENT,
    `desconto`    decimal(10, 2) NOT NULL,
    `produto_id`  bigint         NOT NULL,
    `promocao_id` bigint         NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `app_promocaoproduto_produto_id_promocao_id_14227995_uniq` (`produto_id`, `promocao_id`),
    KEY `app_promocaoproduto_promocao_id_83544f90_fk_app_promocao_id` (`promocao_id`),
    CONSTRAINT `app_promocaoproduto_produto_id_7bcb398f_fk_app_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `app_produto` (`id`),
    CONSTRAINT `app_promocaoproduto_promocao_id_83544f90_fk_app_promocao_id` FOREIGN KEY (`promocao_id`) REFERENCES `app_promocao` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_promocaoproduto`
--

LOCK TABLES `app_promocaoproduto` WRITE;
/*!40000 ALTER TABLE `app_promocaoproduto`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_promocaoproduto`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_transportadora`
--

DROP TABLE IF EXISTS `app_transportadora`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_transportadora`
(
    `id`                 bigint       NOT NULL AUTO_INCREMENT,
    `nome`               varchar(100) NOT NULL,
    `cnpj`               varchar(20)  NOT NULL,
    `inscricao_estadual` varchar(100) NOT NULL,
    `telefone`           varchar(20)  NOT NULL,
    `email`              varchar(100) NOT NULL,
    `preco_km`           decimal(10, 2) DEFAULT NULL,
    `endereco`           varchar(100)   DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `cnpj` (`cnpj`),
    UNIQUE KEY `inscricao_estadual` (`inscricao_estadual`),
    UNIQUE KEY `email` (`email`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_transportadora`
--

LOCK TABLES `app_transportadora` WRITE;
/*!40000 ALTER TABLE `app_transportadora`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `app_transportadora`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group`
(
    `id`   int          NOT NULL AUTO_INCREMENT,
    `name` varchar(150) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions`
(
    `id`            bigint NOT NULL AUTO_INCREMENT,
    `group_id`      int    NOT NULL,
    `permission_id` int    NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`, `permission_id`),
    KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
    CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
    CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission`
(
    `id`              int          NOT NULL AUTO_INCREMENT,
    `name`            varchar(255) NOT NULL,
    `content_type_id` int          NOT NULL,
    `codename`        varchar(100) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`, `codename`),
    CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 93
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission`
    DISABLE KEYS */;
INSERT INTO `auth_permission`
VALUES (1, 'Can add log entry', 1, 'add_logentry'),
       (2, 'Can change log entry', 1, 'change_logentry'),
       (3, 'Can delete log entry', 1, 'delete_logentry'),
       (4, 'Can view log entry', 1, 'view_logentry'),
       (5, 'Can add permission', 2, 'add_permission'),
       (6, 'Can change permission', 2, 'change_permission'),
       (7, 'Can delete permission', 2, 'delete_permission'),
       (8, 'Can view permission', 2, 'view_permission'),
       (9, 'Can add group', 3, 'add_group'),
       (10, 'Can change group', 3, 'change_group'),
       (11, 'Can delete group', 3, 'delete_group'),
       (12, 'Can view group', 3, 'view_group'),
       (13, 'Can add user', 4, 'add_user'),
       (14, 'Can change user', 4, 'change_user'),
       (15, 'Can delete user', 4, 'delete_user'),
       (16, 'Can view user', 4, 'view_user'),
       (17, 'Can add content type', 5, 'add_contenttype'),
       (18, 'Can change content type', 5, 'change_contenttype'),
       (19, 'Can delete content type', 5, 'delete_contenttype'),
       (20, 'Can view content type', 5, 'view_contenttype'),
       (21, 'Can add session', 6, 'add_session'),
       (22, 'Can change session', 6, 'change_session'),
       (23, 'Can delete session', 6, 'delete_session'),
       (24, 'Can view session', 6, 'view_session'),
       (25, 'Can add CompraProduto', 7, 'add_compraproduto'),
       (26, 'Can change CompraProduto', 7, 'change_compraproduto'),
       (27, 'Can delete CompraProduto', 7, 'delete_compraproduto'),
       (28, 'Can view CompraProduto', 7, 'view_compraproduto'),
       (29, 'Can add Carrinho', 8, 'add_carrinho'),
       (30, 'Can change Carrinho', 8, 'change_carrinho'),
       (31, 'Can delete Carrinho', 8, 'delete_carrinho'),
       (32, 'Can view Carrinho', 8, 'view_carrinho'),
       (33, 'Can add Compra', 9, 'add_compra'),
       (34, 'Can change Compra', 9, 'change_compra'),
       (35, 'Can delete Compra', 9, 'delete_compra'),
       (36, 'Can view Compra', 9, 'view_compra'),
       (37, 'Can add Produto', 10, 'add_produto'),
       (38, 'Can change Produto', 10, 'change_produto'),
       (39, 'Can delete Produto', 10, 'delete_produto'),
       (40, 'Can view Produto', 10, 'view_produto'),
       (41, 'Can add Promocao', 11, 'add_promocao'),
       (42, 'Can change Promocao', 11, 'change_promocao'),
       (43, 'Can delete Promocao', 11, 'delete_promocao'),
       (44, 'Can view Promocao', 11, 'view_promocao'),
       (45, 'Can add Transportadora', 12, 'add_transportadora'),
       (46, 'Can change Transportadora', 12, 'change_transportadora'),
       (47, 'Can delete Transportadora', 12, 'delete_transportadora'),
       (48, 'Can view Transportadora', 12, 'view_transportadora'),
       (49, 'Can add Avaliacao', 13, 'add_avaliacao'),
       (50, 'Can change Avaliacao', 13, 'change_avaliacao'),
       (51, 'Can delete Avaliacao', 13, 'delete_avaliacao'),
       (52, 'Can view Avaliacao', 13, 'view_avaliacao'),
       (53, 'Can add Cartao', 14, 'add_cartao'),
       (54, 'Can change Cartao', 14, 'change_cartao'),
       (55, 'Can delete Cartao', 14, 'delete_cartao'),
       (56, 'Can view Cartao', 14, 'view_cartao'),
       (57, 'Can add Cupom', 15, 'add_cupom'),
       (58, 'Can change Cupom', 15, 'change_cupom'),
       (59, 'Can delete Cupom', 15, 'delete_cupom'),
       (60, 'Can view Cupom', 15, 'view_cupom'),
       (61, 'Can add Endereco', 16, 'add_endereco'),
       (62, 'Can change Endereco', 16, 'change_endereco'),
       (63, 'Can delete Endereco', 16, 'delete_endereco'),
       (64, 'Can view Endereco', 16, 'view_endereco'),
       (65, 'Can add Pix', 17, 'add_pix'),
       (66, 'Can change Pix', 17, 'change_pix'),
       (67, 'Can delete Pix', 17, 'delete_pix'),
       (68, 'Can view Pix', 17, 'view_pix'),
       (69, 'Can add ListaDesejos', 18, 'add_listadesejos'),
       (70, 'Can change ListaDesejos', 18, 'change_listadesejos'),
       (71, 'Can delete ListaDesejos', 18, 'delete_listadesejos'),
       (72, 'Can view ListaDesejos', 18, 'view_listadesejos'),
       (73, 'Can add Estoque', 19, 'add_estoque'),
       (74, 'Can change Estoque', 19, 'change_estoque'),
       (75, 'Can delete Estoque', 19, 'delete_estoque'),
       (76, 'Can view Estoque', 19, 'view_estoque'),
       (77, 'Can add Categoria', 20, 'add_categoria'),
       (78, 'Can change Categoria', 20, 'change_categoria'),
       (79, 'Can delete Categoria', 20, 'delete_categoria'),
       (80, 'Can view Categoria', 20, 'view_categoria'),
       (81, 'Can add CarrinhoProduto', 21, 'add_carrinhoproduto'),
       (82, 'Can change CarrinhoProduto', 21, 'change_carrinhoproduto'),
       (83, 'Can delete CarrinhoProduto', 21, 'delete_carrinhoproduto'),
       (84, 'Can view CarrinhoProduto', 21, 'view_carrinhoproduto'),
       (85, 'Can add PromocaoProduto', 22, 'add_promocaoproduto'),
       (86, 'Can change PromocaoProduto', 22, 'change_promocaoproduto'),
       (87, 'Can delete PromocaoProduto', 22, 'delete_promocaoproduto'),
       (88, 'Can view PromocaoProduto', 22, 'view_promocaoproduto'),
       (89, 'Can add Entrega', 23, 'add_entrega'),
       (90, 'Can change Entrega', 23, 'change_entrega'),
       (91, 'Can delete Entrega', 23, 'delete_entrega'),
       (92, 'Can view Entrega', 23, 'view_entrega');
/*!40000 ALTER TABLE `auth_permission`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user`
(
    `id`           int          NOT NULL AUTO_INCREMENT,
    `password`     varchar(128) NOT NULL,
    `last_login`   datetime(6) DEFAULT NULL,
    `is_superuser` tinyint(1)   NOT NULL,
    `username`     varchar(150) NOT NULL,
    `first_name`   varchar(150) NOT NULL,
    `last_name`    varchar(150) NOT NULL,
    `email`        varchar(254) NOT NULL,
    `is_staff`     tinyint(1)   NOT NULL,
    `is_active`    tinyint(1)   NOT NULL,
    `date_joined`  datetime(6)  NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `username` (`username`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups`
(
    `id`       bigint NOT NULL AUTO_INCREMENT,
    `user_id`  int    NOT NULL,
    `group_id` int    NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`, `group_id`),
    KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
    CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
    CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions`
(
    `id`            bigint NOT NULL AUTO_INCREMENT,
    `user_id`       int    NOT NULL,
    `permission_id` int    NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`, `permission_id`),
    KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
    CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
    CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log`
(
    `id`              int               NOT NULL AUTO_INCREMENT,
    `action_time`     datetime(6)       NOT NULL,
    `object_id`       longtext,
    `object_repr`     varchar(200)      NOT NULL,
    `action_flag`     smallint unsigned NOT NULL,
    `change_message`  longtext          NOT NULL,
    `content_type_id` int DEFAULT NULL,
    `user_id`         int               NOT NULL,
    PRIMARY KEY (`id`),
    KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
    KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
    CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
    CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
    CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type`
(
    `id`        int          NOT NULL AUTO_INCREMENT,
    `app_label` varchar(100) NOT NULL,
    `model`     varchar(100) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`, `model`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 24
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type`
    DISABLE KEYS */;
INSERT INTO `django_content_type`
VALUES (1, 'admin', 'logentry'),
       (13, 'app', 'avaliacao'),
       (8, 'app', 'carrinho'),
       (21, 'app', 'carrinhoproduto'),
       (14, 'app', 'cartao'),
       (20, 'app', 'categoria'),
       (9, 'app', 'compra'),
       (7, 'app', 'compraproduto'),
       (15, 'app', 'cupom'),
       (16, 'app', 'endereco'),
       (23, 'app', 'entrega'),
       (19, 'app', 'estoque'),
       (18, 'app', 'listadesejos'),
       (17, 'app', 'pix'),
       (10, 'app', 'produto'),
       (11, 'app', 'promocao'),
       (22, 'app', 'promocaoproduto'),
       (12, 'app', 'transportadora'),
       (3, 'auth', 'group'),
       (2, 'auth', 'permission'),
       (4, 'auth', 'user'),
       (5, 'contenttypes', 'contenttype'),
       (6, 'sessions', 'session');
/*!40000 ALTER TABLE `django_content_type`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations`
(
    `id`      bigint       NOT NULL AUTO_INCREMENT,
    `app`     varchar(255) NOT NULL,
    `name`    varchar(255) NOT NULL,
    `applied` datetime(6)  NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 20
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations`
    DISABLE KEYS */;
INSERT INTO `django_migrations`
VALUES (1, 'contenttypes', '0001_initial', '2024-12-02 22:12:07.190741'),
       (2, 'auth', '0001_initial', '2024-12-02 22:12:10.030352'),
       (3, 'admin', '0001_initial', '2024-12-02 22:12:10.862353'),
       (4, 'admin', '0002_logentry_remove_auto_add', '2024-12-02 22:12:10.907351'),
       (5, 'admin', '0003_logentry_add_action_flag_choices', '2024-12-02 22:12:10.938352'),
       (6, 'contenttypes', '0002_remove_content_type_name', '2024-12-02 22:12:11.434002'),
       (7, 'auth', '0002_alter_permission_name_max_length', '2024-12-02 22:12:11.723987'),
       (8, 'auth', '0003_alter_user_email_max_length', '2024-12-02 22:12:11.812982'),
       (9, 'auth', '0004_alter_user_username_opts', '2024-12-02 22:12:11.838983'),
       (10, 'auth', '0005_alter_user_last_login_null', '2024-12-02 22:12:12.063983'),
       (11, 'auth', '0006_require_contenttypes_0002', '2024-12-02 22:12:12.080024'),
       (12, 'auth', '0007_alter_validators_add_error_messages', '2024-12-02 22:12:12.104985'),
       (13, 'auth', '0008_alter_user_username_max_length', '2024-12-02 22:12:12.387985'),
       (14, 'auth', '0009_alter_user_last_name_max_length', '2024-12-02 22:12:12.694984'),
       (15, 'auth', '0010_alter_group_name_max_length', '2024-12-02 22:12:12.796985'),
       (16, 'auth', '0011_update_proxy_permissions', '2024-12-02 22:12:12.844985'),
       (17, 'auth', '0012_alter_user_first_name_max_length', '2024-12-02 22:12:13.270353'),
       (18, 'app', '0001_initial', '2024-12-02 22:12:26.441893'),
       (19, 'sessions', '0001_initial', '2024-12-02 22:12:26.960891');
/*!40000 ALTER TABLE `django_migrations`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session`
(
    `session_key`  varchar(40) NOT NULL,
    `session_data` longtext    NOT NULL,
    `expire_date`  datetime(6) NOT NULL,
    PRIMARY KEY (`session_key`),
    KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session`
    ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;

-- Dump completed on 2024-12-02 19:16:49
