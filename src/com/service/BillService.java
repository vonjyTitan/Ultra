package com.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.mapping.Bill;
import com.mapping.BillItem;
import com.mysql.jdbc.PreparedStatement;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.ConstantEtat;

public class BillService {
	private static BillService instance;
	private BillService(){
		
	}
	public static BillService getInstance(){
		if(instance==null)
			instance =  new BillService();
		return instance;
	}
	
	public void addItems(String[]iditems, String[]pus,String[]estimations,int idbill,int idutilisateur) throws Exception{
		Connection conn=null;
		try{
			conn = Connecteur.getConnection();
			conn.setAutoCommit(false);
			addItems(iditems, pus, estimations,idbill,idutilisateur,conn);
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
	
	public void addItems(String[]iditems, String[]pus,String[]estimations,int idbill,int idutilisateur,Connection conn) throws Exception{
		if(iditems==null || iditems.length==0){
			return;
		}
		Bill bill=DaoModele.getInstance().findById(new Bill(), idbill, conn);
		int taille=iditems.length;
		List<BillItem> list=new ArrayList<BillItem>();
		for(int i=0;i<taille;i++){
			if(iditems[i].trim().length()==0){
				continue;
			}
			int iditem =Integer.valueOf("0"+iditems[i]);
			double pu = Double.valueOf(("0"+pus[i]).replace(",", ""));
			double estimation = Double.valueOf(("0"+pus[i]).replace(",", ""));
			if(iditem==0){
				throw new Exception("No items is selected");
			}
			if(pu<=0){
				throw new Exception("The value of PU need to be positif");
			}
			BillItem bi=new BillItem();
			bi.setIdbill(idbill);
			bi.setIditem(iditem);
			bi.setPu(pu);
			bi.setEstimation(estimation);
			list.add(bi);
			LogService.getInstance().log("Add new item for bill "+bill.getCode(), idutilisateur, bill.getIdprojet(), "projet", conn);
		}
		DaoModele.getInstance().save(list, conn);
		
		for(BillItem bi:list){
			String query="INSERT INTO itemrapport(IDMOISPROJET, IDBILLITEM, CREDIT, ETAT, QUANTITEESTIME) "+
					" "+
					" select mp.IDMOISPROJET,"+bi.getIdbillitem()+",0,"+ConstantEtat.ITEM_RAPPORT_CREATED+",0"+
					" from moisprojet mp where mp.idprojet="+bill.getIdprojet();
				DaoModele.getInstance().executeUpdate(query, conn);
		}
	}
}
