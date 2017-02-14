package com.service;

import java.sql.Connection;
import java.util.List;

import com.mapping.Estimation;
import com.mapping.ItemRapport;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.ConstantEtat;

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
		System.out.println(total+"total");
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
	
	
}
