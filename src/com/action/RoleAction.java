package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affichage.HTMLBuilder;
import com.mapping.Role;
import com.rooteur.Action;
import com.service.RoleService;

import dao.DaoModele;

public class RoleAction extends Action {
	public void ajout(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Role role=new HTMLBuilder<Role>(new Role(), request).getEntity();
		String[] idfonctionnalites=request.getParameterValues("idfonctionnalite");
		if(!role.isValide()){
			goTo(request, response, "post", "main.jsp?cible=configuration/role-ajout&erreur=fsdg");
			return;
		}
		if(idfonctionnalites==null || idfonctionnalites.length==0){
			throw new Exception("You must check at least one Access !");
		}
		RoleService.getInstance().insertRole(role, idfonctionnalites);
		goTo(request, response, "get", "main.jsp?cible=configuration/role-liste");
	}
	public void modif(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Role role=new HTMLBuilder<Role>(new Role(), request).getEntity();
		String[] idfonctionnalites=request.getParameterValues("idfonctionnalite");
		if(!role.isValide()){
			goTo(request, response, "post", "main.jsp?cible=configuration/role-modif&erreur=hcgh");
			return;
		}
		if(idfonctionnalites==null || idfonctionnalites.length==0){
			throw new Exception("You must check at least one Access !");
		}
		RoleService.getInstance().updateRole(role, idfonctionnalites);
		goTo(request, response, "get", "main.jsp?cible=configuration/role-fiche?id="+role.getIdrole());
	}
}
