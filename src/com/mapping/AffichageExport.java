package com.mapping;

import java.util.List;

public class AffichageExport {
	private String contractor;
	private String societe;
	private List<RowExtraction> bills;
	
	public void setData(DecompteExtraction extraction)
	{
		this.contractor = extraction.getContractor();
		this.societe = extraction.getSociete();
		this.bills = extraction.getBills();
	}
	public List<RowExtraction> getBills(DecompteExtraction extraction){
		List<RowExtraction> retour = extraction.getBills();
		return retour;
	}
	public String getContractor() {
		return contractor;
	}

	public void setContractor(String contractor) {
		this.contractor = contractor;
	}

	public String getSociete() {
		return societe;
	}

	public void setSociete(String societe) {
		this.societe = societe;
	}

	public List<RowExtraction> getBills() {
		return bills;
	}
	public void setBills(List<RowExtraction> bills) {
		this.bills = bills;
	}
	
	
	
}
