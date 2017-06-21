package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rooteur.Action;

public class MaterielAction extends Action {
	public void insert(HttpServletRequest request,HttpServletResponse response)throws Exception{
		//TODO insert all data
		goTo(request, response, "get","main.jsp?cible=configuration/materiel-liste");
	}
}
