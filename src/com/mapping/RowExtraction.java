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
		return estimative==null ? 0.0 : estimative;
	}
	public void setEstimative(Double estimative) {
		this.estimative = estimative==null ? 0.0 : estimative;
	}
	public Double getCurrent() {
		return current==null ? 0.0 : current;
	}
	public void setCurrent(Double current) {
		this.current = current==null ? 0.0 : current;
	}
	public Double getCummulative() {
		return cummulative==null ? 0.0 : cummulative;
	}
	public void setCummulative(Double cummulative) {
		this.cummulative = cummulative==null ? 0.0 : cummulative;
	}
	public Double getPrecedant() {
		return precedant==null ? 0.0 : precedant;
	}
	public void setPrecedant(Double precedant) {
		this.precedant = precedant==null ? 0.0 : precedant;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
}
