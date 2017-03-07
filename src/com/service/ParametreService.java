package com.service;

import com.mapping.Parametre;

import dao.DaoModele;

public class ParametreService {
	private static ParametreService instance=null;
	
	public static final int TOP_PROJET_LIMITE=1;
	
	public ParametreService(){
		
	}
	public static ParametreService getInstance(){
		if(instance==null)
			instance=new ParametreService();
		return instance;
	}
	
	public Parametre getParameter(int type) throws Exception{
		return DaoModele.getInstance().findById(new Parametre(), type);
	}
}
