package com.action;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affichage.HTMLBuilder;
import com.export.ProcessReports;
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
			estimation.setRetenue(0.0);
			estimation.setDatedecompte(estimation.getMois());
			DaoModele.getInstance().save(estimation, conn);
			DecompteService.getInstance().setDefaultItemRapportForMoisProjet(estimation.getIdmoisprojet(), conn);
			conn.commit();
			goTo(request, response, "get","main.jsp?cible=decompte/decompte-fiche&id="+estimation.getIdmoisprojet());
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
		int id = Integer.parseInt(SessionUtil.getValForAttr(request, "id"));
		try{
			DecompteService.getInstance().certifiedDecompte(id);
		}
		catch(Exception ex){
			ex.printStackTrace();
			 throw new Exception("Internal server error");
		}
		 goTo(request,response,"main.jsp?cible=decompte/decompte-fiche&id="+request.getParameter("idmoisprojet"));
	}
	public void matonsiteupdate(HttpServletRequest request, HttpServletResponse response)throws Exception{
		 String[] credits=request.getParameterValues("credit");
		 String[] idmatonsite=request.getParameterValues("idmatonsite");
		 int idmoisprojet = Integer.valueOf(SessionUtil.getValForAttr(request, "idmoisprojet"));
		 DecompteService.getInstance().decompteMatOnSite(idmoisprojet, credits,idmatonsite);
		 goTo(request,response,"main.jsp?cible=decompte/decompte-fiche&id="+request.getParameter("idmoisprojet"));
	}
	
	public void getcertificate(HttpServletRequest request, HttpServletResponse response)throws Exception{
		int idmoisprojet = 0;
		 if(request.getParameterValues("idmoisprojet")!=null){
			 idmoisprojet = Integer.parseInt(request.getParameter("idmoisprojet"));
		 }
		//File savePath = new File("/Fanilo/Professionel/Maurice/Freelance/BOQ/Developpement/BOQ/Mars/Ultra/WebContent/final.pdf");
		File filePath = new File(request.getServletContext().getRealPath("WEB-INF/test.jrxml"));
		File savePath = new File(request.getServletContext().getRealPath("GeneratedFile/userDetail.pdf"));
		//File filePath = new File("/Fanilo/Professionel/Maurice/Freelance/BOQ/Developpement/BOQ/Mars/Ultra/WebContent/WEB-INF/test.jrxml");
		new ProcessReports().generateReport(filePath , savePath ,idmoisprojet,response);
		
		
				
	}
	
	public void extract(HttpServletRequest request,HttpServletResponse response)throws Exception{
		
	}
}
