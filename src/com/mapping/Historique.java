package com.mapping;

import java.sql.Date;

import com.annotations.Entity;

@Entity(pkName="idhistorique",reference="historique")
public class Historique extends DataEntity {
	private int idhistorique;
	private int idutilisateur;
	private String action;
	private int idintable;
	private String tablenom;
	private Date datelog;
	private String prenom;
	private String libelle;
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public int getIdintable() {
		return idintable;
	}
	public void setIdintable(int idintable) {
		this.idintable = idintable;
	}
	public int getIdutilisateur() {
		return idutilisateur;
	}
	public void setIdutilisateur(int idutilisateur) {
		this.idutilisateur = idutilisateur;
	}
	public Date getDatelog() {
		return datelog;
	}
	public void setDatelog(Date datelog) {
		this.datelog = datelog;
	}
	public int getIdhistorique() {
		return idhistorique;
	}
	public void setIdhistorique(int idhistorique) {
		this.idhistorique = idhistorique;
	}
	public String getTablenom() {
		return tablenom;
	}
	public void setTablenom(String tablenom) {
		this.tablenom = tablenom;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
	
}
