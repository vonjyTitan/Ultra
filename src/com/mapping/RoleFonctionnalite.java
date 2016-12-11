package com.mapping;

import com.annotations.Entity;

@Entity(reference="rolefonctionnalite")
public class RoleFonctionnalite extends DataEntity {
	private int idrole;
	private int idfonctionnalite;
	public int getIdrole() {
		return idrole;
	}
	public void setIdrole(int idrole) {
		this.idrole = idrole;
	}
	public int getIdfonctionnalite() {
		return idfonctionnalite;
	}
	public void setIdfonctionnalite(int idfonctionnalite) {
		this.idfonctionnalite = idfonctionnalite;
	}
	
}
