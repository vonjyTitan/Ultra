package com.mapping;

public class RowExtraction{
	private String libelle;
	private Double estimative;
	private Double current;
	private Double cummulative;
	private Double precedant;
	public RowExtraction(){
		
	}
	public Double getEstimative() {
		return estimative;
	}
	public void setEstimative(Double estimative) {
		this.estimative = estimative;
	}
	public Double getCurrent() {
		return current;
	}
	public void setCurrent(Double current) {
		this.current = current;
	}
	public Double getCummulative() {
		return cummulative;
	}
	public void setCummulative(Double cummulative) {
		this.cummulative = cummulative;
	}
	public Double getPrecedant() {
		return precedant;
	}
	public void setPrecedant(Double precedant) {
		this.precedant = precedant;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
}
