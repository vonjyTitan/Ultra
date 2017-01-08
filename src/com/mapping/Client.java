package com.mapping;

import com.annotations.Entity;
import com.annotations.Parameter;
import com.annotations.Required;

@Entity(pkName="idclient", reference="client")
public class Client extends DataEntity {
	private int idclient;
	@Required
	@Parameter(libelle="Name")
	private String nom;
	@Parameter(libelle="Description")
	private String description;
	public int getIdclient() {
		return idclient;
	}
	public void setIdclient(int idclient) {
		this.idclient = idclient;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
