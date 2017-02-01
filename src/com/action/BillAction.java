package com.action;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affichage.HTMLBuilder;
import com.mapping.Bill;
import com.mapping.BillItem;
import com.rooteur.Action;
import com.service.BillService;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.SessionUtil;

public class BillAction extends Action {
	public void ajoutitem(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String[] iditems=request.getParameterValues("iditem");
		String[] pus = request.getParameterValues("pu");
		String[] estimations = request.getParameterValues("estimation");
		String idbill = SessionUtil.getValForAttr(request, "id");
		BillService.getInstance().addItems(iditems, pus, estimations,Integer.valueOf(idbill));
		goTo(request, response, "get","main.jsp?cible=Bill/bill-fiche&id="+idbill);
	}
	public void modifitem(HttpServletRequest request, HttpServletResponse response)throws Exception{
		BillItem bi=new HTMLBuilder<BillItem>(new BillItem(), request).getEntity();
		if(bi.getPu()<=0){
			throw new Exception("PU is must to be positif");
		}
		if(bi.getEstimation()<0){
			throw new Exception("Estimate must to be not negative");
		}
		DaoModele.getInstance().update(bi);
		goTo(request, response, "get","main.jsp?cible=Bill/bill-fiche&id="+bi.getIdbill());
	}
	
	public void ajout(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Bill bill = new HTMLBuilder<>(new Bill(), request).getEntity();
		if(!bill.isValide()){
			goTo(request, response, "main.jsp?cible=Bill/bill-fiche&erreur=hb&id="+bill.getIdprojet());
		}
		String[] iditems=request.getParameterValues("iditem");
		String[] pus = request.getParameterValues("pu");
		String[] estimations = request.getParameterValues("estimation");
		Connection conn = null;
		try{
			conn = Connecteur.getConnection();
			conn.setAutoCommit(false);
			DaoModele.getInstance().save(bill, conn);
			BillService.getInstance().addItems(iditems, pus, estimations, bill.getIdbill(), conn);
			conn.commit();
			goTo(request, response, "get","main.jsp?cible=Bill/bill-fiche&id="+bill.getIdbill());
		}
		catch(Exception ex){
			if(conn!=null)
				conn.rollback();
			throw new Exception("Internal server error");
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
}
