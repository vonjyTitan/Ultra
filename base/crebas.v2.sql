ALTER TABLE `projet` ADD `code` VARCHAR( 50 ) NOT NULL;


create or replace view projet_libelle as
select projet.*, client.nom as client , entreprise.nom as entreprise from projet 
join client on client.idclient=projet.idclient
join entreprise on entreprise.identreprise =projet.identreprise;

create or replace view ingenieurprojet_libelle as
select p.*,ingenieurprojet.idutilisateur as idingenieur, ingenieur_libelle.nom , ingenieur_libelle.prenom from projet_libelle p 
join ingenieurprojet on p.idprojet=ingenieurprojet.idprojet
join ingenieur_libelle on ingenieur_libelle.idutilisateur=ingenieurprojet.idutilisateur;

create or replace view bill_libelle as
SELECT bill . * , projet.libelle AS projet
FROM bill
JOIN projet ON projet.idprojet = bill.idprojet;

create or replace view billitem_libelle as
select item.*, bi.pu, bi.idbill,bi.estimation,bi.idbillitem from
item_libelle item join billitem bi on item.iditem=bi.iditem;

create or replace view ingenieur_libelle
as 
select user.*, role.libelle as role
from utilisateur as user join role 
on role.idrole=user.idrole where isingenieur=1;

INSERT INTO `fonctionnalite` (`IDFONCTIONNALITE`, `NOM`, `DESCRIPTION`) VALUES
(11, 'decompte', 'Count manage');

create or replace view matonsite_libelle as
SELECT mos.*,mat.libelle,mat.code FROM matonsite as mos 
join materiel mat on mat.idmateriel=mos.idmateriel;

create or replace view decompte_libelle as 
select moisprojet.* ,b.libelle,b.description,b.code from moisprojet 
join bill as b on moisprojet.idprojet =  b.idprojet;

create or replace view itemrapport_libelle as
select itemr.* ,i.code,i.libelle,bill.idbill,b.pu,b.estimation from itemrapport as itemr
join billitem b on itemr.idbillitem = b.idbillitem
join item as i on i.iditem = b.iditem
join bill on bill.idbill= b.idbill;

create or replace view decompte_refactor_val as
select bill.idbill, bill.libelle,ir.idmoisprojet,sum(case when ir.credit=0 then ir.credit else ir.quantiteestime end)*billitem.pu as curr,sum(billitem.estimation) as estimative
from bill join billitem
on bill.idbill=billitem.idbill
join itemrapport ir
on ir.idbillitem=billitem.idbillitem
join moisprojet mp
on mp.idmoisprojet=ir.idmoisprojet
group by bill.idbill,bill.libelle,ir.idmoisprojet;

ALTER TABLE `historique` ADD `tablenom` VARCHAR( 50 ) NOT NULL AFTER `ACTION`;
ALTER TABLE `historique` ADD `idintable` INT NOT NULL ,
ADD INDEX ( `tablenom` , `idintable` ) ;

ALTER TABLE `historique` ADD `datelog` DATE NOT NULL AFTER `idintable` ;

create or replace view historique_libelle as
select utilisateur.prenom, histo.* from historique histo
join utilisateur on histo.idutilisateur = utilisateur.idutilisateur;

create or replace view item_histo as
select itemitl.*, mp.datedecompte
from itemrapport_libelle itemitl
join moisprojet mp
on itemitl.idmoisprojet = mp.idmoisprojet;

ALTER TABLE `itemrapport` ADD `montant` DOUBLE;

ALTER TABLE `ingenieurprojet` ADD `etat_ingenieur` INT NOT NULL DEFAULT '0';

create or replace view ingenieurprojet_libelle as
select p.*,ingenieurprojet.idutilisateur as idingenieur, ingenieur_libelle.nom , ingenieur_libelle.prenom,ingenieurprojet.etat_ingenieur from projet_libelle p 
join ingenieurprojet on p.idprojet=ingenieurprojet.idprojet
join ingenieur_libelle on ingenieur_libelle.idutilisateur=ingenieurprojet.idutilisateur;


CREATE TABLE IF NOT EXISTS `matonsite_moisprojet` (
  `idmatonsite` int(11) NOT NULL,
  `idmoisprojet` int(11) NOT NULL,
  `credit` double NOT NULL,
  `debit` double NOT NULL,
  KEY `mp_mtos` (`idmatonsite`,`idmoisprojet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


create or replace view matonsite_projet_libelle as 
select ml.code,ml.libelle,ml.pu,msp.credit,msp.debit,msp.idmoisprojet,ml.idmatonsite
from matonsite_libelle ml
join matonsite_moisprojet msp
on msp.idmatonsite=ml.idmatonsite;
