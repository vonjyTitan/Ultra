ALTER TABLE `projet` ADD `code` VARCHAR( 50 ) NOT NULL;


create or replace view projet_libelle as
select projet.*, client.nom as client , entreprise.nom as entreprise from projet 
join client on client.idclient=projet.idclient
join entreprise on entreprise.identreprise =projet.identreprise

select user.*, role.libelle as role
from utilisateur as user join role 
on role.idrole=user.idrole where isingenieur=1;