package com.mapping;

import com.annotations.Entity;

@Entity(reference="itemrapport",pkName="iditemrapport")
public class ItemRapport extends DataEntity {
	private int iditemrapport;
	private int idmoisprojet;
	private int idbillitem;
	private Double credit;
	private int etat;
	private Double quantiteestime;
	public int getIditemrapport() {
		return iditemrapport;
	}
	public void setIditemrapport(int iditemrapport) {
		this.iditemrapport = iditemrapport;
	}
	public int getIdmoisprojet() {
		return idmoisprojet;
	}
	public void setIdmoisprojet(int idmoisprojet) {
		this.idmoisprojet = idmoisprojet;
	}
	public int getIdbillitem() {
		return idbillitem;
	}
	public void setIdbillitem(int idbillitem) {
		this.idbillitem = idbillitem;
	}
	public Double getCredit() {
		return credit;
	}
	public void setCredit(Double credit) {
		this.credit = credit;
	}
	public int getEtat() {
		return etat;
	}
	public void setEtat(int etat) {
		this.etat = etat;
	}
	public Double getQuantiteestime() {
		return quantiteestime;
	}
	public void setQuantiteestime(Double quantiteestime) {
		this.quantiteestime = quantiteestime;
	}
}
