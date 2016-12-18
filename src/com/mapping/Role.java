package com.mapping;

import com.annotations.Entity;
import com.annotations.Parameter;
import com.annotations.Required;

@Entity(pkName="idrole", reference="role")
public class Role extends DataEntity {
	private int idrole;
	@Required
	@Parameter(libelle="label")
	private String libelle;
	private String description;
	public int getIdrole() {
		return idrole;
	}
	public void setIdrole(int idrole) {
		this.idrole = idrole;
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
