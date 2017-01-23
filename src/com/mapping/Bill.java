package com.mapping;

import com.annotations.Entity;

@Entity(pkName="idbill",reference="bill")
public class Bill extends DataEntity {
	private int idbill;
	private String code;
	private int idprojet;
	private String libelle;
	private String description;
	public int getIdbill() {
		return idbill;
	}
	public void setIdbill(int idbill) {
		this.idbill = idbill;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}
