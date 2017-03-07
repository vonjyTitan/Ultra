package com.mapping;

import com.annotations.Entity;

@Entity(reference="projet_general_stat")
public class ProjetStat extends DataEntity {
	private int idprojet;
	private String code;
	private String libelle;
	private Double estimation;
	private Double actuel;
	public int getIdprojet() {
		return idprojet;
	}
	public void setIdprojet(int idprojet) {
		this.idprojet = idprojet;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
	public Double getEstimation() {
		return estimation;
	}
	public void setEstimation(Double estimation) {
		this.estimation = estimation;
	}
	public Double getActuel() {
		return actuel;
	}
	public void setActuel(Double actuel) {
		this.actuel = actuel;
	}
	
	
}
