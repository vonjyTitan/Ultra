 INSERT INTO `boq`.`parametre` (`IDPARAMETRE`, `DESCRIPTION`, `VALEUR1`, `VALEUR2`) VALUES ('1', 'Top number projet', '5', '5');

create or replace view projet_general_stat as
select sum(IFNULL(mp.total, 0) ) as actuel,sum(IFNULL(mp.estimation,0)) as estimation,projet.libelle,projet.code,projet.idprojet,
IFNULL(projet.avance,0)-sum(IFNULL(mp.remboursement,0)) as avanceactuel,IFNULL(projet.avance,0) as avance
 from 
 projet
 left join moisprojet mp on mp.idprojet=projet.idprojet
 group by projet.libelle,projet.code,projet.idprojet,projet.avance
 order by projet.idprojet desc;

create or replace view billitem_libelle as
select item.IDITEM, item.IDUNITE, item.LIBELLE, item.DISCRIPTION, item.CODE, item.unite, bi.pu, bi.idbill,bi.estimation,bi.idbillitem,sum(IFNULL(ir.credit,ir.quantiteestime))*bi.pu as actuel  from
item_libelle item join billitem bi on item.iditem=bi.iditem
left join itemrapport ir on ir.idbillitem=bi.idbillitem
group by item.IDITEM, item.IDUNITE, item.LIBELLE, item.DISCRIPTION, item.CODE, item.unite, bi.pu, bi.idbill,bi.estimation,bi.idbillitem
;

ALTER TABLE `projet` ADD `retenue` DOUBLE NOT NULL ;

create or replace view projet_fiche as
select p.IDPROJET, p.IDCLIENT, p.IDENTREPRISE, p.LIBELLE, p.LIEU, p.DESCRIPTION, p.DATEDEBUT, p.DATEFIN, p.ETAT, p.AVANCE, p.code,p.retenue, client.nom as client , entreprise.nom as entreprise,IFNULL(p.avance,0)-sum(IFNULL(mp.remboursement,0)) as avanceactuel,sum(IFNULL(mp.total,0))  as total,sum(IFNULL(mp.estimation,0)) as totalestimation from projet p
join client on client.idclient=p.idclient
join entreprise on entreprise.identreprise =p.identreprise
left join moisprojet mp on p.idprojet =mp.idprojet
group by p.IDPROJET, p.IDCLIENT, p.IDENTREPRISE, p.LIBELLE, p.LIEU, p.DESCRIPTION, p.DATEDEBUT, p.DATEFIN, p.ETAT, p.AVANCE, p.code, client.nom, entreprise.nom,p.retenue
;

create or replace view projet_historique_libelle as
select p.libelle,h.* 
from 
historique_libelle h join projet p
on p.idprojet = h.idintable
where tablenom='projet'
;
