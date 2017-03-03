package com.mapping;

import java.sql.Date;

public class DecompteStat extends DataEntity {
	private int idmoisprojet;
	private Date mois;
	private Double estimation;
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
	private Double actuel;
}
