-- MySQL dump 10.15  Distrib 10.0.35-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: exomehg19
-- ------------------------------------------------------
-- Server version	10.0.35-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chipseqstats`
--

DROP TABLE IF EXISTS `chipseqstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chipseqstats` (
  `idchipseqstats` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idsample` int(11) unsigned NOT NULL,
  `idsamplecontrol` int(11) unsigned DEFAULT NULL,
  `uniquereads` int(11) unsigned DEFAULT '0',
  `peaks` int(11) unsigned DEFAULT '0',
  `nrf` float DEFAULT '0',
  `frip` float DEFAULT '0',
  `codingpeaks` float DEFAULT '0',
  `idsampleoverlap` int(11) unsigned DEFAULT NULL,
  `overlap` float DEFAULT NULL,
  `broad` tinyint(1) DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nsc` float DEFAULT NULL,
  `rsc` float DEFAULT NULL,
  `qualitytag` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`idchipseqstats`),
  UNIQUE KEY `chipseqstatidsample` (`idsample`,`idsamplecontrol`,`idsampleoverlap`),
  KEY `chipseqstatsamplecontrol` (`idsamplecontrol`),
  KEY `chipseqstatsampleoverlap` (`idsampleoverlap`),
  CONSTRAINT `chipseqstatsample` FOREIGN KEY (`idsample`) REFERENCES `sample` (`idsample`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `chipseqstatsamplecontrol` FOREIGN KEY (`idsamplecontrol`) REFERENCES `sample` (`idsample`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `chipseqstatsampleoverlap` FOREIGN KEY (`idsampleoverlap`) REFERENCES `sample` (`idsample`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=569 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cooperation`
--

DROP TABLE IF EXISTS `cooperation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cooperation` (
  `idcooperation` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `prename` varchar(100) DEFAULT '',
  `institution` varchar(255) DEFAULT '',
  `email` varchar(100) DEFAULT '',
  `phone` varchar(100) DEFAULT '',
  `department` varchar(255) DEFAULT '',
  `comment` varchar(255) DEFAULT '',
  `sendemail` tinyint(1) NOT NULL DEFAULT '0',
  `sendstatus` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idcooperation`),
  UNIQUE KEY `cname` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disease`
--

DROP TABLE IF EXISTS `disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disease` (
  `iddisease` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `symbol` varchar(20) NOT NULL DEFAULT '',
  `omimid` varchar(20) DEFAULT NULL,
  `iddiseasegroup` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`iddisease`),
  UNIQUE KEY `dname` (`name`),
  KEY `dsymbol` (`symbol`),
  KEY `fk_diseasegroup` (`iddiseasegroup`),
  CONSTRAINT `fk_diseasegroup` FOREIGN KEY (`iddiseasegroup`) REFERENCES `diseasegroup` (`iddiseasegroup`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=539 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disease2gene`
--

DROP TABLE IF EXISTS `disease2gene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disease2gene` (
  `iddisease2gene` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `iddisease` int(11) unsigned NOT NULL,
  `idgene` int(11) unsigned NOT NULL,
  `class` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddisease2gene`),
  UNIQUE KEY `iddisease2gene_UNIQUE` (`iddisease2gene`),
  UNIQUE KEY `diseasegene` (`iddisease`,`idgene`),
  KEY `d2giddisease` (`iddisease`),
  KEY `d2gidgene` (`idgene`),
  CONSTRAINT `d2giddisease` FOREIGN KEY (`iddisease`) REFERENCES `disease` (`iddisease`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `d2gidgene` FOREIGN KEY (`idgene`) REFERENCES `gene` (`idgene`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40977 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disease2sample`
--

DROP TABLE IF EXISTS `disease2sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disease2sample` (
  `iddisease2sample` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `iddisease` int(11) unsigned NOT NULL,
  `idsample` int(11) unsigned NOT NULL,
  PRIMARY KEY (`iddisease2sample`),
  UNIQUE KEY `iddisease2sample_UNIQUE` (`iddisease2sample`),
  UNIQUE KEY `d2siddiseaseidsample` (`iddisease`,`idsample`),
  KEY `d2siddisease` (`iddisease`),
  KEY `d2sidsample` (`idsample`),
  CONSTRAINT `d2siddisease` FOREIGN KEY (`iddisease`) REFERENCES `disease` (`iddisease`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `d2sidsample` FOREIGN KEY (`idsample`) REFERENCES `sample` (`idsample`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=81867 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diseasegroup`
--

DROP TABLE IF EXISTS `diseasegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diseasegroup` (
  `iddiseasegroup` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`iddiseasegroup`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exomestat`
--

DROP TABLE IF EXISTS `exomestat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exomestat` (
  `idexomestat` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idsample` int(11) unsigned NOT NULL,
  `duplicates` decimal(5,2) unsigned DEFAULT NULL,
  `reads` int(11) unsigned DEFAULT NULL,
  `mapped` int(11) unsigned DEFAULT NULL,
  `percentm` decimal(5,2) unsigned DEFAULT NULL,
  `seq` decimal(18,3) unsigned DEFAULT NULL,
  `onbait` decimal(5,2) unsigned DEFAULT NULL,
  `avgcov` decimal(7,2) unsigned DEFAULT NULL,
  `uncovered` decimal(5,2) unsigned DEFAULT NULL,
  `cov1x` decimal(5,2) unsigned DEFAULT NULL,
  `cov4x` decimal(5,2) unsigned DEFAULT NULL,
  `cov8x` decimal(5,2) unsigned DEFAULT NULL,
  `cov20x` decimal(5,2) unsigned DEFAULT NULL,
  `tstv` decimal(5,2) DEFAULT NULL,
  `idlibtype` int(11) unsigned NOT NULL,
  `sry` int(11) unsigned DEFAULT NULL,
  `idlibpair` int(11) unsigned NOT NULL,
  `mix` float DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `avgcovstd` decimal(5,2) unsigned DEFAULT NULL,
  `mediancov` decimal(5,2) unsigned DEFAULT NULL,
  `mediancovstd` decimal(5,2) unsigned DEFAULT NULL,
  `exomedepthrsd` float DEFAULT NULL,
  `idassay` int(11) unsigned DEFAULT NULL,
  `mismatchrate` float DEFAULT NULL,
  `avgqual` float DEFAULT NULL,
  `avgquallast5` float DEFAULT NULL,
  `libcomplexity` float DEFAULT NULL,
  `q30fraction` float DEFAULT NULL,
  `opticalduplicates` decimal(5,2) unsigned DEFAULT NULL,
  `avgdiffdepth` decimal(5,2) DEFAULT NULL,
  `properlyp` decimal(5,2) unsigned DEFAULT NULL,
  `datelast` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idexomestat`),
  UNIQUE KEY `exomeidsample` (`idlibtype`,`idlibpair`,`idsample`),
  KEY `exomestatsample` (`idsample`),
  KEY `exomestatlibpair` (`idlibpair`),
  CONSTRAINT `exomestatsample` FOREIGN KEY (`idsample`) REFERENCES `sample` (`idsample`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=114525 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gene`
--

DROP TABLE IF EXISTS `gene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gene` (
  `idgene` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `genesymbol` varchar(150) NOT NULL DEFAULT '',
  `omim` varchar(45) DEFAULT '',
  `blacklist` tinyint(3) unsigned DEFAULT '0',
  `nonsynpergene` int(10) unsigned NOT NULL,
  `maxpeplength` int(10) unsigned DEFAULT NULL,
  `meanreaddepth` float DEFAULT NULL,
  `readdepth20` float DEFAULT NULL,
  `delpergene` int(10) unsigned NOT NULL,
  `cgd` set('','AD','AR','XL','BG','Digenic','Methylation','Maternal','Paternal','Multigenic','PAR') DEFAULT NULL,
  PRIMARY KEY (`idgene`),
  UNIQUE KEY `genesymbol` (`genesymbol`),
  KEY `omim` (`omim`)
) ENGINE=InnoDB AUTO_INCREMENT=856921 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpo`
--

DROP TABLE IF EXISTS `hpo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpo` (
  `id` char(10) DEFAULT NULL,
  `name` varchar(255) DEFAULT '',
  `def` varchar(3000) DEFAULT '',
  `ic` float DEFAULT '0',
  KEY `hpoid` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpoancestors`
--

DROP TABLE IF EXISTS `hpoancestors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpoancestors` (
  `id` char(10) DEFAULT NULL,
  `ancestor` char(10) DEFAULT NULL,
  KEY `hpoancestorsid` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpogene`
--

DROP TABLE IF EXISTS `hpogene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpogene` (
  `id` char(10) DEFAULT NULL,
  `name` varchar(255) DEFAULT '',
  `geneid` int(11) unsigned DEFAULT '0',
  `gene` char(20) DEFAULT '',
  KEY `hpogenehpo` (`id`),
  KEY `hpogenegene` (`gene`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpoisa`
--

DROP TABLE IF EXISTS `hpoisa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpoisa` (
  `idisa` char(10) DEFAULT NULL,
  `id` char(10) DEFAULT NULL,
  `name` varchar(255) DEFAULT '',
  KEY `hpisaoid` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hposynonym`
--

DROP TABLE IF EXISTS `hposynonym`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hposynonym` (
  `id` char(10) DEFAULT NULL,
  `synonym` varchar(255) DEFAULT '',
  KEY `hpoid` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `idinvoice` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `my` varchar(45) NOT NULL,
  `mydate` date NOT NULL,
  `fa` varchar(45) DEFAULT NULL,
  `fadate` date DEFAULT NULL,
  `sum` decimal(11,2) NOT NULL DEFAULT '0.00',
  `comment` blob,
  `pspelement` varchar(45) NOT NULL DEFAULT '',
  `exome` decimal(8,2) NOT NULL DEFAULT '0.00',
  `genome` decimal(8,2) NOT NULL DEFAULT '0.00',
  `costs` decimal(11,2) NOT NULL DEFAULT '0.00',
  `storage` decimal(11,3) NOT NULL DEFAULT '0.000',
  `lanewithout` decimal(11,3) NOT NULL DEFAULT '0.000',
  `lane` decimal(11,3) NOT NULL DEFAULT '0.000',
  `funds` decimal(11,2) NOT NULL DEFAULT '0.00',
  `exomelibwithout` decimal(8,2) NOT NULL DEFAULT '0.00',
  `genomelibwithout` decimal(8,2) NOT NULL DEFAULT '0.00',
  `bioinformatics` decimal(8,3) NOT NULL DEFAULT '0.000',
  `exomelibextern` decimal(8,2) NOT NULL DEFAULT '0.00',
  `genomelibextern` decimal(8,2) NOT NULL DEFAULT '0.00',
  `lane100` decimal(8,3) NOT NULL DEFAULT '0.000',
  `lanewithout100` decimal(8,3) NOT NULL DEFAULT '0.000',
  `lane50` decimal(8,3) NOT NULL DEFAULT '0.000',
  `lanewithout50` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S4_150` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S4_100` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S2_150` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S2_100` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S2_50` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S1_150` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S1_100` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S1_50` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S4_150without` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S4_100without` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S2_150without` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S2_100without` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S2_50without` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S1_150without` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S1_100without` decimal(8,3) NOT NULL DEFAULT '0.000',
  `S1_50without` decimal(8,3) NOT NULL DEFAULT '0.000',
  `ilvinstitute` varchar(255) DEFAULT '',
  `idcooperation` int(11) DEFAULT NULL,
  `lastdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idinvoice`),
  UNIQUE KEY `my` (`my`)
) ENGINE=InnoDB AUTO_INCREMENT=667 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mouse`
--

DROP TABLE IF EXISTS `mouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mouse` (
  `humanSymbol` varchar(150) NOT NULL DEFAULT '',
  `humanEntrezId` varchar(45) NOT NULL DEFAULT '',
  `homoloGeneId` varchar(45) NOT NULL DEFAULT '',
  `mouseSymbol` varchar(45) NOT NULL DEFAULT '',
  `mgiId` varchar(45) NOT NULL DEFAULT '',
  `phenotypeID` varchar(255) NOT NULL DEFAULT '',
  KEY `humanSymbol` (`humanSymbol`),
  KEY `mouseSymbol` (`mouseSymbol`),
  KEY `symbolid` (`humanSymbol`,`mgiId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `omim`
--

DROP TABLE IF EXISTS `omim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `omim` (
  `omimdisease` int(11) unsigned DEFAULT NULL,
  `disease` varchar(255) NOT NULL,
  `omimgene` int(11) unsigned NOT NULL,
  `inheritance` set('unknown','ad','ar','x','somatic','mocaicism','sporadic','polygenic') NOT NULL,
  `comment` varchar(255) NOT NULL,
  KEY `omimdisease` (`omimdisease`),
  KEY `omimgene` (`omimgene`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `omimfulltext`
--

DROP TABLE IF EXISTS `omimfulltext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `omimfulltext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `omim_id` int(11) unsigned NOT NULL,
  `omim_cs` longtext NOT NULL,
  `omim_fulltext` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26515 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organism`
--

DROP TABLE IF EXISTS `organism`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organism` (
  `idorganism` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `orname` varchar(100) NOT NULL,
  `ormenuflag` varchar(1) DEFAULT 'T',
  PRIMARY KEY (`idorganism`),
  UNIQUE KEY `orname_UNIQUE` (`orname`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `percentcoverage`
--

DROP TABLE IF EXISTS `percentcoverage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `percentcoverage` (
  `idexomestat` int(11) unsigned NOT NULL DEFAULT '0',
  `covx` int(11) unsigned NOT NULL DEFAULT '0',
  `percent` double DEFAULT NULL,
  PRIMARY KEY (`idexomestat`,`covx`),
  CONSTRAINT `percentcoverage_idexomestat` FOREIGN KEY (`idexomestat`) REFERENCES `exomestat` (`idexomestat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pipeline`
--

DROP TABLE IF EXISTS `pipeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pipeline` (
  `idpipeline` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idsample` int(11) unsigned NOT NULL,
  `idlibtype` int(11) unsigned NOT NULL,
  `idlibpair` int(11) unsigned NOT NULL,
  `status` enum('started','finished','failed') DEFAULT NULL,
  `starttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `numofvars` int(11) unsigned DEFAULT '0',
  `numofsvs` int(11) unsigned DEFAULT '0',
  `numofcnvs` int(11) unsigned DEFAULT '0',
  `errors` int(11) unsigned DEFAULT NULL,
  `logfile` varchar(255) DEFAULT NULL,
  `pipelinegitversion` char(40) DEFAULT NULL,
  `executedscripts` blob,
  `programversions` blob,
  `currentsettings` varchar(100) DEFAULT NULL,
  `seq` decimal(18,3) unsigned DEFAULT NULL,
  `duplicates` decimal(5,2) unsigned DEFAULT NULL,
  `cov20x` decimal(5,2) unsigned DEFAULT NULL,
  `exomedepthrsd` float DEFAULT NULL,
  `sry` int(11) unsigned DEFAULT NULL,
  `mix` float DEFAULT NULL,
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `outputdir` varchar(255) DEFAULT NULL,
  `snvsampleImportFile` varchar(255) DEFAULT NULL,
  `ready2importsnvsample` int(1) unsigned DEFAULT '0',
  `snvsampleimportFinished` int(1) unsigned DEFAULT '0',
  PRIMARY KEY (`idpipeline`),
  KEY `idsample_pipeline` (`idsample`),
  CONSTRAINT `idsample_pipeline` FOREIGN KEY (`idsample`) REFERENCES `sample` (`idsample`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=152614 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `idproject` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pname` varchar(100) NOT NULL,
  `pdescription` varchar(100) DEFAULT '',
  `pcomment` varchar(255) DEFAULT '',
  `pcontact` varchar(100) DEFAULT '',
  `pdate` date DEFAULT NULL,
  `pmenuflag` varchar(1) NOT NULL DEFAULT 'T',
  `pversion` int(11) unsigned NOT NULL DEFAULT '0',
  `user` int(10) unsigned DEFAULT NULL,
  `institution` varchar(100) DEFAULT '',
  `department` varchar(100) DEFAULT '',
  `idcooperation` int(11) DEFAULT NULL,
  PRIMARY KEY (`idproject`),
  UNIQUE KEY `pname_UNIQUE` (`pname`)
) ENGINE=InnoDB AUTO_INCREMENT=314 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rnaseqcstat`
--

DROP TABLE IF EXISTS `rnaseqcstat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rnaseqcstat` (
  `idrnaseqcstats` int(12) unsigned NOT NULL AUTO_INCREMENT,
  `idsample` int(11) unsigned NOT NULL,
  `mapper` enum('gem','star','tophat') NOT NULL,
  `file` enum('merged.rmdup.bam','merged.bam') NOT NULL,
  `intergenicRate` double unsigned DEFAULT NULL,
  `intragenicRate` double unsigned DEFAULT NULL,
  `exonicRate` double unsigned DEFAULT NULL,
  `intronicRate` double unsigned DEFAULT NULL,
  `mapped` bigint(20) unsigned DEFAULT NULL,
  `mappingRate` double unsigned DEFAULT NULL,
  `mappedPairs` bigint(20) unsigned DEFAULT NULL,
  `mappedUnique` bigint(20) unsigned DEFAULT NULL,
  `duplicationRateOfMapped` double unsigned DEFAULT NULL,
  `mappedUniqueRateofTotal` double unsigned DEFAULT NULL,
  `uniqueRateOfMapped` double unsigned DEFAULT NULL,
  `unpairedReads` int(12) unsigned DEFAULT NULL,
  `chimericPairs` int(12) unsigned DEFAULT NULL,
  `alternativeAligments` int(12) unsigned DEFAULT NULL,
  `splitReads` bigint(20) unsigned DEFAULT NULL,
  `readLength` int(5) unsigned DEFAULT NULL,
  `fragmentLengthMean` int(5) unsigned DEFAULT NULL,
  `fragmentLengthStdDev` int(5) unsigned DEFAULT NULL,
  `rRNA` int(12) unsigned DEFAULT NULL,
  `rRNARate` double unsigned DEFAULT NULL,
  `end1Sense` int(12) unsigned DEFAULT NULL,
  `end2Sense` int(12) unsigned DEFAULT NULL,
  `end1PercentSense` double unsigned DEFAULT NULL,
  `end2PercentSense` double unsigned DEFAULT NULL,
  `end1Antisense` int(12) unsigned DEFAULT NULL,
  `end2Antisense` int(12) unsigned DEFAULT NULL,
  `end1MappingRate` double unsigned DEFAULT NULL,
  `end2MappingRate` double unsigned DEFAULT NULL,
  `end1MismatchRate` double unsigned DEFAULT NULL,
  `end2MismatchRate` double unsigned DEFAULT NULL,
  `norm5p` double unsigned DEFAULT NULL,
  `norm3p` double unsigned DEFAULT NULL,
  `noCovered5p` int(10) unsigned DEFAULT NULL,
  `genesDetected` double unsigned DEFAULT NULL,
  `transcriptsDetected` int(10) unsigned DEFAULT NULL,
  `numGaps` int(10) unsigned DEFAULT NULL,
  `cumulGapLength` int(8) unsigned DEFAULT NULL,
  `gapPercent` double unsigned DEFAULT NULL,
  `meanCV` double unsigned DEFAULT NULL,
  `meanPerBaseCov` double unsigned DEFAULT NULL,
  `baseMismatchRate` double unsigned DEFAULT NULL,
  `estimatedLibrarySize` double unsigned DEFAULT NULL,
  `totalPurityFilteredReadsSequenced` int(12) unsigned DEFAULT NULL,
  `failedVendorQCCheck` double unsigned DEFAULT NULL,
  `expressionProfilingEfficiency` double unsigned DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idrnaseqcstats`),
  KEY `rnaseqcstats_idsample_index` (`idsample`) USING BTREE,
  CONSTRAINT `rnaseqcstats_idsample` FOREIGN KEY (`idsample`) REFERENCES `sample` (`idsample`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9859 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample` (
  `idsample` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `foreignid` varchar(45) DEFAULT '',
  `name` varchar(45) NOT NULL,
  `sex` enum('unknown','male','female') NOT NULL,
  `pedigree` varchar(45) DEFAULT NULL,
  `idcooperation` int(11) DEFAULT NULL,
  `analysis` enum('other','exome') NOT NULL,
  `idinvoice` int(11) unsigned DEFAULT NULL,
  `entered` date NOT NULL DEFAULT '0000-00-00',
  `scomment` varchar(1024) DEFAULT NULL,
  `sbarcode` varchar(100) DEFAULT NULL,
  `splate` varchar(100) DEFAULT NULL,
  `srow` varchar(1) DEFAULT NULL,
  `scolumn` varchar(2) DEFAULT NULL,
  `saffected` tinyint(3) unsigned DEFAULT '1',
  `snanodrop` float DEFAULT NULL,
  `sbam` varchar(255) DEFAULT '',
  `idproject` int(11) unsigned DEFAULT NULL,
  `father` int(11) unsigned DEFAULT NULL,
  `mother` int(11) unsigned DEFAULT NULL,
  `a260280` float DEFAULT NULL,
  `idorganism` int(11) unsigned NOT NULL,
  `nottoseq` int(1) DEFAULT '0',
  `volume` float DEFAULT NULL,
  `idtissue` int(11) DEFAULT NULL,
  `user` int(10) unsigned DEFAULT NULL,
  `a260230` float DEFAULT NULL,
  `chipseqcontrol` varchar(45) DEFAULT NULL,
  `tumorcontrol` varchar(45) DEFAULT NULL,
  `accounting` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`idsample`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `sbarcode_UNIQUE` (`sbarcode`),
  KEY `pedigree` (`pedigree`),
  KEY `cooperation` (`idcooperation`),
  KEY `idinvoice` (`idinvoice`),
  KEY `idproject` (`idproject`),
  KEY `idsampleped` (`idsample`,`pedigree`),
  KEY `pedidsample` (`pedigree`,`idsample`),
  CONSTRAINT `cooperation` FOREIGN KEY (`idcooperation`) REFERENCES `cooperation` (`idcooperation`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idinvoice` FOREIGN KEY (`idinvoice`) REFERENCES `invoice` (`idinvoice`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idproject` FOREIGN KEY (`idproject`) REFERENCES `project` (`idproject`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=80907 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tissue`
--

DROP TABLE IF EXISTS `tissue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tissue` (
  `idtissue` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `menuflag` varchar(1) DEFAULT 'T',
  PRIMARY KEY (`idtissue`),
  UNIQUE KEY `tissuename_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transcript`
--

DROP TABLE IF EXISTS `transcript`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transcript` (
  `idtranscript` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idgene` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `chrom` varchar(255) DEFAULT NULL,
  `exonStarts` longblob,
  `exonEnds` longblob,
  PRIMARY KEY (`idtranscript`),
  KEY `fk_transcript_gene` (`idgene`),
  KEY `transcript_name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=36542 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transcriptmedianstat`
--

DROP TABLE IF EXISTS `transcriptmedianstat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transcriptmedianstat` (
  `idtranscriptmedianstat` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idtranscript` int(10) unsigned NOT NULL,
  `idlibtype` int(10) unsigned NOT NULL,
  `idlibpair` int(10) unsigned NOT NULL,
  `avgdepth` longblob,
  `qdepth` longblob,
  `avgmapqual` longblob,
  `avgdepthtotal` float DEFAULT NULL,
  `qdepthtotal` float DEFAULT NULL,
  `avgmapqualtotal` float DEFAULT NULL,
  `type` enum('SureSelect38Mb','SureSelect50Mb','SureSelectMouse50Mb','SureSelect50Mbv4','SureSelect50Mbv5') DEFAULT NULL,
  PRIMARY KEY (`idtranscriptmedianstat`),
  UNIQUE KEY `transcriptstat-unique` (`type`,`idtranscript`,`idlibtype`,`idlibpair`),
  KEY `fk_transcriptmedianstat_transcript` (`idtranscript`),
  KEY `transcriptmedianstat-search` (`type`,`idtranscript`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=518300 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transcriptstat`
--

DROP TABLE IF EXISTS `transcriptstat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transcriptstat` (
  `idtranscriptstat` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idtranscript` int(10) unsigned NOT NULL,
  `idsample` int(10) unsigned NOT NULL,
  `idlibtype` int(10) unsigned NOT NULL,
  `idlibpair` int(10) unsigned NOT NULL,
  `avgdepth` longblob,
  `qdepth` longblob,
  `avgmapqual` longblob,
  `avgdepthtotal` float DEFAULT NULL,
  `qdepthtotal` float DEFAULT NULL,
  `avgmapqualtotal` float DEFAULT NULL,
  `idassay` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`idtranscriptstat`),
  UNIQUE KEY `idtranscriptstat_UNIQUE` (`idtranscriptstat`),
  UNIQUE KEY `transcriptstat-unique` (`idsample`,`idtranscript`,`idlibtype`,`idlibpair`),
  KEY `fk_transcriptstat_transcript` (`idtranscript`),
  KEY `fk_transcriptstat_sample` (`idsample`),
  KEY `transcriptstat-search` (`idsample`,`idtranscript`)
) ENGINE=MyISAM AUTO_INCREMENT=3137469598 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-25 13:57:14
