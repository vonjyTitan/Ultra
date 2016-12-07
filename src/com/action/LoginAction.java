package com.action;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.affichage.HTMLBuilder;
import com.mapping.Utilisateur;
import com.rooteur.Action;
import com.service.LoginService;

import dao.DaoModele;
import utilitaire.SessionUtil;
import utilitaire.UtilCrypto;

public class LoginAction extends Action {
	public void testLogin(HttpServletRequest request,HttpServletResponse response){
		if(request.getParameter("login")==null || request.getParameter("passe")==null)
		{
			goTo(request, response, "login.jsp?erreur=Mot de passe ou login obligatoire");
			return ;
		}
		if(request.getParameter("login").isEmpty() || request.getParameter("passe").isEmpty())
		{
			goTo(request, response, "login.jsp?erreur=Mot de passe ou login obligatoire");
			return ;
		}
		Utilisateur u=null;
		try {
			u=LoginService.getInstance().testLogin(request.getParameter("login"), request.getParameter("passe"));
		} catch (Exception e) {
			goTo(request, response, "login.jsp?erreur="+e.getMessage());
			return ;
		}
		if(u==null){
			goTo(request, response, "login.jsp?erreur=Login ou mot de passe inconnue");
			return ;
		}
		request.getSession().setAttribute("utilisateur", u);
		String cible=(String) request.getParameter("cible");
		if(cible==null || cible.isEmpty())
			cible="stat";
		String idval=(SessionUtil.getValForAttr(request, "id"));
		String id=(idval!=null && !idval.isEmpty()) ? "&id="+idval : "";
		goTo(request, response,"get", "main.jsp?cible="+cible+id);
	}
	
	
}
