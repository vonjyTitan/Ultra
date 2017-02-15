package com.mapping;

import java.sql.Date;

import com.annotations.Entity;

@Entity(pkName="idhistorique",reference="historique")
public class Historique extends DataEntity {
	private int idhistorique;
	private int idutilisateur;
	private String action;
	private int idintable;
	private String table;
	private Date datelog;
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
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
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
	
}
