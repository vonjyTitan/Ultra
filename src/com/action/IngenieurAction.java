package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affichage.HTMLBuilder;
import com.mapping.Utilisateur;
import com.rooteur.Action;

import dao.DaoModele;

public class IngenieurAction extends Action {
	public void insert(HttpServletRequest request,HttpServletResponse response)throws Exception{
		Utilisateur user = new HTMLBuilder<>(new Utilisateur(), request).getEntity();
		if(!user.isValide()){
			goTo(request, response, "main.jsp?cible=configuration/ingenieur-ajout&erreur=iyg");
			return;
		}
		user.setIsingenieur(1);
		DaoModele.getInstance().save(user);
		goTo(request, response,"get", "main.jsp?cible=configuration/ingenieur-liste&idutilisateur="+user.getIdutilisateur());
	}
}
