package com.mapping;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class DecompteExtraction {
	private List<RowExtraction> bills;
	private int idcertificat;
	private Date certificatdate;
	private String contractor;
	private String societe;
	private RowExtraction retention;
	private RowExtraction subtotal1;
	private RowExtraction subtotal2;
	private RowExtraction avance;
	private RowExtraction resteavance;
	private RowExtraction matonsite;
	
	public DecompteExtraction(){
		setBills(new ArrayList<RowExtraction>());
	}


	public List<RowExtraction> getBills() {
		return bills;
	}


	public void setBills(List<RowExtraction> bills) {
		this.bills = bills;
	}

	
	

	public int getIdcertificat() {
		return idcertificat;
	}


	public void setIdcertificat(int idcertificat) {
		this.idcertificat = idcertificat;
	}


	public Date getCertificatdate() {
		return certificatdate;
	}


	public void setCertificatdate(Date certificatdate) {
		this.certificatdate = certificatdate;
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


	public RowExtraction getRetention() {
		return retention;
	}


	public void setRetention(RowExtraction retention) {
		this.retention = retention;
	}


	public RowExtraction getSubtotal1() {
		return subtotal1;
	}


	public void setSubtotal1(RowExtraction subtotal1) {
		this.subtotal1 = subtotal1;
	}


	public RowExtraction getSubtotal2() {
		return subtotal2;
	}


	public void setSubtotal2(RowExtraction subtotal2) {
		this.subtotal2 = subtotal2;
	}


	public RowExtraction getAvance() {
		return avance;
	}


	public void setAvance(RowExtraction avance) {
		this.avance = avance;
	}


	public RowExtraction getResteavance() {
		return resteavance;
	}


	public void setResteavance(RowExtraction resteavance) {
		this.resteavance = resteavance;
	}


	public RowExtraction getMatonsite() {
		return matonsite;
	}


	public void setMatonsite(RowExtraction matonsite) {
		this.matonsite = matonsite;
	}
	
}

