package com.mapping;

import java.sql.Date;

import com.annotations.Entity;
import com.annotations.Parameter;
import com.annotations.Required;

@Entity(pkName="idmoisprojet", reference="moisprojet",actionName="decompte")
public class Estimation extends DataEntity {
	private int idmoisprojet;
	private int idprojet;
	private int idutilisateur;
	private double estimation;
	private double total;
	@Required
	@Parameter(libelle="Month")
	private Date mois;
	@Parameter(libelle="Date of Discount")
	private Date datedecompte;
	@Parameter(libelle="Date of certificate")
	private Date datecertification;
	@Parameter(libelle="Less Repayment of Advance")
	private double remboursement;
	private int etat;
	private double matonsitecredit;
	private double matonsitedebit;
	private String code;
	private String libelle;
	private String description;
	@Parameter(libelle="Less Retention Money")
	private Double retenue;
	
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
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
	public Date getMois() {
		return mois;
	}
	public void setMois(Date mois) {
		this.mois = mois;
	}
	public Date getDatedecompte() {
		return datedecompte;
	}
	public void setDatedecompte(Date datedecompte) {
		this.datedecompte = datedecompte;
	}
	public Date getDatecertification() {
		return datecertification;
	}
	public void setDatecertification(Date datecertification) {
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
	public Double getRetenue() {
		return retenue;
	}
	public void setRetenue(Double retenue) {
		this.retenue = retenue;
	}
	
}