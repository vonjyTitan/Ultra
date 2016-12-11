package com.service;

import java.sql.Connection;
import java.util.List;

import com.mapping.DataEntity;
import com.mapping.RoleFonctionnalite;
import com.mapping.Utilisateur;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.UtilCrypto;

public class LoginService {
	private static LoginService instance=null;
	private LoginService(){
		instance=this;
	}
	public static LoginService getInstance(){
		if(instance==null)
			new LoginService();
		return instance;
	}
	public boolean isAllowed(Utilisateur utilisateur,String activite)throws Exception{
		String fonctionnalite = activite.split("-")[0];
		RoleFonctionnalite crit = new RoleFonctionnalite();
		crit.setNomTable("userrole_libelle");
		List<RoleFonctionnalite> rep=DaoModele.getInstance().findPageGenerique(1, crit, " and idutilisateur="+utilisateur.getIdrole()+" and upper(fonctionnalite)=upper('"+fonctionnalite+"')");
		return rep.size()!=0;
	}
	public Utilisateur testLogin(String login,String passe)throws Exception{
			
		Connection connex=null;
		try{
			connex=Connecteur.getConnection();
			connex.setAutoCommit(false);
			Utilisateur ob=new Utilisateur();
			List<Utilisateur> rep=DaoModele.getInstance().findPageGenerique(1, ob,connex," and login='"+login.replace("'", "")+"' and passe='"+UtilCrypto.encrypt(passe)+"' and etat=1");
			if(rep.size()>0)
			{
				NotificationService.getInstance().saveNotification("The user "+rep.get(0).getNom()+" logged in the application", rep.get(0).getIdutilisateur(), connex, rep.get(0));
				return rep.get(0);
			}
			connex.commit();
		}
		catch(Exception ex){
			if(connex!=null)
				connex.rollback();
		}
		finally{
			if(connex!=null)
				connex.close();
		}
		return null;
	}
}
