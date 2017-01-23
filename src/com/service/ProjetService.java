package com.service;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.mapping.Mois;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.ConstantEtat;
import utilitaire.UtileAffichage;

public class ProjetService {
	private static ProjetService instance;
	private ProjetService(){
		
	}
	public static ProjetService getInstance(){
		if(instance==null)
			instance =  new ProjetService();
		return instance;
	}
	
	public void setIngenieur(String[]ingenieurs, int idprojet)throws Exception{
		Connection conn = null;
		try{
			conn = Connecteur.getConnection();
			setIngenieur(ingenieurs,idprojet,conn);
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	
	public void setIngenieur(String[]ingenieurs, int idprojet, Connection conn)throws Exception{
		if(ingenieurs==null)
			return;
		//DaoModele.getInstance().executeUpdate("delete from ingenieurprojet where idprojet="+idprojet, conn);
		for(String ingenieur:ingenieurs){
			if(ingenieur!=null && !ingenieur.isEmpty()){
				DaoModele.getInstance().executeUpdate("insert into ingenieurprojet(idprojet,idutilisateur) value("+idprojet+","+ingenieur+")", conn);
			}
		}
	}
	
	public void setEstimation(String[] dates,String[]estimation, int idprojet, Connection conn)throws Exception{
		if(dates==null)
			return;
		int length = dates.length;
		List<Mois> mois = new ArrayList<Mois>();
		for(int i=0;i<length;i++){
			if(dates[i]!=null && !dates[i].isEmpty()){
				Mois inter = new Mois();
				inter.setIdprojet(idprojet);
				inter.setEtat(ConstantEtat.MOIS_CREATED);
				inter.setEstimation(Double.valueOf(estimation[i]));
				inter.setMois((Date) UtileAffichage.getNonNullValue(dates[i], Date.class));
				mois.add(inter);
			}
		}
		if(mois.size()!=0){
			DaoModele.getInstance().save(mois, conn);
		}
	}
	public void setEstimation(String[] dates,String[]estimation, int idprojet)throws Exception{
		Connection conn = null;
		try{
			conn = Connecteur.getConnection();
			setEstimation(dates,estimation,idprojet,conn);
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
}
