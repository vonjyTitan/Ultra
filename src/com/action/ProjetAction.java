package com.action;

import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.FilenameUtils;

import com.affichage.HTMLBuilder;
import com.mapping.Bill;
import com.mapping.Projet;
import com.rooteur.Action;
import com.service.FileService;
import com.service.ProjetService;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.ConstantEtat;

public class ProjetAction extends Action {
	public void ajout(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Projet projet = new HTMLBuilder<Projet>(new Projet(), request).getEntity();
		if(!projet.isValide()){
			goTo(request,response,"main.jsp?cible=projet/projet-ajout&erreur=ugyh");
			return;
		}
		
		String[] idingenieurs = request.getParameterValues("idingenieur");
		String[] codebills = request.getParameterValues("codebill");
		String[] libellebills = request.getParameterValues("libellebill");
		String[] mois = request.getParameterValues("dateestimation");
		String[] estim = request.getParameterValues("estimation");
		String[] descriptionbill = request.getParameterValues("descriptionbill");
		
		Connection conn = null;
		 try{
			 conn = Connecteur.getConnection();
			 conn.setAutoCommit(false);
			 projet.setEtat(ConstantEtat.PROJET_CREADTED);
			 DaoModele.getInstance().save(projet,conn);
			 
			 if(codebills!=null && codebills.length!=0){
				 List<Bill> bills = new ArrayList<Bill>();
				 Bill bill = null ;
				 int length = codebills.length;
				 for(int i=0;i<length;i++){
					 if(codebills[i]==null && codebills[i].isEmpty())
						 continue;
					 bill = new Bill();
					 bill.setIdprojet(projet.getIdprojet());
					 bill.setCode(codebills[i]);
					 bill.setDescription(descriptionbill[i]);
					 bill.setLibelle(libellebills[i]);
					 bills.add(bill);
				 }
				 DaoModele.getInstance().save(bills, conn);
			 }
			 
			 ProjetService.getInstance().setEstimation(mois, estim, projet.getIdprojet(), conn);
			 ProjetService.getInstance().setIngenieur(idingenieurs, projet.getIdprojet(), conn);
			 FileService.getInstance().saveAndUploadFile(request,"file","projet",projet.getIdprojet(),conn);
			 conn.commit();
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
