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