package com.mapping;

import com.annotations.Entity;

@Entity(pkName="idfonctionnalite",reference="fonctionnalite")
public class Fonctionnalite extends DataEntity {
	private int idfonctionnalite;
	private String description;
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getIdfonctionnalite() {
		return idfonctionnalite;
	}
	public void setIdfonctionnalite(int idfonctionnalite) {
		this.idfonctionnalite = idfonctionnalite;
	}
}
