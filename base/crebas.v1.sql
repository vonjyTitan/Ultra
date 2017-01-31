
/*==============================================================*/
/* Table : rolefonctionnalite                                       */
/*==============================================================*/
create table rolefonctionnalite
(
   IDFONCTIONNALITE     int not null,
   IDROLE               int not null,
   primary key (IDFONCTIONNALITE, IDROLE)
);

/*==============================================================*/
/* Table : ingenieurprojet                                        */
/*==============================================================*/
create table ingenieurprojet
(
   IDUTILISATEUR        int not null,
   IDPROJET             int not null,
   primary key (IDUTILISATEUR, IDPROJET)
);

/*==============================================================*/
/* Table : ATTACHEMENT                                          */
/*==============================================================*/
create table ATTACHEMENT
(
   IDATTACHEMENT        int not null auto_increment,
   CIBLE                varchar(150),
   IDINTABLE            int,
   NOMTABLE             varchar(50),
   primary key (IDATTACHEMENT)
);

/*==============================================================*/
/* Table : BILL                                                 */
/*==============================================================*/
create table BILL
(
   IDBILL               int not null auto_increment,
   IDPROJET             int not null,
   LIBELLE              varchar(100),
   DESCRIPTION          varchar(150),
   primary key (IDBILL)
);

/*==============================================================*/
/* Table : BILLITEM                                             */
/*==============================================================*/
create table BILLITEM
(
   IDBILLITEM           int not null auto_increment,
   IDBILL               int not null,
   IDITEM               int not null,
   PU                   DOUBLE,
   ESTIMATION           DOUBLE,
   primary key (IDBILLITEM)
);

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
create table CLIENT
(
   IDCLIENT             int not null auto_increment,
   NOM                  varchar(100),
   DESCRIPTION          varchar(150),
   primary key (IDCLIENT)
);

/*==============================================================*/
/* Table : ENTREPRISE                                           */
/*==============================================================*/
create table ENTREPRISE
(
   IDENTREPRISE         int not null auto_increment,
   NOM                  varchar(100),
   DESCRIPTION          varchar(150),
   primary key (IDENTREPRISE)
);

/*==============================================================*/
/* Table : FONCTIONNALITE                                       */
/*==============================================================*/
create table FONCTIONNALITE
(
   IDFONCTIONNALITE     int not null auto_increment,
   NOM                  varchar(100),
   DESCRIPTION          varchar(150),
   primary key (IDFONCTIONNALITE)
);

/*==============================================================*/
/* Table : HISTORIQUE                                           */
/*==============================================================*/
create table HISTORIQUE
(
   IDHISTORIQUE         int not null auto_increment,
   IDUTILISATEUR        int not null,
   ACTION               varchar(150),
   primary key (IDHISTORIQUE)
);

/*==============================================================*/
/* Table : ITEM                                                 */
/*==============================================================*/
create table ITEM
(
   IDITEM               int not null auto_increment,
   IDUNITE              int not null,
   LIBELLE              varchar(100),
   DISCRIPTION          varchar(150),
   CODE                 varchar(10),
   primary key (IDITEM)
);

/*==============================================================*/
/* Table : ITEMRAPPORT                                          */
/*==============================================================*/
create table ITEMRAPPORT
(
   IDITEMRAPPORT        int not null auto_increment,
   IDMOISPROJET         int not null,
   IDBILLITEM           int not null,
   CREDIT               DOUBLE,
   ETAT                 int,
   QUANTITEESTIME       DOUBLE,
   primary key (IDITEMRAPPORT)
);

/*==============================================================*/
/* Table : MATERIEL                                             */
/*==============================================================*/
create table MATERIEL
(
   IDMATERIEL           int not null auto_increment,
   IDUNITE              int not null,
   LIBELLE              varchar(100),
   DESCRIPTION          varchar(150),
   primary key (IDMATERIEL)
);

/*==============================================================*/
/* Table : MATONSITE                                            */
/*==============================================================*/
create table MATONSITE
(
   IDMATONSITE          int not null auto_increment,
   IDMATERIEL           int not null,
   IDPROJET             int not null,
   PU                   DOUBLE,
   CREDIT               DOUBLE,
   DEBIT                DOUBLE,
   primary key (IDMATONSITE)
);

/*==============================================================*/
/* Table : MOISPROJET                                           */
/*==============================================================*/
create table MOISPROJET
(
   IDMOISPROJET         int not null auto_increment,
   IDPROJET             int not null,
   IDUTILISATEUR        int,
   MOIS                 date,
   ESTIMATION           DOUBLE,
   TOTAL                DOUBLE,
   DATEDECOMPTE         date,
   DATECERTIFICATION    date,
   REMBOURSEMENT        DOUBLE,
   ETAT                 int,
   MATONSITECREDIT      DOUBLE,
   MATONSITEDEBIT       DOUBLE,
   primary key (IDMOISPROJET)
);

/*==============================================================*/
/* Table : PARAMETRE                                            */
/*==============================================================*/
create table PARAMETRE
(
   IDPARAMETRE          int not null auto_increment,
   DESCRIPTION          varchar(150),
   VALEUR1              varchar(150),
   VALEUR2              varchar(150),
   primary key (IDPARAMETRE)
);

/*==============================================================*/
/* Table : PROJET                                               */
/*==============================================================*/
create table PROJET
(
   IDPROJET             int not null auto_increment,
   IDCLIENT             int not null,
   IDENTREPRISE         int not null,
   LIBELLE              varchar(100),
   LIEU                 varchar(100),
   DESCRIPTION          varchar(150),
   DATEDEBUT            date,
   DATEFIN              date,
   ETAT                 int,
   AVANCE               DOUBLE,
   primary key (IDPROJET)
);

/*==============================================================*/
/* Table : ROLE                                                 */
/*==============================================================*/
create table ROLE
(
   IDROLE               int not null auto_increment,
   LIBELLE              varchar(100),
   DESCRIPTION          varchar(150),
   primary key (IDROLE)
);

/*==============================================================*/
/* Table : UNITE                                                */
/*==============================================================*/
create table UNITE
(
   IDUNITE              int not null auto_increment,
   LIBELLE              varchar(100),
   DESCRIPTION          varchar(150),
   primary key (IDUNITE)
);

/*==============================================================*/
/* Table : UTILISATEUR                                          */
/*==============================================================*/
create table UTILISATEUR
(
   IDUTILISATEUR        int not null auto_increment,
   IDROLE               int not null,
   LOGIN                varchar(50),
   PASSE                varchar(50),
   ETAT                 int,
   NOM                  varchar(100),
   PRENOM               varchar(50),
   isingenieur integer default 0,
   primary key (IDUTILISATEUR)
);

alter table rolefonctionnalite add constraint FK_rolefonctionnalite foreign key (IDFONCTIONNALITE)
      references FONCTIONNALITE (IDFONCTIONNALITE) on delete restrict on update restrict;

alter table rolefonctionnalite add constraint FK_ASSOCIATION_20 foreign key (IDROLE)
      references ROLE (IDROLE) on delete restrict on update restrict;

alter table ingenieurprojet add constraint FK_ASSOCIATION_14 foreign key (IDPROJET)
      references PROJET (IDPROJET) on delete restrict on update restrict;

alter table ingenieurprojet add constraint FK_ingenieurprojet foreign key (IDUTILISATEUR)
      references UTILISATEUR (IDUTILISATEUR) on delete restrict on update restrict;

alter table BILL add constraint FK_ASSOCIATION_1 foreign key (IDPROJET)
      references PROJET (IDPROJET) on delete restrict on update restrict;

alter table BILLITEM add constraint FK_ASSOCIATION_2 foreign key (IDBILL)
      references BILL (IDBILL) on delete restrict on update restrict;

alter table BILLITEM add constraint FK_ASSOCIATION_3 foreign key (IDITEM)
      references ITEM (IDITEM) on delete restrict on update restrict;

alter table HISTORIQUE add constraint FK_ASSOCIATION_19 foreign key (IDUTILISATEUR)
      references UTILISATEUR (IDUTILISATEUR) on delete restrict on update restrict;

alter table ITEM add constraint FK_ASSOCIATION_16 foreign key (IDUNITE)
      references UNITE (IDUNITE) on delete restrict on update restrict;

alter table ITEMRAPPORT add constraint FK_ASSOCIATION_10 foreign key (IDMOISPROJET)
      references MOISPROJET (IDMOISPROJET) on delete restrict on update restrict;

alter table ITEMRAPPORT add constraint FK_ASSOCIATION_11 foreign key (IDBILLITEM)
      references BILLITEM (IDBILLITEM) on delete restrict on update restrict;

alter table MATERIEL add constraint FK_ASSOCIATION_17 foreign key (IDUNITE)
      references UNITE (IDUNITE) on delete restrict on update restrict;

alter table MATONSITE add constraint FK_ASSOCIATION_12 foreign key (IDPROJET)
      references PROJET (IDPROJET) on delete restrict on update restrict;

alter table MATONSITE add constraint FK_ASSOCIATION_13 foreign key (IDMATERIEL)
      references MATERIEL (IDMATERIEL) on delete restrict on update restrict;

alter table MOISPROJET add constraint FK_ASSOCIATION_15 foreign key (IDUTILISATEUR)
      references UTILISATEUR (IDUTILISATEUR) on delete restrict on update restrict;

alter table MOISPROJET add constraint FK_ASSOCIATION_9 foreign key (IDPROJET)
      references PROJET (IDPROJET) on delete restrict on update restrict;

alter table PROJET add constraint FK_ASSOCIATION_4 foreign key (IDCLIENT)
      references CLIENT (IDCLIENT) on delete restrict on update restrict;

alter table PROJET add constraint FK_ASSOCIATION_5 foreign key (IDENTREPRISE)
      references ENTREPRISE (IDENTREPRISE) on delete restrict on update restrict;

alter table UTILISATEUR add constraint FK_ASSOCIATION_7 foreign key (IDROLE)
      references ROLE (IDROLE) on delete restrict on update restrict;
	  
create or replace view userrole_libelle as select user.idutilisateur,fonct.NOM as fonctionnalite from utilisateur as user 
join rolefonctionnalite as rf on rf.idrole=user.idrole
join fonctionnalite as fonct
on fonct.idfonctionnalite=rf.idfonctionnalite;

create or replace view utilisateur_libelle
as 
select user.*, role.libelle as role
from utilisateur as user join role 
on role.idrole=user.idrole where isingenieur=0;

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
(10, 'projet', 'Project manage');


--
-- Dumping data for table `role`
--

INSERT INTO `role` (`IDROLE`, `LIBELLE`, `DESCRIPTION`) VALUES
(1, 'Admin', NULL),
(2, 'Super admin', NULL);

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
(10, 2);

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`IDUTILISATEUR`, `IDROLE`, `LOGIN`, `PASSE`, `ETAT`, `NOM`, `PRENOM`) VALUES
(1, 2, 'vonjy', 'LIKDYP7P+adsCPSdk7Tw8g==', 1, 'RAHANJONIRINA', 'Herivonjy'),
(2, 2, 'fanilo', 'zNRaifaQxajyCBYsH1briQ==', 1, 'ANDRIANJAFY', 'Fanilo');

create or replace view materiel_libelle as SELECT materiel.*,unite.libelle as unite FROM materiel
join unite on materiel.idunite=unite.idunite;

ALTER TABLE `materiel` ADD `code` VARCHAR( 50 ) ;
ALTER TABLE `bill` ADD `code` VARCHAR( 50 ) ;

create or replace view item_libelle as
select item.*, unite.libelle as unite from 
item join unite
on unite.idunite=item.idunite;


create or replace view ingenieur_libelle
as 
select user.*, role.libelle as role
from utilisateur as user join role 
on role.idrole=user.idrole where isingenieur=1;
