package com.mapping;

import java.sql.Date;

import com.annotations.Entity;

@Entity(reference="moisprojet", pkName="idmoisprojet")
public class Mois extends DataEntity{
	private int idmoisprojet;
	private Date mois;
	private double estimation;
	private int etat;
	private int idprojet;
	public int getIdmoisprojet() {
		return idmoisprojet;
	}
	public void setIdmoisprojet(int idmoisprojet) {
		this.idmoisprojet = idmoisprojet;
	}
	public Date getMois() {
		return mois;
	}
	public void setMois(Date mois) {
		this.mois = mois;
	}
	public double getEstimation() {
		return estimation;
	}
	public void setEstimation(double estimation) {
		this.estimation = estimation;
	}
	public int getEtat() {
		return etat;
	}
	public void setEtat(int etat) {
		this.etat = etat;
	}
	public int getIdprojet() {
		return idprojet;
	}
	public void setIdprojet(int idprojet) {
		this.idprojet = idprojet;
	}
}
