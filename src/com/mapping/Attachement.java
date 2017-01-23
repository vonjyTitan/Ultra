package com.mapping;

import com.annotations.Entity;
import com.annotations.Parameter;

@Entity(pkName="idattachement",reference="attachement")
public class Attachement extends DataEntity{
	private int idattachement;
	@Parameter(reference="nomtable")
	private String table;
	private int idintable;
	private String cible;
	public int getIdattachement() {
		return idattachement;
	}
	public void setIdattachement(int idattachement) {
		this.idattachement = idattachement;
	}
	public int getIdintable() {
		return idintable;
	}
	public void setIdintable(int idintable) {
		this.idintable = idintable;
	}
	public String getCible() {
		return cible;
	}
	public void setCible(String cible) {
		this.cible = cible;
	}
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
}
