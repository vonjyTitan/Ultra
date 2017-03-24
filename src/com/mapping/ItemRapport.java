package com.mapping;

import java.sql.Date;

import com.annotations.Entity;

@Entity(reference="itemrapport",pkName="iditemrapport")
public class ItemRapport extends DataEntity {
	private int iditemrapport;
	private int idmoisprojet;
	private int idbillitem;
	private Double credit;
	private int etat;
	private Double quantiteestime;
	private String code;
	private String libelle;
	private int idbill;
	private Double pu;
	private Double estimation;
	private Date datedecompte;
	private Double montant;
	private Double last;
	
	
	public Double getPu() {
		return pu;
	}
	public void setPu(Double pu) {
		this.pu = pu;
	}
	public Double getEstimation() {
		return estimation;
	}
	public void setEstimation(Double estimation) {
		this.estimation = estimation;
	}
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
	public int getIdbill() {
		return idbill;
	}
	public void setIdbill(int idbill) {
		this.idbill = idbill;
	}
	public int getIditemrapport() {
		return iditemrapport;
	}
	public void setIditemrapport(int iditemrapport) {
		this.iditemrapport = iditemrapport;
	}
	public int getIdmoisprojet() {
		return idmoisprojet;
	}
	public void setIdmoisprojet(int idmoisprojet) {
		this.idmoisprojet = idmoisprojet;
	}
	public int getIdbillitem() {
		return idbillitem;
	}
	public void setIdbillitem(int idbillitem) {
		this.idbillitem = idbillitem;
	}
	public Double getCredit() {
		return credit;
	}
	public void setCredit(Double credit) {
		this.credit = credit;
	}
	public int getEtat() {
		return etat;
	}
	public void setEtat(int etat) {
		this.etat = etat;
	}
	public Double getQuantiteestime() {
		return quantiteestime;
	}
	public void setQuantiteestime(Double quantiteestime) {
		this.quantiteestime = quantiteestime;
	}
	public Date getDatedecompte() {
		return datedecompte;
	}
	public void setDatedecompte(Date datedecompte) {
		this.datedecompte = datedecompte;
	}
	public Double getMontant() {
		return montant;
	}
	public void setMontant(Double montant) {
		this.montant = montant;
	}
	public Double getLast() {
		return last;
	}
	public void setLast(Double last) {
		this.last = last;
	}
}
