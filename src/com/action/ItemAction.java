package com.action;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mapping.Item;
import com.mapping.Materiel;
import com.rooteur.Action;

import dao.Connecteur;
import dao.DaoModele;

public class ItemAction extends Action {
	public void insert(HttpServletRequest request,HttpServletResponse response)throws Exception{

		String [] codes = request.getParameterValues("code");
		String [] libelles = request.getParameterValues("libelle");
		String [] idunites = request.getParameterValues("idunite");
		String [] descriptions = request.getParameterValues("description");
		if(codes==null || codes.length==0){
			throw new Exception("No rows are filled");
		}
		List<Item> materiels = new ArrayList<>();
		for(int i=0;i<codes.length;i++){
			Item item = new Item();
			if(codes[i].length()==0 && libelles[i].length()==0){
				continue;
			}
			if(codes[i].length()==0){
				throw new Exception("Code value is mandatory at row "+i+1);
			}
			if(libelles[i].length()==0){
				throw new Exception("libelle value is mandatory at row "+i+1);
			}
			
			item.setCode(codes[i]);
			item.setLibelle(libelles[i]);
			item.setDiscription(descriptions[i]);
			item.setIdunite(Integer.valueOf(idunites[i]));
			materiels.add(item);
		}
		Connection conn=null;
		try{
			conn = Connecteur.getConnection();
			conn.setAutoCommit(false);
			DaoModele.getInstance().save(materiels, conn);
			conn.commit();
		}
		catch(Exception ex){
			if(conn!=null)
				conn.rollback();
			ex.printStackTrace();
			throw new Exception("Internal server error");
		}
		finally{
			if(conn!=null)
				conn.close();
		}
		goTo(request, response, "get","main.jsp?cible=configuration/item-liste");
	}
}
