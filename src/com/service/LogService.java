package com.service;

import java.sql.Connection;
import java.util.List;

import com.mapping.ListPaginner;
import com.mapping.DataEntity;
import com.mapping.Historique;

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
	
	public void log(Historique log,Connection conn) throws Exception{
		log.setDatelog(new java.sql.Date(UtileAffichage.getDateNow().getTime()));
		//DaoModele.getInstance().save(log, conn);
	}
	public void log(String action,int idutilisateur,int idintable,String table,Connection conn)throws Exception{
		Historique histo=new Historique();
		histo.setIdintable(idintable);
		histo.setTable(table);
		histo.setAction(action);
		histo.setIdutilisateur(idutilisateur);
		log(histo,conn);
		
	}
	public List<Historique> getLoByProjet(int page,String table) throws Exception{
		Historique crit=new Historique();
		crit.setOrdering(DataEntity.DESC);
		crit.setNomTable("historique_libelle");
		crit.setNomChampOrder("idhistorique");
		return DaoModele.getInstance().findPageGenerique(page, crit);
	}
	
}
