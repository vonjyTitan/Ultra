package com.action;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.affichage.HTMLBuilder;
import com.mapping.DataEntity;
import com.mapping.Utilisateur;
import com.rooteur.Action;
import com.service.LoginService;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.SessionUtil;

public class CrudAction extends Action {
	public void insert(HttpServletRequest request,HttpServletResponse response)throws Exception
	{
		String classe=SessionUtil.getValForAttr(request, "classenom");
		if(classe==null || classe.isEmpty() || classe.compareToIgnoreCase("null")==0)
			throw new Exception("Nom de Class obligatoire");
		Class cl=Class.forName(classe);
		if(cl==null)
			throw new Exception("Nom de Class invalide");
		DataEntity entity=null;
		try{
			entity=(DataEntity) cl.newInstance();
		}
		catch(Exception ex){
			throw new Exception("La class doit heritE de la class DataEntity!");
		}
		Connection conn=null;
		try{
			conn = Connecteur.getConnection();
			if(!LoginService.getInstance().isAllowed((Utilisateur) request.getSession().getAttribute("utilisateur"), entity.getActionName()+"-ajout",conn))
				throw new Exception("Yout do not have access to this page");
			entity=new HTMLBuilder(entity, request).getEntity();
			if(!entity.isValide())
			{
				goTo(request,response,SessionUtil.getValForAttr(request, "refereur")+"&erreur=Champ invalide");
				return;
			}
			DaoModele.getInstance().save(entity,conn);
			String cible=SessionUtil.getValForAttr(request, "cible");
			goTo(request,response,"get","main.jsp?cible="+cible);
		}
		catch(Exception ex){
			
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	public void update(HttpServletRequest request,HttpServletResponse response)throws Exception{
		String classe=SessionUtil.getValForAttr(request, "classenom");
		if(classe==null || classe.isEmpty() || classe.compareToIgnoreCase("null")==0)
			throw new Exception("Nom de Class obligatoire");
		Class cl=Class.forName(classe);
		if(cl==null)
			throw new Exception("Nom de Class invalide");
		DataEntity entity=null;
		try{
			entity=(DataEntity) cl.newInstance();
		}
		catch(Exception ex){
			throw new Exception("La class doit heritE de la class DataEntity!");
		}
		if(!LoginService.getInstance().isAllowed((Utilisateur) request.getSession().getAttribute("utilisateur"), entity.getActionName()+"-ajout"))
			throw new Exception("Yout do not have access to this page");
		entity=new HTMLBuilder(entity, request).getEntity();
		if(!entity.isValide())
		{
			goTo(request,response,SessionUtil.getValForAttr(request, "refereur")+"&erreur=Champ invalide");
			return;
		}
		if(DaoModele.getInstance().findById(entity)==null)
		{
			throw new Exception("Objet introuvable");
		}
		DaoModele.getInstance().update(entity);
		String cible=SessionUtil.getValForAttr(request, "cible");
		Object id=entity.getPkValue();
		goTo(request,response,"get","main.jsp?cible="+cible+"&id="+id);
	}
	public void delete(HttpServletRequest request,HttpServletResponse response)throws Exception{
		String classe=SessionUtil.getValForAttr(request, "classenom");
		if(classe==null || classe.isEmpty() || classe.compareToIgnoreCase("null")==0)
			throw new Exception("Nom de Class obligatoire");
		Class cl=Class.forName(classe);
		if(cl==null)
			throw new Exception("Nom de Class invalide");
		DataEntity entity=null;
		try{
			entity=(DataEntity) cl.newInstance();
		}
		catch(Exception ex){
			throw new Exception("La class doit heritE de la class DataEntity!");
		}
		Connection conn=null;
		try{
			conn = Connecteur.getConnection();
			if(!LoginService.getInstance().isAllowed((Utilisateur) request.getSession().getAttribute("utilisateur"), entity.getActionName()+"-ajout",conn))
				throw new Exception("Yout do not have access to this page");
			entity.setValueForField(entity.getFieldByName(entity.getPkName()),Integer.valueOf((String)SessionUtil.getValForAttr(request, "id")));
			if(DaoModele.getInstance().findById(entity)==null)
			{
				throw new Exception("Objet introuvable");
			}
			DaoModele.getInstance().delete(entity,conn);
			String cible=SessionUtil.getValForAttr(request, "cible");
			goTo(request,response,"get","main.jsp?cible="+cible);
		}
		catch(Exception ex){
			
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
}
