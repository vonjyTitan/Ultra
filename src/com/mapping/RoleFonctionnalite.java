package com.mapping;

import com.annotations.Entity;

@Entity(reference="rolefonctionnalite")
public class RoleFonctionnalite extends DataEntity {
	private int idrole;
	private int idfonctionnalite;
	private String fonctionnalite;
	private String role;
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
	public String getFonctionnalite() {
		return fonctionnalite;
	}
	public void setFonctionnalite(String fonctionnalite) {
		this.fonctionnalite = fonctionnalite;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
}
