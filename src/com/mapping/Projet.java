package com.mapping;

import com.annotations.Entity;
import com.annotations.ForeignKey;
import com.annotations.Parameter;
import com.annotations.Required;

@Entity(pkName="idprojet",reference="projet")
public class Projet extends DataEntity {
	private int idprojet;
	@Required
	private String code;
	@Parameter(libelle="Name of project")
	@Required
	private String libelle;
	@Parameter(libelle="Localisation")
	private String lieu;
	private String description;
	@ForeignKey(toclasse=Client.class,libtable="nom",pktable="idclient")
	@Parameter(libelle="Custommer")
	private int idclient;
	@ForeignKey(toclasse=Entreprise.class, libtable="nom",pktable="identreprise")
	@Parameter(libelle="Company")
	private int identreprise;
	@Parameter(libelle="Start Date")
	private java.sql.Date datedebut;
	@Parameter(libelle="End Date")
	private java.sql.Date datefin;
	@Parameter(libelle="Status")
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	
}
