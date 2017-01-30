package com.mapping;

import com.annotations.Entity;
import com.annotations.ForeignKey;
import com.annotations.NumberRestrict;
import com.annotations.Parameter;
import com.annotations.Required;

@Entity(pkName="idbillitem",reference="billitem")
public class BillItem extends DataEntity {
	private int idbillitem;
	private int idbill;
	private int iditem;
	@Parameter(libelle="Price")
	private double pu;
	@Parameter(libelle="Estimate")
	private double estimation;
	private String code;
	@Parameter(libelle="Unit")
	private String unite;
	@Parameter(libelle="label")
	private String libelle;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getUnite() {
		return unite;
	}
	public void setUnite(String unite) {
		this.unite = unite;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
	public void setEstimation(double estimation) {
		this.estimation = estimation;
	}
	
	public int getIdbillitem() {
		return idbillitem;
	}
	public void setIdbillitem(int idbillitem) {
		this.idbillitem = idbillitem;
	}
	public int getIdbill() {
		return idbill;
	}
	public void setIdbill(int idbill) {
		this.idbill = idbill;
	}
	public int getIditem() {
		return iditem;
	}
	public void setIditem(int iditem) {
		this.iditem = iditem;
	}
	public Double getPu() {
		return pu;
	}
	public void setPu(double pu) {
		this.pu = pu;
	}
	public Double getEstimation() {
		return estimation;
	}
	public void setEstimation(Double estimation) {
		this.estimation = estimation;
	}
	
}
