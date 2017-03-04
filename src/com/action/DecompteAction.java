package com.action;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affichage.HTMLBuilder;
import com.mapping.Bill;
import com.mapping.Estimation;
import com.mapping.ItemRapport;
import com.mapping.Projet;
import com.mapping.Role;
import com.mapping.Utilisateur;
import com.rooteur.Action;
import com.service.DecompteService;
import com.service.FileService;
import com.service.ProjetService;
import com.service.RoleService;

import dao.Connecteur;
import dao.DaoModele;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import utilitaire.ConstantEtat;
import utilitaire.SessionUtil;

public class DecompteAction extends Action {
	public void ajout(HttpServletRequest request,HttpServletResponse response)throws Exception{
		Estimation estimation = new HTMLBuilder<>(new Estimation(), request).getEntity();
		if(!estimation.isValide()){
			goTo(request, response, "main.jsp?cible=deompte/decompte-ajout&id="+estimation.getIdprojet()+"&erreur=sdf");
			return;
		}
		Connection conn=null;
		try{
			Utilisateur user = ((Utilisateur)request.getSession().getAttribute("utilisateur"));
			conn = Connecteur.getConnection();
			conn.setAutoCommit(false);
			estimation.setEtat(ConstantEtat.MOIS_CREATED);
			estimation.setIdutilisateur(user.getIdutilisateur());
			DaoModele.getInstance().save(estimation, conn);
			DecompteService.getInstance().setDefaultItemRapportForMoisProjet(estimation.getIdmoisprojet(), conn);
			conn.commit();
			goTo(request, response, "get","main.jsp?cible=decompte/deompte-fiche&id="+estimation.getIdmoisprojet());
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
	public void decompte(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Connection conn = null;
		 try{
			 conn = Connecteur.getConnection();
			 conn.setAutoCommit(false);
			 int idmoisprojet = 0;
			 
			 int etat = ConstantEtat.MOIS_DECOMPTE;
			 if(request.getParameterValues("idmoisprojet")!=null){
				 idmoisprojet = Integer.parseInt(request.getParameter("idmoisprojet"));
			 }
			 if(request.getParameterValues("etat")!= null){
				 etat = Integer.parseInt(request.getParameter("etat"));
			 }
			 if(etat == ConstantEtat.MOIS_CERTIFIED){
				 DecompteService.getInstance().setEstimationEtat(idmoisprojet, ConstantEtat.MOIS_CERTIFIED, conn);
			 }
			 else
			 {
				 if(request.getParameterValues("quantite")!= null && request.getParameterValues("idbillitem")!=null)
				 {
					 String[] iditemrapports=request.getParameterValues("iditemrapport");
					 String[] quantite=request.getParameterValues("quantite");
					 String[] estimate=request.getParameterValues("estimate");
					 
					 String idbillitem=request.getParameter("idbillitem");
					 double somme =0;
					 
					 for(int i= 0;i< quantite.length;i++)
					 {
						 ItemRapport RapportCrit = new ItemRapport();
						 RapportCrit.setNomTable("itemrapport_libelle");
						 double quantiteItem = Double.parseDouble(quantite[i]);
						 double estmateItem = Double.parseDouble(estimate[i]);
						 double montant = 0;
						 ItemRapport itemrapport = DaoModele.getInstance().findById(RapportCrit,Integer.parseInt(iditemrapports[i]));
						 if(quantiteItem> 0){
							 montant = itemrapport.getPu() * quantiteItem;
							 somme =  somme + montant;
							 DecompteService.getInstance().setQuantityItemProject(quantiteItem, Integer.parseInt(iditemrapports[i]) ,conn);
							 DecompteService.getInstance().setEstimateItemProject(0, Integer.parseInt(iditemrapports[i]) ,conn);
						 }
						 else{
							 montant = itemrapport.getPu() * Double.parseDouble(estimate[i]);
							 somme =  somme + montant;
							 DecompteService.getInstance().setEstimateItemProject(estmateItem, Integer.parseInt(iditemrapports[i]) ,conn);	
							 DecompteService.getInstance().setQuantityItemProject(0, Integer.parseInt(iditemrapports[i]) ,conn);
						 }
						 DecompteService.getInstance().setMontantItemProject(montant, Integer.parseInt(iditemrapports[i]) ,conn);
					 }
					 DecompteService.getInstance().setEstimationEtat(idmoisprojet, etat, conn);
					 DecompteService.getInstance().setEstimationTotal(idmoisprojet,somme,conn);
				 }					 
			 }
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
		
		 goTo(request,response,"main.jsp?cible=decompte/decompte-fiche&id="+request.getParameter("idmoisprojet"));
	}
	
	public void certified(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Connection conn = null;
		 try{
			 conn = Connecteur.getConnection();
			 conn.setAutoCommit(false);
			 int id = Integer.parseInt(SessionUtil.getValForAttr(request, "id"));

			 DecompteService.getInstance().setEstimationEtat(id, ConstantEtat.MOIS_CERTIFIED, conn);
			 
			 conn.commit();
			 goTo(request,response,"main.jsp?cible=decompte/decompte-fiche&id="+request.getParameter("idmoisprojet"));
			 
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
		
		 goTo(request,response,"main.jsp?cible=decompte/decompte-fiche&id="+request.getParameter("idmoisprojet"));
	}
	public void matonsiteupdate(HttpServletRequest request, HttpServletResponse response)throws Exception{
		 String[] credits=request.getParameterValues("credit");
		 String[] debits=request.getParameterValues("debit");
		 String[] idmatonsite=request.getParameterValues("idmatonsite");
		 int idmoisprojet = Integer.valueOf(SessionUtil.getValForAttr(request, "idmoisprojet"));
		 DecompteService.getInstance().decompteMatOnSite(idmoisprojet, credits, debits,idmatonsite);
		 goTo(request,response,"main.jsp?cible=decompte/decompte-fiche&id="+request.getParameter("idmoisprojet"));
	}
	public void extract(HttpServletRequest request,HttpServletResponse response)throws Exception{
		{
			WritableWorkbook w=null;
		    Connection conn=null;
		    try
		    {
		    	conn = Connecteur.getConnection();
		    	int idmoisprojet = Integer.valueOf(SessionUtil.getValForAttr(request, "id"));
		    	
			     response.setContentType("application/vnd.ms-excel");
			     response.setHeader("Content-Disposition", 
			    "attachment; filename=PAYMENT_CERTIFICATE_"+idmoisprojet+".xls");
			     
			     Estimation est= DaoModele.getInstance().findById(new Estimation(),idmoisprojet,conn);
			     
			     w = Workbook.createWorkbook(response.getOutputStream());
			     WritableSheet s = w.createSheet("PAYMENT CERTIFICATE", 0);
			     ResultSet rsBill = conn.createStatement().executeQuery("select * from decompte_refactor_val where idmoisprojet="+idmoisprojet);

			     int il=0;
			     s.addCell(new Label(0, il, "BILL"));
			     s.addCell(new Label(1, il, "DESCRIPTION"));
			     s.addCell(new Label(2, il, "TENDER (MUR)"));
			     s.addCell(new Label(3, il, "PREVIOUS (MUR)"));
			     s.addCell(new Label(4, il, "CURRENT (MUR)"));
			     s.addCell(new Label(5, il, "CUMULATIVE (MUR)"));
			     
			     PreparedStatement ps = conn.prepareStatement("select billitem.idbill,sum(case when ir.credit=0 then ir.credit else ir.quantiteestime end)*billitem.pu as previous "+
					" from billitem "+
					"join itemrapport ir "+
					"on ir.idbillitem=billitem.idbillitem "+
					"join moisprojet mp "+
					"on mp.idmoisprojet=ir.idmoisprojet "+
					"where mp.mois<? and billitem.idbill=? "+
					"group by billitem.idbill");
			     ResultSet rs=null;
			     
			     Double curr=0.0;//current value
			     Double cum=0.0;// cummulle
			     Double prev=0.0;
			     int idbill =0;
			     il++;
			     while(rsBill.next()){
			    	 int icol=0;
			    	 idbill = rsBill.getInt("idbill");
			    	 s.addCell(new Label(icol, il, idbill+""));
			    	 icol++;
			    	 s.addCell(new Label(icol, il, rsBill.getString("libelle")));
			    	 icol++;
	    			 s.addCell(new Label(icol, il, String.valueOf(rsBill.getDouble("estimative"))));
	    			 icol++;
	    			 
	    			 curr = Double.valueOf(rsBill.getDouble("curr"));
	    			 
	    			 ps.setObject(1, est.getMois());
			    	 ps.setObject(2, idbill);
			    	 rs=ps.executeQuery();
			    	 while(rs.next()){
			    		 prev = rs.getDouble("previous");
			    		 cum=prev+curr;
			    		 s.addCell(new Label(icol, il, prev.toString()));
			    	 }
	    			 icol++;
	    			 s.addCell(new Label(icol, il, curr.toString()));
			    	icol++;
			    	 s.addCell(new Label(icol, il, cum.toString()));
			    	 il++;
			     }
			     
			     
			     
			     w.write();
		 
		    } catch (Exception e)
		    {
		     throw new ServletException("Exctraction error", e);
		    } finally
		    {
		     if (w != null)
		      w.close();
		     if(conn!=null)
		    	 conn.close();
		    }
		}
	}
}
