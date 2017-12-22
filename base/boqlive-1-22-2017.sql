-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 22, 2017 at 10:07 AM
-- Server version: 5.5.24-log
-- PHP Version: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `boqlive`
--

-- --------------------------------------------------------

--
-- Table structure for table `attachement`
--

CREATE TABLE IF NOT EXISTS `attachement` (
  `IDATTACHEMENT` int(11) NOT NULL AUTO_INCREMENT,
  `CIBLE` varchar(150) DEFAULT NULL,
  `IDINTABLE` int(11) DEFAULT NULL,
  `NOMTABLE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDATTACHEMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE IF NOT EXISTS `bill` (
  `IDBILL` int(11) NOT NULL AUTO_INCREMENT,
  `IDPROJET` int(11) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDBILL`),
  KEY `FK_ASSOCIATION_1` (`IDPROJET`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`IDBILL`, `IDPROJET`, `LIBELLE`, `DESCRIPTION`, `code`) VALUES
(23, 27, 'Terrassement', '', 'B01');

-- --------------------------------------------------------

--
-- Table structure for table `billitem`
--

CREATE TABLE IF NOT EXISTS `billitem` (
  `IDBILLITEM` int(11) NOT NULL AUTO_INCREMENT,
  `IDBILL` int(11) NOT NULL,
  `IDITEM` int(11) NOT NULL,
  `PU` double DEFAULT NULL,
  `ESTIMATION` double DEFAULT NULL,
  PRIMARY KEY (`IDBILLITEM`),
  UNIQUE KEY `IDBILLITEM` (`IDBILLITEM`),
  KEY `FK_ASSOCIATION_2` (`IDBILL`),
  KEY `FK_ASSOCIATION_3` (`IDITEM`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `billitem_libelle`
--
CREATE TABLE IF NOT EXISTS `billitem_libelle` (
`IDITEM` int(11)
,`IDUNITE` int(11)
,`LIBELLE` varchar(100)
,`DISCRIPTION` varchar(150)
,`CODE` varchar(10)
,`unite` varchar(100)
,`pu` double
,`idbill` int(11)
,`estimation` double
,`idbillitem` int(11)
,`actuel` double
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `bill_libelle`
--
CREATE TABLE IF NOT EXISTS `bill_libelle` (
`IDBILL` int(11)
,`IDPROJET` int(11)
,`LIBELLE` varchar(100)
,`DESCRIPTION` varchar(150)
,`code` varchar(50)
,`projet` varchar(100)
);
-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE IF NOT EXISTS `client` (
  `IDCLIENT` int(11) NOT NULL AUTO_INCREMENT,
  `NOM` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`IDCLIENT`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`IDCLIENT`, `NOM`, `DESCRIPTION`) VALUES
(2, 'Client 01', '');

-- --------------------------------------------------------

--
-- Stand-in structure for view `decompte_libelle`
--
CREATE TABLE IF NOT EXISTS `decompte_libelle` (
`IDMOISPROJET` int(11)
,`IDPROJET` int(11)
,`IDUTILISATEUR` int(11)
,`MOIS` date
,`ESTIMATION` decimal(10,0)
,`TOTAL` decimal(10,0)
,`DATEDECOMPTE` date
,`DATECERTIFICATION` date
,`REMBOURSEMENT` decimal(10,0)
,`ETAT` int(11)
,`MATONSITECREDIT` decimal(10,0)
,`MATONSITEDEBIT` decimal(10,0)
,`libelle` varchar(100)
,`description` varchar(150)
,`code` varchar(50)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `decompte_refactor_val`
--
CREATE TABLE IF NOT EXISTS `decompte_refactor_val` (
`idbill` int(11)
,`libelle` varchar(100)
,`idmoisprojet` int(11)
,`curr` double
,`estimative` double
);
-- --------------------------------------------------------

--
-- Table structure for table `entreprise`
--

CREATE TABLE IF NOT EXISTS `entreprise` (
  `IDENTREPRISE` int(11) NOT NULL AUTO_INCREMENT,
  `NOM` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`IDENTREPRISE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `entreprise`
--

INSERT INTO `entreprise` (`IDENTREPRISE`, `NOM`, `DESCRIPTION`) VALUES
(2, 'Contractor 1', '');

-- --------------------------------------------------------

--
-- Table structure for table `fonctionnalite`
--

CREATE TABLE IF NOT EXISTS `fonctionnalite` (
  `IDFONCTIONNALITE` int(11) NOT NULL AUTO_INCREMENT,
  `NOM` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`IDFONCTIONNALITE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `fonctionnalite`
--

INSERT INTO `fonctionnalite` (`IDFONCTIONNALITE`, `NOM`, `DESCRIPTION`) VALUES
(1, 'utilisateur', 'Gestion d''utilisateur'),
(2, 'unite', 'Gestion d''unite'),
(3, 'role', 'Gestion de role'),
(4, 'bill', 'Bill Manage'),
(5, 'client', 'Client Manage'),
(6, 'entreprise', 'Contractor manage'),
(7, 'ingenieur', 'Engineer manage'),
(8, 'item', 'Item manage'),
(9, 'materiel', 'Material manage'),
(10, 'projet', 'Project manage'),
(11, 'decompte', 'Count manage');

-- --------------------------------------------------------

--
-- Table structure for table `historique`
--

CREATE TABLE IF NOT EXISTS `historique` (
  `IDHISTORIQUE` int(11) NOT NULL AUTO_INCREMENT,
  `IDUTILISATEUR` int(11) NOT NULL,
  `ACTION` varchar(150) DEFAULT NULL,
  `tablenom` varchar(50) NOT NULL,
  `idintable` int(11) NOT NULL,
  `datelog` date NOT NULL,
  PRIMARY KEY (`IDHISTORIQUE`),
  KEY `FK_ASSOCIATION_19` (`IDUTILISATEUR`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `historique`
--

INSERT INTO `historique` (`IDHISTORIQUE`, `IDUTILISATEUR`, `ACTION`, `tablenom`, `idintable`, `datelog`) VALUES
(26, 1, 'Create project', 'projet', 27, '2017-05-18'),
(27, 1, 'Add new Mat on site', 'projet', 27, '2017-05-18');

-- --------------------------------------------------------

--
-- Stand-in structure for view `historique_libelle`
--
CREATE TABLE IF NOT EXISTS `historique_libelle` (
`prenom` varchar(50)
,`IDHISTORIQUE` int(11)
,`IDUTILISATEUR` int(11)
,`ACTION` varchar(150)
,`tablenom` varchar(50)
,`idintable` int(11)
,`datelog` date
);
-- --------------------------------------------------------

--
-- Table structure for table `ingenieurprojet`
--

CREATE TABLE IF NOT EXISTS `ingenieurprojet` (
  `IDUTILISATEUR` int(11) NOT NULL,
  `IDPROJET` int(11) NOT NULL,
  `etat_ingenieur` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`IDUTILISATEUR`,`IDPROJET`),
  KEY `FK_ASSOCIATION_14` (`IDPROJET`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ingenieurprojet`
--

INSERT INTO `ingenieurprojet` (`IDUTILISATEUR`, `IDPROJET`, `etat_ingenieur`) VALUES
(7, 27, 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ingenieurprojet_libelle`
--
CREATE TABLE IF NOT EXISTS `ingenieurprojet_libelle` (
`IDPROJET` int(11)
,`IDCLIENT` int(11)
,`IDENTREPRISE` int(11)
,`LIBELLE` varchar(100)
,`LIEU` varchar(100)
,`DESCRIPTION` varchar(150)
,`DATEDEBUT` date
,`DATEFIN` date
,`ETAT` int(11)
,`AVANCE` decimal(10,0)
,`code` varchar(50)
,`client` varchar(100)
,`entreprise` varchar(100)
,`idingenieur` int(11)
,`nom` varchar(100)
,`prenom` varchar(50)
,`etat_ingenieur` int(11)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `ingenieur_libelle`
--
CREATE TABLE IF NOT EXISTS `ingenieur_libelle` (
`IDUTILISATEUR` int(11)
,`IDROLE` int(11)
,`LOGIN` varchar(50)
,`PASSE` varchar(50)
,`ETAT` int(11)
,`NOM` varchar(100)
,`PRENOM` varchar(50)
,`isingenieur` int(11)
,`role` varchar(100)
);
-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE IF NOT EXISTS `item` (
  `IDITEM` int(11) NOT NULL AUTO_INCREMENT,
  `IDUNITE` int(11) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DISCRIPTION` varchar(150) DEFAULT NULL,
  `CODE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`IDITEM`),
  KEY `FK_ASSOCIATION_16` (`IDUNITE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`IDITEM`, `IDUNITE`, `LIBELLE`, `DISCRIPTION`, `CODE`) VALUES
(3, 3, 'Item 1', '', 'IT01');

-- --------------------------------------------------------

--
-- Table structure for table `itemrapport`
--

CREATE TABLE IF NOT EXISTS `itemrapport` (
  `IDITEMRAPPORT` int(11) NOT NULL AUTO_INCREMENT,
  `IDMOISPROJET` int(11) NOT NULL,
  `IDBILLITEM` int(11) NOT NULL,
  `CREDIT` decimal(10,0) DEFAULT NULL,
  `ETAT` int(11) DEFAULT NULL,
  `QUANTITEESTIME` decimal(10,0) DEFAULT NULL,
  `montant` double DEFAULT NULL,
  PRIMARY KEY (`IDITEMRAPPORT`),
  KEY `FK_ASSOCIATION_10` (`IDMOISPROJET`),
  KEY `FK_ASSOCIATION_11` (`IDBILLITEM`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `itemrapport_libelle`
--
CREATE TABLE IF NOT EXISTS `itemrapport_libelle` (
`IDITEMRAPPORT` int(11)
,`IDMOISPROJET` int(11)
,`IDBILLITEM` int(11)
,`CREDIT` decimal(10,0)
,`ETAT` int(11)
,`QUANTITEESTIME` decimal(10,0)
,`montant` double
,`code` varchar(10)
,`libelle` varchar(100)
,`idbill` int(11)
,`pu` double
,`estimation` double
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `itemrapport__libelle`
--
CREATE TABLE IF NOT EXISTS `itemrapport__libelle` (
`IDITEMRAPPORT` int(11)
,`IDMOISPROJET` int(11)
,`IDBILLITEM` int(11)
,`CREDIT` decimal(10,0)
,`ETAT` int(11)
,`QUANTITEESTIME` decimal(10,0)
,`code` varchar(10)
,`libelle` varchar(100)
,`idbill` int(11)
,`pu` double
,`estimation` double
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `item_libelle`
--
CREATE TABLE IF NOT EXISTS `item_libelle` (
`IDITEM` int(11)
,`IDUNITE` int(11)
,`LIBELLE` varchar(100)
,`DISCRIPTION` varchar(150)
,`CODE` varchar(10)
,`unite` varchar(100)
);
-- --------------------------------------------------------

--
-- Table structure for table `materiel`
--

CREATE TABLE IF NOT EXISTS `materiel` (
  `IDMATERIEL` int(11) NOT NULL AUTO_INCREMENT,
  `IDUNITE` int(11) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  PRIMARY KEY (`IDMATERIEL`),
  KEY `FK_ASSOCIATION_17` (`IDUNITE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `materiel`
--

INSERT INTO `materiel` (`IDMATERIEL`, `IDUNITE`, `LIBELLE`, `DESCRIPTION`, `code`) VALUES
(3, 3, 'Item 1', '', 'MAT01');

-- --------------------------------------------------------

--
-- Stand-in structure for view `materiel_libelle`
--
CREATE TABLE IF NOT EXISTS `materiel_libelle` (
`IDMATERIEL` int(11)
,`IDUNITE` int(11)
,`LIBELLE` varchar(100)
,`DESCRIPTION` varchar(150)
,`code` varchar(50)
,`unite` varchar(100)
);
-- --------------------------------------------------------

--
-- Table structure for table `matonsite`
--

CREATE TABLE IF NOT EXISTS `matonsite` (
  `IDMATONSITE` int(11) NOT NULL AUTO_INCREMENT,
  `IDMATERIEL` int(11) NOT NULL,
  `IDPROJET` int(11) NOT NULL,
  `PU` decimal(10,0) DEFAULT NULL,
  `CREDIT` decimal(10,0) DEFAULT NULL,
  `DEBIT` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`IDMATONSITE`),
  KEY `FK_ASSOCIATION_12` (`IDPROJET`),
  KEY `FK_ASSOCIATION_13` (`IDMATERIEL`),
  KEY `IDMATONSITE` (`IDMATONSITE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `matonsite`
--

INSERT INTO `matonsite` (`IDMATONSITE`, `IDMATERIEL`, `IDPROJET`, `PU`, `CREDIT`, `DEBIT`) VALUES
(5, 3, 27, '529', '0', '0');

-- --------------------------------------------------------

--
-- Stand-in structure for view `matonsite_libelle`
--
CREATE TABLE IF NOT EXISTS `matonsite_libelle` (
`IDMATONSITE` int(11)
,`IDMATERIEL` int(11)
,`IDPROJET` int(11)
,`PU` decimal(10,0)
,`CREDIT` decimal(10,0)
,`DEBIT` decimal(10,0)
,`libelle` varchar(100)
,`code` varchar(50)
);
-- --------------------------------------------------------

--
-- Table structure for table `matonsite_moisprojet`
--

CREATE TABLE IF NOT EXISTS `matonsite_moisprojet` (
  `idmatonsite` int(11) NOT NULL,
  `idmoisprojet` int(11) NOT NULL,
  `credit` double NOT NULL,
  `debit` double NOT NULL,
  `montant` double NOT NULL DEFAULT '0',
  KEY `mp_mtos` (`idmatonsite`,`idmoisprojet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `matonsite_moisprojet`
--

INSERT INTO `matonsite_moisprojet` (`idmatonsite`, `idmoisprojet`, `credit`, `debit`, `montant`) VALUES
(5, 13, 0, 0, 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `matonsite_projet_libelle`
--
CREATE TABLE IF NOT EXISTS `matonsite_projet_libelle` (
`code` varchar(50)
,`libelle` varchar(100)
,`pu` decimal(10,0)
,`credit` double
,`debit` double
,`idmoisprojet` int(11)
,`idmatonsite` int(11)
,`montant` double
);
-- --------------------------------------------------------

--
-- Table structure for table `moisprojet`
--

CREATE TABLE IF NOT EXISTS `moisprojet` (
  `IDMOISPROJET` int(11) NOT NULL AUTO_INCREMENT,
  `IDPROJET` int(11) NOT NULL,
  `IDUTILISATEUR` int(11) DEFAULT NULL,
  `MOIS` date DEFAULT NULL,
  `ESTIMATION` decimal(10,0) DEFAULT NULL,
  `TOTAL` decimal(10,0) DEFAULT NULL,
  `DATEDECOMPTE` date DEFAULT NULL,
  `DATECERTIFICATION` date DEFAULT NULL,
  `REMBOURSEMENT` decimal(10,0) DEFAULT NULL,
  `ETAT` int(11) DEFAULT NULL,
  `MATONSITECREDIT` decimal(10,0) DEFAULT NULL,
  `MATONSITEDEBIT` decimal(10,0) DEFAULT NULL,
  `retenue` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`IDMOISPROJET`),
  KEY `FK_ASSOCIATION_15` (`IDUTILISATEUR`),
  KEY `FK_ASSOCIATION_9` (`IDPROJET`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `moisprojet`
--

INSERT INTO `moisprojet` (`IDMOISPROJET`, `IDPROJET`, `IDUTILISATEUR`, `MOIS`, `ESTIMATION`, `TOTAL`, `DATEDECOMPTE`, `DATECERTIFICATION`, `REMBOURSEMENT`, `ETAT`, `MATONSITECREDIT`, `MATONSITEDEBIT`, `retenue`) VALUES
(13, 27, 1, '2017-07-28', '5635455', '0', NULL, NULL, '0', 1, '0', '0', 0);

-- --------------------------------------------------------

--
-- Table structure for table `parametre`
--

CREATE TABLE IF NOT EXISTS `parametre` (
  `IDPARAMETRE` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  `VALEUR1` varchar(150) DEFAULT NULL,
  `VALEUR2` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`IDPARAMETRE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `parametre`
--

INSERT INTO `parametre` (`IDPARAMETRE`, `DESCRIPTION`, `VALEUR1`, `VALEUR2`) VALUES
(1, 'Top number projet', '5', '5');

-- --------------------------------------------------------

--
-- Table structure for table `projet`
--

CREATE TABLE IF NOT EXISTS `projet` (
  `IDPROJET` int(11) NOT NULL AUTO_INCREMENT,
  `IDCLIENT` int(11) NOT NULL,
  `IDENTREPRISE` int(11) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `LIEU` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  `DATEDEBUT` date DEFAULT NULL,
  `DATEFIN` date DEFAULT NULL,
  `ETAT` int(11) DEFAULT NULL,
  `AVANCE` decimal(10,0) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `retenue` double NOT NULL,
  `contrat` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`IDPROJET`),
  KEY `FK_ASSOCIATION_4` (`IDCLIENT`),
  KEY `FK_ASSOCIATION_5` (`IDENTREPRISE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `projet`
--

INSERT INTO `projet` (`IDPROJET`, `IDCLIENT`, `IDENTREPRISE`, `LIBELLE`, `LIEU`, `DESCRIPTION`, `DATEDEBUT`, `DATEFIN`, `ETAT`, `AVANCE`, `code`, `retenue`, `contrat`) VALUES
(27, 2, 2, 'FLIC en FLAC', 'Mauritius', 'La reserve de flic en flac', '2017-06-01', '2018-10-10', 1, '75620000', 'P01', 10, 155562000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `projet_fiche`
--
CREATE TABLE IF NOT EXISTS `projet_fiche` (
`IDPROJET` int(11)
,`IDCLIENT` int(11)
,`IDENTREPRISE` int(11)
,`LIBELLE` varchar(100)
,`LIEU` varchar(100)
,`DESCRIPTION` varchar(150)
,`DATEDEBUT` date
,`DATEFIN` date
,`ETAT` int(11)
,`AVANCE` decimal(10,0)
,`code` varchar(50)
,`retenue` double
,`client` varchar(100)
,`entreprise` varchar(100)
,`avanceactuel` decimal(33,0)
,`total` decimal(32,0)
,`totalestimation` decimal(32,0)
,`contrat` double
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `projet_general_stat`
--
CREATE TABLE IF NOT EXISTS `projet_general_stat` (
`actuel` decimal(32,0)
,`estimation` decimal(32,0)
,`libelle` varchar(100)
,`code` varchar(50)
,`idprojet` int(11)
,`avanceactuel` decimal(33,0)
,`avance` decimal(10,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `projet_historique_libelle`
--
CREATE TABLE IF NOT EXISTS `projet_historique_libelle` (
`libelle` varchar(100)
,`prenom` varchar(50)
,`IDHISTORIQUE` int(11)
,`IDUTILISATEUR` int(11)
,`ACTION` varchar(150)
,`tablenom` varchar(50)
,`idintable` int(11)
,`datelog` date
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `projet_libelle`
--
CREATE TABLE IF NOT EXISTS `projet_libelle` (
`IDPROJET` int(11)
,`IDCLIENT` int(11)
,`IDENTREPRISE` int(11)
,`LIBELLE` varchar(100)
,`LIEU` varchar(100)
,`DESCRIPTION` varchar(150)
,`DATEDEBUT` date
,`DATEFIN` date
,`ETAT` int(11)
,`AVANCE` decimal(10,0)
,`code` varchar(50)
,`retenue` double
,`contrat` double
,`client` varchar(100)
,`entreprise` varchar(100)
);
-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `IDROLE` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`IDROLE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`IDROLE`, `LIBELLE`, `DESCRIPTION`) VALUES
(1, 'Admin', NULL),
(2, 'Super admin', '');

-- --------------------------------------------------------

--
-- Table structure for table `rolefonctionnalite`
--

CREATE TABLE IF NOT EXISTS `rolefonctionnalite` (
  `IDFONCTIONNALITE` int(11) NOT NULL,
  `IDROLE` int(11) NOT NULL,
  PRIMARY KEY (`IDFONCTIONNALITE`,`IDROLE`),
  KEY `FK_ASSOCIATION_20` (`IDROLE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rolefonctionnalite`
--

INSERT INTO `rolefonctionnalite` (`IDFONCTIONNALITE`, `IDROLE`) VALUES
(2, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `rolefonctionnalite_libelle`
--
CREATE TABLE IF NOT EXISTS `rolefonctionnalite_libelle` (
`idrole` int(11)
,`role` varchar(100)
,`idfonctionnalite` int(11)
,`fonctionnalite` varchar(150)
);
-- --------------------------------------------------------

--
-- Table structure for table `unite`
--

CREATE TABLE IF NOT EXISTS `unite` (
  `IDUNITE` int(11) NOT NULL AUTO_INCREMENT,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`IDUNITE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `unite`
--

INSERT INTO `unite` (`IDUNITE`, `LIBELLE`, `DESCRIPTION`) VALUES
(3, 'Kg', 'Kilogramme');

-- --------------------------------------------------------

--
-- Stand-in structure for view `userrole_libelle`
--
CREATE TABLE IF NOT EXISTS `userrole_libelle` (
`idutilisateur` int(11)
,`fonctionnalite` varchar(100)
);
-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
  `IDUTILISATEUR` int(11) NOT NULL AUTO_INCREMENT,
  `IDROLE` int(11) NOT NULL,
  `LOGIN` varchar(50) DEFAULT NULL,
  `PASSE` varchar(50) DEFAULT NULL,
  `ETAT` int(11) DEFAULT NULL,
  `NOM` varchar(100) DEFAULT NULL,
  `PRENOM` varchar(50) DEFAULT NULL,
  `isingenieur` int(11) DEFAULT '0',
  PRIMARY KEY (`IDUTILISATEUR`),
  KEY `FK_ASSOCIATION_7` (`IDROLE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`IDUTILISATEUR`, `IDROLE`, `LOGIN`, `PASSE`, `ETAT`, `NOM`, `PRENOM`, `isingenieur`) VALUES
(1, 2, 'vonjy', 'LIKDYP7P+adsCPSdk7Tw8g==', 1, 'RAHANJONIRINA', 'Herivonjy', 0),
(2, 2, 'fanilo', 'zNRaifaQxajyCBYsH1briQ==', 2, 'ANDRIANJAFY', 'Fanilo', 0),
(7, 1, 'jean', 'jean', 1, 'Jean', 'Louis', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `utilisateur_libelle`
--
CREATE TABLE IF NOT EXISTS `utilisateur_libelle` (
`IDUTILISATEUR` int(11)
,`IDROLE` int(11)
,`LOGIN` varchar(50)
,`PASSE` varchar(50)
,`ETAT` int(11)
,`NOM` varchar(100)
,`PRENOM` varchar(50)
,`isingenieur` int(11)
,`role` varchar(100)
);
-- --------------------------------------------------------

--
-- Structure for view `billitem_libelle`
--
DROP TABLE IF EXISTS `billitem_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `billitem_libelle` AS select `item`.`IDITEM` AS `IDITEM`,`item`.`IDUNITE` AS `IDUNITE`,`item`.`LIBELLE` AS `LIBELLE`,`item`.`DISCRIPTION` AS `DISCRIPTION`,`item`.`CODE` AS `CODE`,`item`.`unite` AS `unite`,`bi`.`PU` AS `pu`,`bi`.`IDBILL` AS `idbill`,`bi`.`ESTIMATION` AS `estimation`,`bi`.`IDBILLITEM` AS `idbillitem`,(sum((case when ((`ir`.`CREDIT` <> 0) and (`ir`.`CREDIT` is not null)) then `ir`.`CREDIT` else `ir`.`QUANTITEESTIME` end)) * `bi`.`PU`) AS `actuel` from ((`item_libelle` `item` join `billitem` `bi` on((`item`.`IDITEM` = `bi`.`IDITEM`))) left join `itemrapport` `ir` on((`ir`.`IDBILLITEM` = `bi`.`IDBILLITEM`))) group by `item`.`IDITEM`,`item`.`IDUNITE`,`item`.`LIBELLE`,`item`.`DISCRIPTION`,`item`.`CODE`,`item`.`unite`,`bi`.`PU`,`bi`.`IDBILL`,`bi`.`ESTIMATION`,`bi`.`IDBILLITEM`;

-- --------------------------------------------------------

--
-- Structure for view `bill_libelle`
--
DROP TABLE IF EXISTS `bill_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `bill_libelle` AS select `bill`.`IDBILL` AS `IDBILL`,`bill`.`IDPROJET` AS `IDPROJET`,`bill`.`LIBELLE` AS `LIBELLE`,`bill`.`DESCRIPTION` AS `DESCRIPTION`,`bill`.`code` AS `code`,`projet`.`LIBELLE` AS `projet` from (`bill` join `projet` on((`projet`.`IDPROJET` = `bill`.`IDPROJET`)));

-- --------------------------------------------------------

--
-- Structure for view `decompte_libelle`
--
DROP TABLE IF EXISTS `decompte_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `decompte_libelle` AS select `moisprojet`.`IDMOISPROJET` AS `IDMOISPROJET`,`moisprojet`.`IDPROJET` AS `IDPROJET`,`moisprojet`.`IDUTILISATEUR` AS `IDUTILISATEUR`,`moisprojet`.`MOIS` AS `MOIS`,`moisprojet`.`ESTIMATION` AS `ESTIMATION`,`moisprojet`.`TOTAL` AS `TOTAL`,`moisprojet`.`DATEDECOMPTE` AS `DATEDECOMPTE`,`moisprojet`.`DATECERTIFICATION` AS `DATECERTIFICATION`,`moisprojet`.`REMBOURSEMENT` AS `REMBOURSEMENT`,`moisprojet`.`ETAT` AS `ETAT`,`moisprojet`.`MATONSITECREDIT` AS `MATONSITECREDIT`,`moisprojet`.`MATONSITEDEBIT` AS `MATONSITEDEBIT`,`b`.`LIBELLE` AS `libelle`,`b`.`DESCRIPTION` AS `description`,`b`.`code` AS `code` from (`moisprojet` join `bill` `b` on((`moisprojet`.`IDPROJET` = `b`.`IDPROJET`)));

-- --------------------------------------------------------

--
-- Structure for view `decompte_refactor_val`
--
DROP TABLE IF EXISTS `decompte_refactor_val`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `decompte_refactor_val` AS select `bill`.`IDBILL` AS `idbill`,`bill`.`LIBELLE` AS `libelle`,`ir`.`IDMOISPROJET` AS `idmoisprojet`,(sum((case when ((`ir`.`CREDIT` <> 0) and (`ir`.`CREDIT` is not null)) then `ir`.`CREDIT` else `ir`.`QUANTITEESTIME` end)) * `billitem`.`PU`) AS `curr`,sum(`billitem`.`ESTIMATION`) AS `estimative` from (((`bill` join `billitem` on((`bill`.`IDBILL` = `billitem`.`IDBILL`))) join `itemrapport` `ir` on((`ir`.`IDBILLITEM` = `billitem`.`IDBILLITEM`))) join `moisprojet` `mp` on((`mp`.`IDMOISPROJET` = `ir`.`IDMOISPROJET`))) group by `bill`.`IDBILL`,`bill`.`LIBELLE`,`ir`.`IDMOISPROJET`;

-- --------------------------------------------------------

--
-- Structure for view `historique_libelle`
--
DROP TABLE IF EXISTS `historique_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `historique_libelle` AS select `utilisateur`.`PRENOM` AS `prenom`,`histo`.`IDHISTORIQUE` AS `IDHISTORIQUE`,`histo`.`IDUTILISATEUR` AS `IDUTILISATEUR`,`histo`.`ACTION` AS `ACTION`,`histo`.`tablenom` AS `tablenom`,`histo`.`idintable` AS `idintable`,`histo`.`datelog` AS `datelog` from (`historique` `histo` join `utilisateur` on((`histo`.`IDUTILISATEUR` = `utilisateur`.`IDUTILISATEUR`)));

-- --------------------------------------------------------

--
-- Structure for view `ingenieurprojet_libelle`
--
DROP TABLE IF EXISTS `ingenieurprojet_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `ingenieurprojet_libelle` AS select `p`.`IDPROJET` AS `IDPROJET`,`p`.`IDCLIENT` AS `IDCLIENT`,`p`.`IDENTREPRISE` AS `IDENTREPRISE`,`p`.`LIBELLE` AS `LIBELLE`,`p`.`LIEU` AS `LIEU`,`p`.`DESCRIPTION` AS `DESCRIPTION`,`p`.`DATEDEBUT` AS `DATEDEBUT`,`p`.`DATEFIN` AS `DATEFIN`,`p`.`ETAT` AS `ETAT`,`p`.`AVANCE` AS `AVANCE`,`p`.`code` AS `code`,`p`.`client` AS `client`,`p`.`entreprise` AS `entreprise`,`ingenieurprojet`.`IDUTILISATEUR` AS `idingenieur`,`ingenieur_libelle`.`NOM` AS `nom`,`ingenieur_libelle`.`PRENOM` AS `prenom`,`ingenieurprojet`.`etat_ingenieur` AS `etat_ingenieur` from ((`projet_libelle` `p` join `ingenieurprojet` on((`p`.`IDPROJET` = `ingenieurprojet`.`IDPROJET`))) join `ingenieur_libelle` on((`ingenieur_libelle`.`IDUTILISATEUR` = `ingenieurprojet`.`IDUTILISATEUR`)));

-- --------------------------------------------------------

--
-- Structure for view `ingenieur_libelle`
--
DROP TABLE IF EXISTS `ingenieur_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `ingenieur_libelle` AS select `user`.`IDUTILISATEUR` AS `IDUTILISATEUR`,`user`.`IDROLE` AS `IDROLE`,`user`.`LOGIN` AS `LOGIN`,`user`.`PASSE` AS `PASSE`,`user`.`ETAT` AS `ETAT`,`user`.`NOM` AS `NOM`,`user`.`PRENOM` AS `PRENOM`,`user`.`isingenieur` AS `isingenieur`,`role`.`LIBELLE` AS `role` from (`utilisateur` `user` join `role` on((`role`.`IDROLE` = `user`.`IDROLE`))) where (`user`.`isingenieur` = 1);

-- --------------------------------------------------------

--
-- Structure for view `itemrapport_libelle`
--
DROP TABLE IF EXISTS `itemrapport_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `itemrapport_libelle` AS select `itemr`.`IDITEMRAPPORT` AS `IDITEMRAPPORT`,`itemr`.`IDMOISPROJET` AS `IDMOISPROJET`,`itemr`.`IDBILLITEM` AS `IDBILLITEM`,`itemr`.`CREDIT` AS `CREDIT`,`itemr`.`ETAT` AS `ETAT`,`itemr`.`QUANTITEESTIME` AS `QUANTITEESTIME`,`itemr`.`montant` AS `montant`,`i`.`CODE` AS `code`,`i`.`LIBELLE` AS `libelle`,`bill`.`IDBILL` AS `idbill`,`b`.`PU` AS `pu`,`b`.`ESTIMATION` AS `estimation` from (((`itemrapport` `itemr` join `billitem` `b` on((`itemr`.`IDBILLITEM` = `b`.`IDBILLITEM`))) join `item` `i` on((`i`.`IDITEM` = `b`.`IDITEM`))) join `bill` on((`bill`.`IDBILL` = `b`.`IDBILL`)));

-- --------------------------------------------------------

--
-- Structure for view `itemrapport__libelle`
--
DROP TABLE IF EXISTS `itemrapport__libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `itemrapport__libelle` AS select `itemr`.`IDITEMRAPPORT` AS `IDITEMRAPPORT`,`itemr`.`IDMOISPROJET` AS `IDMOISPROJET`,`itemr`.`IDBILLITEM` AS `IDBILLITEM`,`itemr`.`CREDIT` AS `CREDIT`,`itemr`.`ETAT` AS `ETAT`,`itemr`.`QUANTITEESTIME` AS `QUANTITEESTIME`,`i`.`CODE` AS `code`,`i`.`LIBELLE` AS `libelle`,`bill`.`IDBILL` AS `idbill`,`b`.`PU` AS `pu`,`b`.`ESTIMATION` AS `estimation` from (((`itemrapport` `itemr` join `billitem` `b` on((`itemr`.`IDBILLITEM` = `b`.`IDBILLITEM`))) join `item` `i` on((`i`.`IDITEM` = `b`.`IDITEM`))) join `bill` on((`bill`.`IDBILL` = `b`.`IDBILL`)));

-- --------------------------------------------------------

--
-- Structure for view `item_libelle`
--
DROP TABLE IF EXISTS `item_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `item_libelle` AS select `item`.`IDITEM` AS `IDITEM`,`item`.`IDUNITE` AS `IDUNITE`,`item`.`LIBELLE` AS `LIBELLE`,`item`.`DISCRIPTION` AS `DISCRIPTION`,`item`.`CODE` AS `CODE`,`unite`.`LIBELLE` AS `unite` from (`item` join `unite` on((`unite`.`IDUNITE` = `item`.`IDUNITE`)));

-- --------------------------------------------------------

--
-- Structure for view `materiel_libelle`
--
DROP TABLE IF EXISTS `materiel_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `materiel_libelle` AS select `materiel`.`IDMATERIEL` AS `IDMATERIEL`,`materiel`.`IDUNITE` AS `IDUNITE`,`materiel`.`LIBELLE` AS `LIBELLE`,`materiel`.`DESCRIPTION` AS `DESCRIPTION`,`materiel`.`code` AS `code`,`unite`.`LIBELLE` AS `unite` from (`materiel` join `unite` on((`materiel`.`IDUNITE` = `unite`.`IDUNITE`)));

-- --------------------------------------------------------

--
-- Structure for view `matonsite_libelle`
--
DROP TABLE IF EXISTS `matonsite_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `matonsite_libelle` AS select `mos`.`IDMATONSITE` AS `IDMATONSITE`,`mos`.`IDMATERIEL` AS `IDMATERIEL`,`mos`.`IDPROJET` AS `IDPROJET`,`mos`.`PU` AS `PU`,`mos`.`CREDIT` AS `CREDIT`,`mos`.`DEBIT` AS `DEBIT`,`mat`.`LIBELLE` AS `libelle`,`mat`.`code` AS `code` from (`matonsite` `mos` join `materiel` `mat` on((`mat`.`IDMATERIEL` = `mos`.`IDMATERIEL`)));

-- --------------------------------------------------------

--
-- Structure for view `matonsite_projet_libelle`
--
DROP TABLE IF EXISTS `matonsite_projet_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `matonsite_projet_libelle` AS select `ml`.`code` AS `code`,`ml`.`libelle` AS `libelle`,`ml`.`PU` AS `pu`,`msp`.`credit` AS `credit`,`msp`.`debit` AS `debit`,`msp`.`idmoisprojet` AS `idmoisprojet`,`ml`.`IDMATONSITE` AS `idmatonsite`,`msp`.`montant` AS `montant` from (`matonsite_libelle` `ml` join `matonsite_moisprojet` `msp` on((`msp`.`idmatonsite` = `ml`.`IDMATONSITE`)));

-- --------------------------------------------------------

--
-- Structure for view `projet_fiche`
--
DROP TABLE IF EXISTS `projet_fiche`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `projet_fiche` AS select `p`.`IDPROJET` AS `IDPROJET`,`p`.`IDCLIENT` AS `IDCLIENT`,`p`.`IDENTREPRISE` AS `IDENTREPRISE`,`p`.`LIBELLE` AS `LIBELLE`,`p`.`LIEU` AS `LIEU`,`p`.`DESCRIPTION` AS `DESCRIPTION`,`p`.`DATEDEBUT` AS `DATEDEBUT`,`p`.`DATEFIN` AS `DATEFIN`,`p`.`ETAT` AS `ETAT`,`p`.`AVANCE` AS `AVANCE`,`p`.`code` AS `code`,`p`.`retenue` AS `retenue`,`client`.`NOM` AS `client`,`entreprise`.`NOM` AS `entreprise`,(ifnull(`p`.`AVANCE`,0) - sum(ifnull(`mp`.`REMBOURSEMENT`,0))) AS `avanceactuel`,sum(ifnull(`mp`.`TOTAL`,0)) AS `total`,sum(ifnull(`mp`.`ESTIMATION`,0)) AS `totalestimation`,`p`.`contrat` AS `contrat` from (((`projet` `p` join `client` on((`client`.`IDCLIENT` = `p`.`IDCLIENT`))) join `entreprise` on((`entreprise`.`IDENTREPRISE` = `p`.`IDENTREPRISE`))) left join `moisprojet` `mp` on((`p`.`IDPROJET` = `mp`.`IDPROJET`))) group by `p`.`IDPROJET`,`p`.`IDCLIENT`,`p`.`IDENTREPRISE`,`p`.`LIBELLE`,`p`.`LIEU`,`p`.`DESCRIPTION`,`p`.`DATEDEBUT`,`p`.`DATEFIN`,`p`.`ETAT`,`p`.`AVANCE`,`p`.`code`,`client`.`NOM`,`entreprise`.`NOM`,`p`.`retenue`,`p`.`contrat`;

-- --------------------------------------------------------

--
-- Structure for view `projet_general_stat`
--
DROP TABLE IF EXISTS `projet_general_stat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `projet_general_stat` AS select sum(ifnull(`mp`.`TOTAL`,0)) AS `actuel`,sum(ifnull(`mp`.`ESTIMATION`,0)) AS `estimation`,`projet`.`LIBELLE` AS `libelle`,`projet`.`code` AS `code`,`projet`.`IDPROJET` AS `idprojet`,(ifnull(`projet`.`AVANCE`,0) - sum(ifnull(`mp`.`REMBOURSEMENT`,0))) AS `avanceactuel`,ifnull(`projet`.`AVANCE`,0) AS `avance` from (`projet` left join `moisprojet` `mp` on((`mp`.`IDPROJET` = `projet`.`IDPROJET`))) group by `projet`.`LIBELLE`,`projet`.`code`,`projet`.`IDPROJET`,`projet`.`AVANCE` order by `projet`.`IDPROJET` desc;

-- --------------------------------------------------------

--
-- Structure for view `projet_historique_libelle`
--
DROP TABLE IF EXISTS `projet_historique_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `projet_historique_libelle` AS select `p`.`LIBELLE` AS `libelle`,`h`.`prenom` AS `prenom`,`h`.`IDHISTORIQUE` AS `IDHISTORIQUE`,`h`.`IDUTILISATEUR` AS `IDUTILISATEUR`,`h`.`ACTION` AS `ACTION`,`h`.`tablenom` AS `tablenom`,`h`.`idintable` AS `idintable`,`h`.`datelog` AS `datelog` from (`historique_libelle` `h` join `projet` `p` on((`p`.`IDPROJET` = `h`.`idintable`))) where (`h`.`tablenom` = 'projet');

-- --------------------------------------------------------

--
-- Structure for view `projet_libelle`
--
DROP TABLE IF EXISTS `projet_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `projet_libelle` AS select `projet`.`IDPROJET` AS `IDPROJET`,`projet`.`IDCLIENT` AS `IDCLIENT`,`projet`.`IDENTREPRISE` AS `IDENTREPRISE`,`projet`.`LIBELLE` AS `LIBELLE`,`projet`.`LIEU` AS `LIEU`,`projet`.`DESCRIPTION` AS `DESCRIPTION`,`projet`.`DATEDEBUT` AS `DATEDEBUT`,`projet`.`DATEFIN` AS `DATEFIN`,`projet`.`ETAT` AS `ETAT`,`projet`.`AVANCE` AS `AVANCE`,`projet`.`code` AS `code`,`projet`.`retenue` AS `retenue`,`projet`.`contrat` AS `contrat`,`client`.`NOM` AS `client`,`entreprise`.`NOM` AS `entreprise` from ((`projet` join `client` on((`client`.`IDCLIENT` = `projet`.`IDCLIENT`))) join `entreprise` on((`entreprise`.`IDENTREPRISE` = `projet`.`IDENTREPRISE`)));

-- --------------------------------------------------------

--
-- Structure for view `rolefonctionnalite_libelle`
--
DROP TABLE IF EXISTS `rolefonctionnalite_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `rolefonctionnalite_libelle` AS select `role`.`IDROLE` AS `idrole`,`role`.`LIBELLE` AS `role`,`fonctionnalite`.`IDFONCTIONNALITE` AS `idfonctionnalite`,`fonctionnalite`.`DESCRIPTION` AS `fonctionnalite` from ((`role` join `rolefonctionnalite` `rf` on((`role`.`IDROLE` = `rf`.`IDROLE`))) join `fonctionnalite` on((`fonctionnalite`.`IDFONCTIONNALITE` = `rf`.`IDFONCTIONNALITE`)));

-- --------------------------------------------------------

--
-- Structure for view `userrole_libelle`
--
DROP TABLE IF EXISTS `userrole_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `userrole_libelle` AS select `user`.`IDUTILISATEUR` AS `idutilisateur`,`fonct`.`NOM` AS `fonctionnalite` from ((`utilisateur` `user` join `rolefonctionnalite` `rf` on((`rf`.`IDROLE` = `user`.`IDROLE`))) join `fonctionnalite` `fonct` on((`fonct`.`IDFONCTIONNALITE` = `rf`.`IDFONCTIONNALITE`)));

-- --------------------------------------------------------

--
-- Structure for view `utilisateur_libelle`
--
DROP TABLE IF EXISTS `utilisateur_libelle`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `utilisateur_libelle` AS select `user`.`IDUTILISATEUR` AS `IDUTILISATEUR`,`user`.`IDROLE` AS `IDROLE`,`user`.`LOGIN` AS `LOGIN`,`user`.`PASSE` AS `PASSE`,`user`.`ETAT` AS `ETAT`,`user`.`NOM` AS `NOM`,`user`.`PRENOM` AS `PRENOM`,`user`.`isingenieur` AS `isingenieur`,`role`.`LIBELLE` AS `role` from (`utilisateur` `user` join `role` on((`role`.`IDROLE` = `user`.`IDROLE`))) where (`user`.`isingenieur` = 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `FK_ASSOCIATION_1` FOREIGN KEY (`IDPROJET`) REFERENCES `projet` (`IDPROJET`);

--
-- Constraints for table `billitem`
--
ALTER TABLE `billitem`
  ADD CONSTRAINT `FK_ASSOCIATION_2` FOREIGN KEY (`IDBILL`) REFERENCES `bill` (`IDBILL`),
  ADD CONSTRAINT `FK_ASSOCIATION_3` FOREIGN KEY (`IDITEM`) REFERENCES `item` (`IDITEM`);

--
-- Constraints for table `historique`
--
ALTER TABLE `historique`
  ADD CONSTRAINT `FK_ASSOCIATION_19` FOREIGN KEY (`IDUTILISATEUR`) REFERENCES `utilisateur` (`IDUTILISATEUR`);

--
-- Constraints for table `ingenieurprojet`
--
ALTER TABLE `ingenieurprojet`
  ADD CONSTRAINT `FK_ASSOCIATION_14` FOREIGN KEY (`IDPROJET`) REFERENCES `projet` (`IDPROJET`),
  ADD CONSTRAINT `FK_ingenieurprojet` FOREIGN KEY (`IDUTILISATEUR`) REFERENCES `utilisateur` (`IDUTILISATEUR`);

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `FK_ASSOCIATION_16` FOREIGN KEY (`IDUNITE`) REFERENCES `unite` (`IDUNITE`);

--
-- Constraints for table `itemrapport`
--
ALTER TABLE `itemrapport`
  ADD CONSTRAINT `FK_ASSOCIATION_10` FOREIGN KEY (`IDMOISPROJET`) REFERENCES `moisprojet` (`IDMOISPROJET`),
  ADD CONSTRAINT `FK_ASSOCIATION_11` FOREIGN KEY (`IDBILLITEM`) REFERENCES `billitem` (`IDBILLITEM`);

--
-- Constraints for table `materiel`
--
ALTER TABLE `materiel`
  ADD CONSTRAINT `FK_ASSOCIATION_17` FOREIGN KEY (`IDUNITE`) REFERENCES `unite` (`IDUNITE`);

--
-- Constraints for table `matonsite`
--
ALTER TABLE `matonsite`
  ADD CONSTRAINT `FK_ASSOCIATION_12` FOREIGN KEY (`IDPROJET`) REFERENCES `projet` (`IDPROJET`),
  ADD CONSTRAINT `FK_ASSOCIATION_13` FOREIGN KEY (`IDMATERIEL`) REFERENCES `materiel` (`IDMATERIEL`);

--
-- Constraints for table `moisprojet`
--
ALTER TABLE `moisprojet`
  ADD CONSTRAINT `FK_ASSOCIATION_15` FOREIGN KEY (`IDUTILISATEUR`) REFERENCES `utilisateur` (`IDUTILISATEUR`),
  ADD CONSTRAINT `FK_ASSOCIATION_9` FOREIGN KEY (`IDPROJET`) REFERENCES `projet` (`IDPROJET`);

--
-- Constraints for table `projet`
--
ALTER TABLE `projet`
  ADD CONSTRAINT `FK_ASSOCIATION_4` FOREIGN KEY (`IDCLIENT`) REFERENCES `client` (`IDCLIENT`),
  ADD CONSTRAINT `FK_ASSOCIATION_5` FOREIGN KEY (`IDENTREPRISE`) REFERENCES `entreprise` (`IDENTREPRISE`);

--
-- Constraints for table `rolefonctionnalite`
--
ALTER TABLE `rolefonctionnalite`
  ADD CONSTRAINT `FK_ASSOCIATION_20` FOREIGN KEY (`IDROLE`) REFERENCES `role` (`IDROLE`),
  ADD CONSTRAINT `FK_rolefonctionnalite` FOREIGN KEY (`IDFONCTIONNALITE`) REFERENCES `fonctionnalite` (`IDFONCTIONNALITE`);

--
-- Constraints for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `FK_ASSOCIATION_7` FOREIGN KEY (`IDROLE`) REFERENCES `role` (`IDROLE`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
