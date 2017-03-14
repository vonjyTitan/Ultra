package com.mapping;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class DecompteExtraction {
	private List<BillExtraction> bills;
	private int idcertificat;
	private Date certificatdate;
	private String contractor;
	private Double precedantretention;
	private Double cummulretention;
	
	public DecompteExtraction(){
		setBills(new ArrayList<BillExtraction>());
	}


	public List<BillExtraction> getBills() {
		return bills;
	}


	public void setBills(List<BillExtraction> bills) {
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
	
}

