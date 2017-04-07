package com.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.mapping.DataEntity;
import com.mapping.RoleFonctionnalite;
import com.mapping.Utilisateur;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.UtilCrypto;

public class LoginService {
	private static LoginService instance=null;
	private static List<String> excludeInTestAccess=null;
	private LoginService(){
		instance=this;
		excludeInTestAccess= new ArrayList<String>();
		excludeInTestAccess.add("crud");
		excludeInTestAccess.add("attachement");
	}
	public static LoginService getInstance(){
		if(instance==null)
			new LoginService();
		return instance;
	}
	public boolean isAllowed(Utilisateur utilisateur,String activite)throws Exception{
		Connection conn = null;
		try{
			conn = Connecteur.getConnection();
			return isAllowed(utilisateur, activite,conn);
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	public boolean isAllowed(Utilisateur utilisateur,String activite,Connection conn)throws Exception{
		String fonctionnalite = activite.split("-")[0];
		if(excludeInTestAccess.contains(fonctionnalite.toLowerCase()))
			return true;
		RoleFonctionnalite crit = new RoleFonctionnalite();
		crit.setNomTable("userrole_libelle");
		List<RoleFonctionnalite> rep=DaoModele.getInstance().findPageGenerique(1, crit,conn, " and idutilisateur="+utilisateur.getIdrole()+" and upper(fonctionnalite)=upper('"+fonctionnalite+"')");
		return rep.size()!=0;
	}
	
	public Map<String,Boolean> getAllAuthForUser(Utilisateur user,HttpServletRequest request)throws Exception{
		Map<String,Boolean> rep = new HashMap<>();
		Connection conn = null;
		try{
			conn = Connecteur.getConnection();
			
			rep.put("projet", isAllowed(user, "projet-gvbh",conn));
			rep.put("client", isAllowed(user, "client-gvbh",conn));
			rep.put("entreprise", isAllowed(user, "entreprise-gvbh",conn));
			rep.put("ingenieur", isAllowed(user, "ingenieur-gvbh",conn));
			
			rep.put("utilisateur", isAllowed(user, "utilisateur-gvbh",conn));
			rep.put("role", isAllowed(user, "role-gvbh",conn));
			
			rep.put("item", isAllowed(user, "item--gvbh",conn));
			rep.put("materiel", isAllowed(user, "materiel-gvbh",conn));
			rep.put("unite", isAllowed(user, "unite-gvbh",conn));
			
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
		return rep;
	}
	
	public Utilisateur testLogin(String login,String passe)throws Exception{
			
		Connection connex=null;
		try{
			connex=Connecteur.getConnection();
			connex.setAutoCommit(false);
			Utilisateur ob=new Utilisateur();
			ob.setNomTable("utilisateur_libelle");
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
			ex.printStackTrace();
		}
		finally{
			if(connex!=null)
				connex.close();
		}
		return null;
	}
}
