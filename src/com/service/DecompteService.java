package com.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.swing.text.html.HTMLDocument.HTMLReader.BlockAction;

import com.mapping.BillExtraction;
import com.mapping.DecompteExtraction;
import com.mapping.Estimation;
import com.mapping.ItemRapport;

import dao.Connecteur;
import dao.DaoModele;
import jxl.write.Label;
import utilitaire.ConstantEtat;
import utilitaire.Utilitaire;

public class DecompteService {
	private static DecompteService instance;
	private DecompteService(){
		
	}
	public static DecompteService getInstance(){
		if(instance==null)
			return instance=new DecompteService();
		return instance;
	}
	
	public void setDefaultItemRapportForMoisProjet(int idmoisprojet,Connection conn) throws Exception{
		Estimation est=DaoModele.getInstance().findById(new Estimation(), idmoisprojet, conn);
		String query="INSERT INTO itemrapport(IDMOISPROJET, IDBILLITEM, CREDIT, ETAT, QUANTITEESTIME) "+ 
				" select "+idmoisprojet+",bi.idbillitem,0,"+ConstantEtat.ITEM_RAPPORT_CREATED+",0"+
				" from billitem bi join bill on bi.idbill=bill.idbill where bill.idprojet="+est.getIdprojet();
			DaoModele.getInstance().executeUpdate(query, conn);
		query = "INSERT INTO matonsite_moisprojet(idmatonsite, idmoisprojet, credit, debit) "
				+ "select idmatonsite,"+idmoisprojet+",0,0 from matonsite where idprojet="+est.getIdprojet();
		DaoModele.getInstance().executeUpdate(query, conn);
	}
	public void doDecompte(int idmoisprojet,String[]iditemrapport,String[]credit,String[]estime,Connection conn){
		//TODO verifie si le mois projet est deja certifier
		//TODO mettre a jour l'etat du mois projet en COnstantEtat.MOIS_COUNTED en mettant aussie la data actuel comme date de decompte
		
		//TODO faire update tous les itemrapport
	}
	public void setQuantityItemProject(double quantity , int idmoisprojet)throws Exception{
		Connection conn = null;
		try{
			conn = Connecteur.getConnection();
			setQuantityItemProject(quantity,idmoisprojet,conn);
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	
	public void setQuantityItemProject(double quantity , int iditemrapport, Connection conn)throws Exception{
		DaoModele.getInstance().executeUpdate("update itemrapport set credit= "+quantity+ " where iditemrapport= "+iditemrapport, conn);

	}
	public void setEstimateItemProject(double estimate , int iditemrapport, Connection conn)throws Exception{
		DaoModele.getInstance().executeUpdate("update itemrapport set quantiteestime= "+estimate+ " where iditemrapport= "+iditemrapport, conn);

	}
	public void setMontantItemProject(double montant , int iditemrapport, Connection conn)throws Exception{
		DaoModele.getInstance().executeUpdate("update itemrapport set montant= "+montant+ " where iditemrapport= "+iditemrapport, conn);

	}
	
	public void setEstimationEtat(int idmoisprojet,int etat)throws Exception{
		Connection conn = null;
		try{
			conn = Connecteur.getConnection();
			setEstimationEtat(idmoisprojet,etat,conn);
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	
	public void setEstimationEtat(int idmoisprojet, int etat,Connection conn)throws Exception{
		DaoModele.getInstance().executeUpdate("update moisprojet set etat= "+etat + " where idmoisprojet ="+idmoisprojet, conn);

	}
	public void setEstimationTotal(int idmoisprojet, double total, Connection conn)throws Exception{
		//System.out.println("update moisprojet set total= "+ total + " where idmoisprojet ="+idmoisprojet);
		DaoModele.getInstance().executeUpdate("update moisprojet set total= "+ total + " where idmoisprojet ="+idmoisprojet, conn);

	}
	public double getTotalEstimationAccount(int idmoisprojet , int idbillitem){
		
		return 1;
	}
	public double getQuantityxUnitPrice(int idmoisprojet) throws Exception{
		ItemRapport critItem=new ItemRapport();
		critItem.setNomTable("itemrapport_libelle");
		List <ItemRapport> listItemRaport = DaoModele.getInstance().findPageGenerique(1, critItem," and idmoisprojet= " + idmoisprojet);
		double somme =0; 
		for(ItemRapport itemRapport : listItemRaport)
		{
			somme =  somme + itemRapport.getPu() * itemRapport.getCredit();
		}
		return somme;
	}
	
	public void decompteMatOnSite(int idmoisprojet,String[]credits,String[]debits, String[] idmatonsite) throws Exception{
		
		Connection conn =null;
		 PreparedStatement prUpd = null;
		 PreparedStatement prMtos = null;
		 try{
			 conn = Connecteur.getConnection();
			 conn.setAutoCommit(false);
			 
			 Estimation est =DaoModele.getInstance().findById(new Estimation(), idmoisprojet, conn);
			 
			 String updateExiste = "update matonsite_moisprojet set credit =?, debit=? where idmoisprojet="+idmoisprojet+" and idmatonsite=?";
			 String updateGeneral = "update matonsite set debit=(select sum(debit) from matonsite_moisprojet where idmatonsite=?) , credit=(select sum(credit) from matonsite_moisprojet where idmatonsite=?) where idmatonsite=?";
			 
			 int taille = credits.length;
			 prUpd = conn.prepareStatement(updateExiste);
			 prMtos = conn.prepareStatement(updateGeneral);
			 
			 String credit="";
			 String debit = "";
			 for(int i=0;i<taille;i++){
				 credit= (credits[i]==null || credits[i].length()==0) ? "0" : credits[i];
				 debit= (debits[i]==null || debits[i].length()==0) ? "0" : debits[i];
				 
				 prUpd.setObject(1, credit);
				 prUpd.setObject(2, debit);
				 prUpd.setObject(3, Integer.valueOf(idmatonsite[i]));
				 
				 prUpd.executeUpdate();
				 
				 prMtos.setObject(1, Integer.valueOf(idmatonsite[i]));
				 prMtos.setObject(2, Integer.valueOf(idmatonsite[i]));
				 prMtos.setObject(3, Integer.valueOf(idmatonsite[i]));
				 
				 prMtos.executeUpdate();
			 }
			 
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
	public DecompteExtraction getDataToextract(int idmoisprojet)throws Exception{
		DecompteExtraction reponse = new DecompteExtraction();
		Connection conn=null;
		PreparedStatement ps=null;
		try{
			conn = Connecteur.getConnection();
			
			Estimation est= DaoModele.getInstance().findById(new Estimation(),idmoisprojet,conn);
			reponse.setIdcertificat(est.getIdmoisprojet());
			
			ResultSet rsBill = conn.createStatement().executeQuery("select * from decompte_refactor_val where idmoisprojet="+idmoisprojet);
			
			ps = conn.prepareStatement("select billitem.idbill,sum(case when ir.credit=0 then ir.credit else ir.quantiteestime end)*billitem.pu as previous "+
					" from billitem "+
					"join itemrapport ir "+
					"on ir.idbillitem=billitem.idbillitem "+
					"join moisprojet mp "+
					"on mp.idmoisprojet=ir.idmoisprojet "+
					"where mp.mois<? and billitem.idbill=? "+
					"group by billitem.idbill");
			
			     ResultSet rs=null;
			     while(rsBill.next()){
			    	 BillExtraction bill = new BillExtraction(); 
			    	 
			    	 bill.setIdbill(rsBill.getInt("idbill"));
			    	 bill.setLibelle(rsBill.getString("libelle"));
			    	 bill.setEstimative(rsBill.getDouble("estimative"));
	    			 bill.setCurrent(rsBill.getDouble("curr"));
	    			 
	    			 ps.setObject(1, est.getMois());
			    	 ps.setObject(2, bill.getIdbill());
			    	 
			    	 rs=ps.executeQuery();
			    	 while(rs.next()){
			    		 bill.setPrecedant(rs.getDouble("previous"));
			    		 bill.setCummulative(bill.getPrecedant()+bill.getCurrent());
			    	 }
			    	 reponse.getBills().add(bill);
			    	 
			     }
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
			if(ps!=null)
				ps.close();
		}
		return reponse;
	}
	
}
