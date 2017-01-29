package com.mapping;

import com.annotations.Parameter;

public class ItemBill extends Item {

	@Parameter(libelle="Price")
	private double pu;
	@Parameter(libelle="Estimate")
	private double estimation;
	

	public double getEstimation() {
		return estimation;
	}
	public void setEstimation(double estimation) {
		this.estimation = estimation;
	}
	public double getPu() {
		return pu;
	}
	public void setPu(double pu) {
		this.pu = pu;
	}
}
