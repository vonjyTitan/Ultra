package com.mapping;

import com.annotations.Entity;
import com.annotations.Parameter;
import com.annotations.Required;

@Entity(pkName="idmoisprojet", reference="moisprojet")
public class Estimation extends DataEntity {
	private int idmoisprojet;
	private int idprojet;
	private int idutilisateur;
	private double estimation;
	private double total;
	@Required
	@Parameter(libelle="Month")
	private String mois;
	@Parameter(libelle="Date of Discount")
	private String datedecompte;
	@Parameter(libelle="Date of certificate")
	private String datecertification;
	@Parameter(libelle="Date of ")
	private double remboursement;
	private int etat;
	private double matonsitecredit;
	private double matonsitedebit;
	public int getIdmoisprojet() {
		return idmoisprojet;
	}
	public void setIdmoisprojet(int idmoisprojet) {
		this.idmoisprojet = idmoisprojet;
	}
	public int getIdprojet() {
		return idprojet;
	}
	public void setIdprojet(int idprojet) {
		this.idprojet = idprojet;
	}
	public int getIdutilisateur() {
		return idutilisateur;
	}
	public void setIdutilisateur(int idutilisateur) {
		this.idutilisateur = idutilisateur;
	}
	public double getEstimation() {
		return estimation;
	}
	public void setEstimation(double estimation) {
		this.estimation = estimation;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public String getMois() {
		return mois;
	}
	public void setMois(String mois) {
		this.mois = mois;
	}
	public String getDatedecompte() {
		return datedecompte;
	}
	public void setDatedecompte(String datedecompte) {
		this.datedecompte = datedecompte;
	}
	public String getDatecertification() {
		return datecertification;
	}
	public void setDatecertification(String datecertification) {
		this.datecertification = datecertification;
	}
	public double getRemboursement() {
		return remboursement;
	}
	public void setRemboursement(double remboursement) {
		this.remboursement = remboursement;
	}
	public int getEtat() {
		return etat;
	}
	public void setEtat(int etat) {
		this.etat = etat;
	}
	public double getMatonsitecredit() {
		return matonsitecredit;
	}
	public void setMatonsitecredit(double matonsitecredit) {
		this.matonsitecredit = matonsitecredit;
	}
	public double getMatonsitedebit() {
		return matonsitedebit;
	}
	public void setMatonsitedebit(double matonsitedebit) {
		this.matonsitedebit = matonsitedebit;
	}
	
}