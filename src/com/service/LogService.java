package com.service;

import java.sql.Connection;

import com.mapping.ListPaginner;
import com.mapping.Log;

import dao.DaoModele;
import utilitaire.UtileAffichage;
import utilitaire.Utilitaire;

public class LogService {
	private static LogService instance;
	private LogService(){
		
	}
	
	public static LogService getInstance(){
		if(instance==null)
			instance=new LogService();
		return instance;
	}
	
	public void log(Log log,Connection conn) throws Exception{
		log.setDatelog(new java.sql.Date(UtileAffichage.getDateNow().getTime()));
		DaoModele.getInstance().save(log, conn);
	}
	public ListPaginner<Log> getLoByProjet(int page,int idprojet){
		return null;
	}
	
}
