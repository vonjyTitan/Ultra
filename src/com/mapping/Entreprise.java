package com.mapping;

import com.annotations.Entity;
import com.annotations.Parameter;
import com.annotations.Required;

@Entity(pkName="identreprise", reference="entreprise")
public class Entreprise extends DataEntity {
	@Parameter(libelle="idcontractor")
	private int identreprise;
	@Required
	@Parameter(libelle="Name")
	private String nom;
	@Parameter(libelle="Description")
	private String description;
	public int getIdentreprise() {
		return identreprise;
	}
	public void setIdentreprise(int identreprise) {
		this.identreprise = identreprise;
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
