ALTER TABLE `projet` ADD `code` VARCHAR( 50 ) NOT NULL;


create or replace view projet_libelle as
select projet.*, client.nom as client , entreprise.nom as entreprise from projet 
join client on client.idclient=projet.idclient
join entreprise on entreprise.identreprise =projet.identreprise

select user.*, role.libelle as role
from utilisateur as user join role 
on role.idrole=user.idrole where isingenieur=1;

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
(11, 'decompte', 'Count manage')