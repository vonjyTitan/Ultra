package com.mapping;

import com.annotations.Entity;

@Entity(pkName="idprojet",reference="projet")
public class Projet extends DataEntity {
	private int idprojet;
	private String libelle;
	private String lieu;
	private String description;
	private int idclient;
	private int identreprise;
	private java.sql.Date datedebut;
	private java.sql.Date datefin;
	private int etat;
	
	public int getIdprojet() {
		return idprojet;
	}
	public void setIdprojet(int idprojet) {
		this.idprojet = idprojet;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
	public String getLieu() {
		return lieu;
	}
	public void setLieu(String lieu) {
		this.lieu = lieu;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getIdclient() {
		return idclient;
	}
	public void setIdclient(int idclient) {
		this.idclient = idclient;
	}
	public int getIdentreprise() {
		return identreprise;
	}
	public void setIdentreprise(int identreprise) {
		this.identreprise = identreprise;
	}
	public java.sql.Date getDatedebut() {
		return datedebut;
	}
	public void setDatedebut(java.sql.Date datedebut) {
		this.datedebut = datedebut;
	}
	public java.sql.Date getDatefin() {
		return datefin;
	}
	public void setDatefin(java.sql.Date datefin) {
		this.datefin = datefin;
	}
	public int getEtat() {
		return etat;
	}
	public void setEtat(int etat) {
		this.etat = etat;
	}
	
	
}
