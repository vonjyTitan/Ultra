package com.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.mapping.BillItem;

import dao.Connecteur;
import dao.DaoModele;

public class BillService {
	private static BillService instance;
	private BillService(){
		
	}
	public static BillService getInstance(){
		if(instance==null)
			instance =  new BillService();
		return instance;
	}
	
	public void addItems(String[]iditems, String[]pus,String[]estimations,int idbill) throws Exception{
		Connection conn=null;
		try{
			conn = Connecteur.getConnection();
			addItems(iditems, pus, estimations,idbill,conn);
		}
		catch(Exception ex){
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	
	public void addItems(String[]iditems, String[]pus,String[]estimations,int idbill,Connection conn) throws Exception{
		if(iditems==null || iditems.length==0){
			return;
		}
		int taille=iditems.length;
		List<BillItem> list=new ArrayList<BillItem>();
		for(int i=0;i<taille;i++){
			int iditem =Integer.valueOf("0"+iditems[i]);
			double pu = Double.valueOf("0"+pus[i]);
			double estimation = Double.valueOf("0"+estimations[i]);
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
			
		}
		DaoModele.getInstance().save(list, conn);
	}
}
