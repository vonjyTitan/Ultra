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
import org.apache.struts2.dispatcher.multipart.MultiPartRequest;

import com.affichage.HTMLBuilder;
import com.mapping.Bill;
import com.mapping.MatOnSite;
import com.mapping.Projet;
import com.rooteur.Action;
import com.service.FileService;
import com.service.ProjetService;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.ConstantEtat;
import utilitaire.SessionUtil;

public class ProjetAction extends Action {
	public void ajout(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		Projet projet = new HTMLBuilder<Projet>(new Projet(), request).getEntity();
		if(!projet.isValide()){
			goTo(request,response,"main.jsp?cible=projet/projet-ajout&erreur=ugyh");
			return;
		}
		
		String[] idingenieurs = SessionUtil.getParameterValues(projet.getFileItems(), "idingenieur");
		String[] codebills = SessionUtil.getParameterValues(projet.getFileItems(), "codebill");
		String[] libellebills = SessionUtil.getParameterValues(projet.getFileItems(), "libellebill");
		String[] mois = SessionUtil.getParameterValues(projet.getFileItems(), "dateestimation");
		String[] estim = SessionUtil.getParameterValues(projet.getFileItems(), "estimation");
		String[] descriptionbill = SessionUtil.getParameterValues(projet.getFileItems(), "descriptionbill");
		
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
			 FileService.getInstance().saveAndUploadFile(projet,conn);
			 conn.commit();
			 goTo(request, response, "get","main.jsp?cible=projet/projet-fiche&id="+projet.getIdprojet());
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
	public void modif(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Projet projet = new HTMLBuilder<Projet>(new Projet(), request).getEntity();
		if(!projet.isValide()){
			goTo(request,response,"main.jsp?cible=projet/projet-modif&id="+projet.getIdprojet()+"&erreur=ugyh");
			return;
		}
		Projet depart = DaoModele.getInstance().findById(projet);
		projet.setEtat(depart.getEtat());
		DaoModele.getInstance().update(projet);
		goTo(request, response, "get","main.jsp?cible=projet/projet-fiche&id="+projet.getIdprojet());
	}
	public void ajoutmatonsite(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String[] idmats=request.getParameterValues("idmateriel");
		String[] pus=request.getParameterValues("pu");
		ProjetService.getInstance().addMatOnSite(idmats, pus,Integer.valueOf(SessionUtil.getValForAttr(request, "idprojet")));
		goTo(request, response, "get","main.jsp?cible=projet/projet-fiche&id="+SessionUtil.getValForAttr(request, "idprojet"));
	}
	public void modifmatonsite(HttpServletRequest request, HttpServletResponse response)throws Exception{
		int idmatonsite = Integer.valueOf(SessionUtil.getValForAttr(request, "idmatonsite"));
		double pu = Double.valueOf(SessionUtil.getValForAttr(request, "pu"));
		if(pu<=0){
			throw new Exception("PU must be positif");
		}
		MatOnSite data = DaoModele.getInstance().findById(new MatOnSite(), idmatonsite);
		data.setPu(pu);
		DaoModele.getInstance().update(data);
		goTo(request, response, "get","main.jsp?cible=projet/projet-fiche&id="+data.getIdprojet());
	}
}
