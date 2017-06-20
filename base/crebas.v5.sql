create or replace view mesurment as
SELECT itrl.*,mp.datedecompte,concat(us.prenom,' ',us.nom) as utilisateur,us.idutilisateur,us.isingenieur FROM `itemrapport_libelle` as itrl
join moisprojet as mp
on itrl.idmoisprojet=mp.idmoisprojet
join Utilisateur as us
on mp.idutilisateur=us.idutilisateur;