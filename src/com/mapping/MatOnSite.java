package com.mapping;

import com.annotations.Entity;

@Entity(pkName="idmatonsite",reference="matonsite")
public class MatOnSite extends DataEntity {
	private int idmatonsite;
	private int idprojet;
	private int idmateriel;
	private double pu;
	private double credit;
	private double debit;
	private String libelle;
	private String code;
	private Double montant;
	public int getIdmatonsite() {
		return idmatonsite;
	}
	public void setIdmatonsite(int idmatonsite) {
		this.idmatonsite = idmatonsite;
	}
	public int getIdprojet() {
		return idprojet;
	}
	public void setIdprojet(int idprojet) {
		this.idprojet = idprojet;
	}
	public int getIdmateriel() {
		return idmateriel;
	}
	public void setIdmateriel(int idmateriel) {
		this.idmateriel = idmateriel;
	}
	public double getPu() {
		return pu;
	}
	public void setPu(double pu) {
		this.pu = pu;
	}
	public double getCredit() {
		return credit;
	}
	public void setCredit(double credit) {
		this.credit = credit;
	}
	public double getDebit() {
		return debit;
	}
	public void setDebit(double debit) {
		this.debit = debit;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Double getMontant() {
		return montant;
	}
	public void setMontant(Double montant) {
		this.montant = montant;
	}
	
}
