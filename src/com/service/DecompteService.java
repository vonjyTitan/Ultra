package com.service;

import java.sql.Connection;

import com.mapping.Estimation;

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
}
