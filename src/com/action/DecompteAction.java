package com.action;

import java.io.OutputStream;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.affichage.HTMLBuilder;
import com.mapping.Bill;
import com.mapping.Estimation;
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
		Estimation estimation = new HTMLBuilder<Estimation>(new Estimation(), request).getEntity();
		
		Connection conn = null;
		 try{
			 conn = Connecteur.getConnection();
			 conn.setAutoCommit(false);

			 if(request.getParameterValues("quantite")!= null && request.getParameterValues("idbillitem")!=null && request.getParameterValues("idmoisprojet")!= null)
			 {
				 DecompteService.getInstance().setEstimationEtat(estimation.getIdmoisprojet(),conn);
				 String[] quantite=request.getParameterValues("quantite");
				 String idbillitem=request.getParameter("idbillitem");
				 String idmoisprojet=request.getParameter("idmoisprojet");
				 for(int i= 0;i< quantite.length;i++)
				 {
					 DecompteService.getInstance().setQuantityItemProject(Double.parseDouble(quantite[i]), Integer.parseInt(idmoisprojet) , Integer.parseInt(idbillitem),conn);
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
		
		 goTo(request,response,"main.jsp?cible=decompte/decompte-fiche&id="+estimation.getIdmoisprojet()+"&erreur=ugyh");
	}
	
	
	public void extract(HttpServletRequest request,HttpServletResponse response)throws Exception{
		{
		    OutputStream out = null;
		    try
		    {
			     response.setContentType("application/vnd.ms-excel");
			     response.setHeader("Content-Disposition", 
			    "attachment; filename=sampleName.xls");
			 
			     WritableWorkbook w = Workbook.createWorkbook(response.getOutputStream());
			     WritableSheet s = w.createSheet("PAYMENT CERTIFICATE", 0);
			 
			     s.addCell(new Label(0, 0, "Hello World"));
			     
			     
			     w.write();
			     w.close();
		 
		    } catch (Exception e)
		    {
		     throw new ServletException("Exctraction error", e);
		    } finally
		    {
		     if (out != null)
		      out.close();
		    }
		}
	}
}
