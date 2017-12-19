package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affichage.HTMLBuilder;
import com.mapping.Utilisateur;
import com.rooteur.Action;

import dao.DaoModele;
import utilitaire.SessionUtil;
import utilitaire.UtilCrypto;

public class IngenieurAction extends Action {
	public void insert(HttpServletRequest request,HttpServletResponse response)throws Exception{
		Utilisateur user = new HTMLBuilder<>(new Utilisateur(), request).getEntity();
		if(!user.isValide()){
			if(!isAjoutPopup(request))
				goTo(request, response, "main.jsp?cible=configuration/ingenieur-ajout&erreur=iyg");
			else
				goTo(request, response, "popup.jsp?cible=popup-ajoutingenieur&erreur=iyg");
			return;
		}
		if(!user.getPasse().equals(SessionUtil.getValForAttr(request, "passe_confirm"))){
			throw new Exception("Password does not match the confirm password");
		}
		user.setIsingenieur(1);
		user.setEtat(1);
		DaoModele.getInstance().save(user);
		user.setPasse(UtilCrypto.encrypt(user.getPasse()));
		if(isAjoutPopup(request))
			afterPopupAjout(request, response, user);
		else
			goTo(request, response,"get", "main.jsp?cible=configuration/ingenieur-liste&idutilisateur="+user.getIdutilisateur());
	}
	public void modif(HttpServletRequest request,HttpServletResponse response)throws Exception{
		Utilisateur user = new HTMLBuilder<>(new Utilisateur(), request).getEntity();
		if(!user.isValide()){
			goTo(request, response, "main.jsp?cible=configuration/ingenieur-ajout&erreur=iyg");
			return;
		}
		if(!user.getPasse().equals(SessionUtil.getValForAttr(request, "passe_confirm"))){
			throw new Exception("Password does not match the confirm password");
		}
		user.setIsingenieur(1);
		user.setPasse(UtilCrypto.encrypt(user.getPasse()));
		DaoModele.getInstance().update(user);
		goTo(request, response,"get", "main.jsp?cible=configuration/ingenieur-fiche&id="+user.getIdutilisateur());
	}
}
