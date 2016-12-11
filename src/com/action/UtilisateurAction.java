package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affichage.HTMLBuilder;
import com.mapping.Utilisateur;
import com.rooteur.Action;

import dao.DaoModele;
import utilitaire.SessionUtil;
import utilitaire.UtilCrypto;

public class UtilisateurAction extends Action {
	public void desactive(HttpServletRequest request,HttpServletResponse response) throws Exception{
		try{
			int id=Integer.valueOf("0"+SessionUtil.getValForAttr(request, "id"));
			Utilisateur user=DaoModele.getInstance().findById(new Utilisateur(), id);
			if(user==null)
			{
				throw new Exception("Utilisateur introuvable");
			}
			user.setEtat(2);
			DaoModele.getInstance().update(user);
			goTo(request, response, "get","main.jsp?cible=configuration/utilisateur-fiche&id="+id);
		}
		catch(Exception ex){
			throw ex;
		}
	}
	public void active(HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		try{
			int id=Integer.valueOf("0"+SessionUtil.getValForAttr(request, "id"));
			Utilisateur user=DaoModele.getInstance().findById(new Utilisateur(), id);
			if(user==null)
			{
				throw new Exception("Utilisateur introuvable");
			}
			user.setEtat(1);
			DaoModele.getInstance().update(user);
			goTo(request, response, "get","main.jsp?cible=configuration/utilisateur-fiche&id="+id);
		}
		catch(Exception ex){
			throw ex;
		}
	}
	public String ajout(HttpServletRequest request,HttpServletResponse response) throws Exception{
		try{
			Utilisateur user=new HTMLBuilder<Utilisateur>(new Utilisateur(), request).getValue();
			if(!user.isValide()){
				goTo(request,response,"main.jsp?cible=configuration/utilisateur-ajout&erreur=Champ manquant");
				return "error";
			}
			user.setPasse(UtilCrypto.encrypt(user.getPasse()));
			user.setEtat(1);
			DaoModele.getInstance().save(user);
			goTo(request,response,"get","main.jsp?cible=configuration/utilisateur-liste&id="+String.valueOf(user.getIdutilisateur()));
			return "ok";
		}
		catch(Exception ex){
			throw ex;
		}
	}
	public void modif(HttpServletRequest request,HttpServletResponse response) throws Exception{
		try{
			Utilisateur user=new HTMLBuilder<Utilisateur>(new Utilisateur(), request).getValue();
			Utilisateur usernw=DaoModele.getInstance().findById(new Utilisateur(), user.getIdutilisateur());
			if(!user.isValide())
			{
				goTo(request, response, "main.jsp?cible=configuration/utilisateur-modif&erreur=Champ manquant");
				return;
			}
			user.setPasse(usernw.getPasse());
			DaoModele.getInstance().update(user);
			goTo(request, response,"get", "main.jsp?cible=configuration/utilisateur-fiche&id="+user.getIdutilisateur());
		}
		catch(Exception ex){
			throw ex;
		}
	}
}
