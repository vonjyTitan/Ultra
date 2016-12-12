package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affichage.HTMLBuilder;
import com.mapping.Role;
import com.rooteur.Action;

import dao.DaoModele;

public class RoleAction extends Action {
	public void ajout(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Role role=new HTMLBuilder<Role>(new Role(), request).getEntity();
		if(!role.isValide()){
			goTo(request, response, "post", "main.jsp?cible=configuration/role-ajout&erreur=fsdg");
			return;
		}
		DaoModele.getInstance().save(role);
		goTo(request, response, "get", "main.jsp?cible=configuration/role-liste");
	}
	public void modif(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Role role=new HTMLBuilder<Role>(new Role(), request).getEntity();
		if(!role.isValide()){
			goTo(request, response, "post", "main.jsp?cible=configuration/role-modif&erreur=hcgh");
			return;
		}
		DaoModele.getInstance().update(role);
		goTo(request, response, "get", "main.jsp?cible=configuration/role-liste");
	}
}
