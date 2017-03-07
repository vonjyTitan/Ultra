package com.mapping;

import com.annotations.Entity;

@Entity(reference="parametre",pkName="idparametre")
public class Parametre extends DataEntity {
	private int idparametre;
	private String description;
	private String valeur1;
	private String valeur2;
	public int getIdparametre() {
		return idparametre;
	}
	public void setIdparametre(int idparametre) {
		this.idparametre = idparametre;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getValeur1() {
		return valeur1;
	}
	public void setValeur1(String valeur1) {
		this.valeur1 = valeur1;
	}
	public String getValeur2() {
		return valeur2;
	}
	public void setValeur2(String valeur2) {
		this.valeur2 = valeur2;
	}
}
