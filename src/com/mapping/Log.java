package com.mapping;

import java.sql.Date;

import com.annotations.Entity;

@Entity(pkName="idlog",reference="log")
public class Log extends DataEntity {
	private int idlog;
	private int idutilisateur;
	private String description;
	private int idprojet;
	private Date datelog;
	public int getIdlog() {
		return idlog;
	}
	public void setIdlog(int idlog) {
		this.idlog = idlog;
	}
	public int getIdutilisateur() {
		return idutilisateur;
	}
	public void setIdutilisateur(int idutilisateur) {
		this.idutilisateur = idutilisateur;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getIdprojet() {
		return idprojet;
	}
	public void setIdprojet(int idprojet) {
		this.idprojet = idprojet;
	}
	public Date getDatelog() {
		return datelog;
	}
	public void setDatelog(Date datelog) {
		this.datelog = datelog;
	}
	
}
