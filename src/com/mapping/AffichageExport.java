package com.mapping;

import java.sql.Date;
import java.util.List;

public class AffichageExport {
	private String contractor;
	private String societe;
	private List<RowExtraction> bills;
	private int idcertificat; 
	private Date certificatdate;
	private RowExtraction retention;
	private RowExtraction subtotal1;
	private RowExtraction subtotal2;
	private RowExtraction avance;
	private RowExtraction lessrepayment;
	private RowExtraction matonsite;
	private RowExtraction total;
	private Double totalAmoutExctVta;
	private Double totalAmoutIncVta;
	private Double addVta;
	private Double contractValue;
	
	
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
	public RowExtraction getLessrepayment() {
		return lessrepayment;
	}
	public void setLessrepayment(RowExtraction lessrepayment) {
		this.lessrepayment = lessrepayment;
	}
	public RowExtraction getMatonsite() {
		return matonsite;
	}
	public void setMatonsite(RowExtraction matonsite) {
		this.matonsite = matonsite;
	}
	public RowExtraction getTotal() {
		return total;
	}
	public void setTotal(RowExtraction total) {
		this.total = total;
	}
	public Double getTotalAmoutExctVta() {
		return totalAmoutExctVta;
	}
	public void setTotalAmoutExctVta(Double totalAmoutExctVta) {
		this.totalAmoutExctVta = totalAmoutExctVta;
	}
	public Double getTotalAmoutIncVta() {
		return totalAmoutIncVta;
	}
	public void setTotalAmoutIncVta(Double totalAmoutIncVta) {
		this.totalAmoutIncVta = totalAmoutIncVta;
	}
	public Double getAddVta() {
		return addVta;
	}
	public void setAddVta(Double addVta) {
		this.addVta = addVta;
	}
	public Double getContractValue() {
		return contractValue;
	}
	public void setContractValue(Double contractValue) {
		this.contractValue = contractValue;
	}
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
