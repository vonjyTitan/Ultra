package com.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import com.mapping.DecompteStat;
import com.mapping.Estimation;
import com.mapping.MatOnSite;
import com.mapping.ProjetStat;

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
	
	public void setEstimation(String[] dates,String[]estimation, int idprojet,int idutilisateur, Connection conn)throws Exception{
		if(dates==null)
			return;
		int length = dates.length;
		List<Estimation> mois = new ArrayList<Estimation>();
		for(int i=0;i<length;i++){
			if(dates[i]!=null && !dates[i].isEmpty()){
				Estimation inter = new Estimation();
				inter.setIdprojet(idprojet);
				inter.setIdutilisateur(idutilisateur);
				inter.setEtat(ConstantEtat.MOIS_CREATED);
				inter.setEstimation(Double.valueOf(estimation[i]));
				inter.setMois((Date) UtileAffichage.parseFromRequest(dates[i], Date.class));
				mois.add(inter);
			}
		}
		if(mois.size()!=0){
			DaoModele.getInstance().save(mois, conn);
		}
	}
	public void setEstimation(String[] dates,String[]estimation, int idprojet,int idutilisateur)throws Exception{
		Connection conn = null;
		try{
			conn = Connecteur.getConnection();
			setEstimation(dates,estimation,idprojet,idutilisateur,conn);
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	public void addMatOnSite(String[] idmats,String[]pus,int idprojet,int idutilisateur)throws Exception{
		if(idmats==null || idmats.length==0)
			throw new Exception("No Material added");
		int taille = idmats.length;
		List<MatOnSite> moss = new ArrayList<MatOnSite>();
		PreparedStatement pr = null;
		for(int i=0;i<taille;i++){
			MatOnSite mos = new MatOnSite();
			mos.setIdmateriel(Integer.valueOf(idmats[i]));
			mos.setPu(Double.valueOf(pus[i]));
			mos.setDebit(0);
			mos.setCredit(0);
			mos.setIdprojet(idprojet);
			moss.add(mos);
		}
		Connection conn = null;
		try{
			conn =  Connecteur.getConnection();
			conn.setAutoCommit(false);
			pr = conn.prepareStatement("INSERT INTO matonsite_moisprojet(idmatonsite, idmoisprojet, credit, debit) select ?,idmoisprojet, 0,0 from moisprojet where idprojet="+idprojet);
			DaoModele.getInstance().save(moss, conn);
			
			for(MatOnSite mos:moss){
				pr.setObject(1, mos.getIdmatonsite());
				pr.executeUpdate();
			}
			
			LogService.getInstance().log("Add new Mat on site", idutilisateur, idprojet, "projet", conn);
			
			conn.commit();
		}
		catch(Exception ex){
			if(conn!=null)
				conn.rollback();
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	
}
