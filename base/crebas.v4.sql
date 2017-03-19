create or replace view billitem_libelle as
select item.IDITEM, item.IDUNITE, item.LIBELLE, item.DISCRIPTION, item.CODE, item.unite, bi.pu, bi.idbill,bi.estimation,bi.idbillitem,sum(IFNULL(ir.montant,0)) as actuel  from
item_libelle item join billitem bi on item.iditem=bi.iditem
left join itemrapport ir on ir.idbillitem=bi.idbillitem
group by item.IDITEM, item.IDUNITE, item.LIBELLE, item.DISCRIPTION, item.CODE, item.unite, bi.pu, bi.idbill,bi.estimation,bi.idbillitem
;

ALTER TABLE `moisprojet` ADD `retenue` DOUBLE NOT NULL DEFAULT '0';

ALTER TABLE `projet` ADD `contrat` DOUBLE NOT NULL DEFAULT '0';

create or replace view projet_fiche as
select p.IDPROJET, p.IDCLIENT, p.IDENTREPRISE, p.LIBELLE, p.LIEU, p.DESCRIPTION, p.DATEDEBUT, p.DATEFIN, p.ETAT, p.AVANCE, p.code,p.retenue, client.nom as client , entreprise.nom as entreprise,IFNULL(p.avance,0)-sum(IFNULL(mp.remboursement,0)) as avanceactuel,sum(IFNULL(mp.total,0))  as total,sum(IFNULL(mp.estimation,0)) as totalestimation 
,p.contrat
from projet p
join client on client.idclient=p.idclient
join entreprise on entreprise.identreprise =p.identreprise
left join moisprojet mp on p.idprojet =mp.idprojet
group by p.IDPROJET, p.IDCLIENT, p.IDENTREPRISE, p.LIBELLE, p.LIEU, p.DESCRIPTION, p.DATEDEBUT, p.DATEFIN, p.ETAT, p.AVANCE, p.code, client.nom, entreprise.nom,p.retenue,p.contrat
;