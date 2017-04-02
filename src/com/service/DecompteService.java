package com.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.swing.text.html.HTMLDocument.HTMLReader.BlockAction;

import com.mapping.RowExtraction;
import com.mapping.Bill;
import com.mapping.DataEntity;
import com.mapping.DecompteExtraction;
import com.mapping.Estimation;
import com.mapping.ItemRapport;
import com.mapping.MatOnSite;
import com.mapping.Projet;

import dao.Connecteur;
import dao.DaoModele;
import jxl.write.Label;
import utilitaire.ConstantEtat;
import utilitaire.SessionUtil;
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
	
	public List<MatOnSite> getMatOnSiteByEstimation(int idmoisprojet) throws Exception{
		Connection conn=null;
		try{
			conn = Connecteur.getConnection();
			MatOnSite critmts = new MatOnSite();
			critmts.setPackSize(50);
			critmts.setNomTable("matonsite_projet_libelle");
			List<MatOnSite> matonsites = DaoModele.getInstance().findPageGenerique(1, critmts,conn," and idmoisprojet="+idmoisprojet);
			Estimation est = DaoModele.getInstance().findById(new Estimation(), idmoisprojet, conn);
			
			
			PreparedStatement pr = conn.prepareStatement("select sum(montant) as montant from  matonsite_moisprojet mtp join moisprojet mp on mtp.idmoisprojet=mp.idmoisprojet where mp.mois<? and mtp.idmatonsite=?");
			ResultSet res =null;
			
			for(MatOnSite matonsite:matonsites){
				pr.setObject(1, est.getMois());
				pr.setObject(2, matonsite.getIdmatonsite());
				res = pr.executeQuery();
				if(res.next()){
					matonsite.setLast(res.getDouble("montant"));
				}
			}
			return matonsites;
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	public Map<Bill,List<ItemRapport>> getItemRapportByBill(int idmoisprojet) throws Exception{
		Map<Bill,List<ItemRapport>> reponse = new HashMap<>();
		Connection conn=null;
		PreparedStatement statLast = null;
		try{
			conn = Connecteur.getConnection();
			Estimation est = DaoModele.getInstance().findById(new Estimation(), idmoisprojet, conn);
			Bill critBill=new Bill();
			critBill.setNomTable("bill_libelle");
			List<Bill> billResult=DaoModele.getInstance().findPageGenerique(1, critBill," and idprojet= " + est.getIdprojet());
			ItemRapport critItem=new ItemRapport();
			critItem.setNomTable("itemrapport_libelle");
			
			statLast = conn.prepareStatement("select sum(montant) as last from itemrapport ir join moisprojet mp on ir.idmoisprojet=mp.idmoisprojet where ir.idbillitem=? and mp.mois<? ");
			ResultSet last = null;
			
			for(int i=0;i<billResult.size();i++){
				List<ItemRapport> ItemResult=DaoModele.getInstance().findPageGenerique(1, critItem," and idbill= " + billResult.get(i).getIdbill() +" and idmoisprojet= " + idmoisprojet);
				for(ItemRapport ir:ItemResult){
					statLast.setObject(1, ir.getIdbillitem());
					statLast.setObject(2, est.getMois());
					
					last = statLast.executeQuery();
					if(last.next())
						ir.setLast(last.getDouble("last"));
				}
				reponse.put(billResult.get(i), ItemResult);
			}
			return reponse;
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
			if(statLast!=null)
				statLast.close();
		}
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
	
	public void decompteMatOnSite(int idmoisprojet,String[]credits, String[] idmatonsite) throws Exception{
		
		Connection conn =null;
		 PreparedStatement prUpd = null;
		 PreparedStatement prMtos = null;
		 try{
			 conn = Connecteur.getConnection();
			 conn.setAutoCommit(false);
			 
			 Estimation est =DaoModele.getInstance().findById(new Estimation(), idmoisprojet, conn);
			 
			 String updateExiste = "update matonsite_moisprojet set credit =?,montant=?*(select pu from matonsite mo where mo.idmatonsite=?) where idmoisprojet="+idmoisprojet+" and idmatonsite=?";
			 String updateGeneral = "update matonsite set credit=(select sum(montant) from matonsite_moisprojet where idmatonsite=?) where idmatonsite=?";
			 
			 int taille = credits.length;
			 prUpd = conn.prepareStatement(updateExiste);
			 prMtos = conn.prepareStatement(updateGeneral);
			 
			 String credit="";
			 for(int i=0;i<taille;i++){
				 credit= (credits[i]==null || credits[i].length()==0) ? "0" : credits[i];
				 
				 prUpd.setObject(1, credit);
				 prUpd.setObject(2, credit);
				 prUpd.setObject(3, Integer.valueOf(idmatonsite[i]));
				 prUpd.setObject(4, Integer.valueOf(idmatonsite[i]));
				 
				 prUpd.executeUpdate();
				 
				 prMtos.setObject(1, Integer.valueOf(idmatonsite[i]));
				 prMtos.setObject(2, Integer.valueOf(idmatonsite[i]));
				 
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
	
	public void certifiedDecompte(int idecompte) throws Exception{
		Connection conn = null;
		 try{
			 conn = Connecteur.getConnection();
			 conn.setAutoCommit(false);

			 Estimation dec = DaoModele.getInstance().findById(new Estimation(), idecompte, conn);
			 Projet p = DaoModele.getInstance().findById(new Projet(), dec.getIdprojet(), conn);
			 
			 Double cummulativeRetension = 0.0;
			 Double totalEstimationprojet  = 0.0;
			 Double actRetenue = dec.getTotal()*p.getRetenue()/100;
					 
			 String sql_cum_ret="select sum(retenue) as retenue as  form moisprojet where idprojet = "+dec.getIdprojet();
			 ResultSet resRet = conn.createStatement().executeQuery(sql_cum_ret);
			 
			 while(resRet.next()){
				 cummulativeRetension = resRet.getDouble("retenue");
			 }
			 
			 if(cummulativeRetension+actRetenue>(totalEstimationprojet*5/100)){
				 actRetenue = (totalEstimationprojet*5/100)-cummulativeRetension;
			 }
			 
			 DecompteService.getInstance().setEstimationEtat(idecompte, ConstantEtat.MOIS_CERTIFIED, conn);
			 dec.setRetenue(actRetenue);
			 DaoModele.getInstance().update(dec,conn);
			 DaoModele.getInstance().executeUpdate("update moisprojet set MATONSITECREDIT=(select sum(montant) from matonsite_moisprojet mm on mm.idmoisprojet="+idecompte+") where idmoisprojet="+idecompte,conn);
			 
			 
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
	}
	
	public DecompteExtraction getDataToextract(int idmoisprojet)throws Exception{
		DecompteExtraction reponse = new DecompteExtraction();
		Connection conn=null;
		PreparedStatement ps=null;
		try{
			conn = Connecteur.getConnection();
			
			Estimation est= DaoModele.getInstance().findById(new Estimation(),idmoisprojet,conn);
			Projet critProjet = new Projet();
			critProjet.setNomTable("projet_libelle");
			Projet projet = DaoModele.getInstance().findById(critProjet, est.getIdprojet(), conn);
			
			Double lastRetention = 0.0;
			Double lastMatOnSite = 0.0;
			Double lastRepayment = 0.0;
			
			reponse.setContractor(projet.getEntreprise());
			reponse.setSociete(projet.getClient());
			reponse.setIdcertificat(est.getIdmoisprojet());
			reponse.setCertificatdate(new java.sql.Date(new java.util.Date().getTime()));
			
			ResultSet rsBill = conn.createStatement().executeQuery("select * from decompte_refactor_val where idmoisprojet="+idmoisprojet);
			
			ps = conn.prepareStatement("select billitem.idbill,sum(case when ir.credit=0 then ir.credit else ir.quantiteestime end)*billitem.pu as previous "+
					" from billitem "+
					"left join itemrapport ir "+
					"on ir.idbillitem=billitem.idbillitem "+
					"left join moisprojet mp "+
					"on mp.idmoisprojet=ir.idmoisprojet "+
					"where mp.mois<? and billitem.idbill=? "+
					"group by billitem.idbill");
			
			     ResultSet rs=null;
			     while(rsBill.next()){
			    	 RowExtraction bill = new RowExtraction(); 
			    	 
			    	 bill.setLibelle(rsBill.getString("libelle"));
			    	 bill.setEstimative(rsBill.getDouble("estimative"));
	    			 bill.setCurrent(rsBill.getDouble("curr"));
	    			 
	    			 ps.setObject(1, est.getMois());
			    	 ps.setObject(2, rsBill.getInt("idbill"));
			    	 
			    	 rs=ps.executeQuery();
			    	 while(rs.next()){
			    		 bill.setPrecedant(rs.getDouble("previous"));
			    		 bill.setCummulative(bill.getPrecedant()+bill.getCurrent());
			    	 }
			    	 reponse.getBills().add(bill);
			     }
			     
			     reponse.calculeSubTotal1();
			     
			     PreparedStatement statLastRet = conn.prepareStatement("select sum(retenue) as retenue from moisprojet where idprojet="+est.getIdprojet()+" and mois<?");
			     statLastRet.setObject(1, est.getMois());
			     ResultSet resLastRet = statLastRet.executeQuery();
			     
			     while(resLastRet.next()){
			    	 lastRetention = resLastRet.getDouble("retenue");
			     }
			     
			     RowExtraction retention = new RowExtraction();
			     retention.setCurrent(est.getRetenue()*-1);
			     retention.setPrecedant(lastRetention*-1);
			     retention.setCummulative((est.getRetenue()+lastRetention)*-1);
			     
			     reponse.setRetention(retention);
			     reponse.calculeSubTotal2();
			     
			     PreparedStatement statLastMOT = conn.prepareStatement("select sum(MATONSITECREDIT) as montant from moisprojet where idprojet="+est.getIdprojet()+" and mois<?");
			     statLastMOT.setObject(1, est.getMois());
			     ResultSet resLastMOT = statLastMOT.executeQuery();
			     while(resLastMOT.next()){
			    	 lastMatOnSite = resLastMOT.getDouble("montant");
			     }
			     
			     RowExtraction matonsite = new RowExtraction();
			     matonsite.setPrecedant(lastMatOnSite);
			     matonsite.setCurrent(est.getMatonsitecredit());
			     matonsite.setCummulative(matonsite.getCurrent()+matonsite.getPrecedant());
			     
			     reponse.setMatonsite(matonsite);
			     
			     RowExtraction avance=new RowExtraction();
			     
			     Estimation firstest = new Estimation();
			     firstest.setPackSize(1);
			     firstest.setNomChampOrder("idmoisprojet");
			     firstest.setOrdering(DataEntity.DESC);
			     if(DaoModele.getInstance().findPageGenerique(1, firstest, conn, " and idprojet="+est.getIdprojet()).get(0).getIdmoisprojet()==est.getIdmoisprojet()){
			    	 //this is the first 
			    	 avance.setPrecedant(0.0);
			    	 avance.setCurrent(projet.getAvance());
			    	 avance.setCummulative(projet.getAvance());
			     }
			     else{
			    	 avance.setPrecedant(projet.getAvance());
			    	 avance.setCurrent(0.0);
			    	 avance.setCummulative(projet.getAvance());
			     }
			     
			     reponse.setAvance(avance);
			     
			     PreparedStatement statRepayment = conn.prepareStatement("select sum(REMBOURSEMENT) as montant from moisprojet where idprojet="+est.getIdprojet()+" and mois<?");
			     statRepayment.setObject(1, est.getMois());
			     ResultSet resLastRepayment = statLastMOT.executeQuery();
			     while(resLastRepayment.next()){
			    	 lastRepayment = resLastRepayment.getDouble("montant");
			     }
			     RowExtraction lessrepayment = new RowExtraction();
			     lessrepayment.setPrecedant(-1*lastRepayment);
			     lessrepayment.setCurrent(-1*est.getRemboursement());
			     lessrepayment.setCummulative(lessrepayment.getPrecedant()+lessrepayment.getCurrent());
			     
			     reponse.setLessrepayment(lessrepayment);
			     reponse.calculeTotal();
			     reponse.setContractValue(projet.getContrat());
			     
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
