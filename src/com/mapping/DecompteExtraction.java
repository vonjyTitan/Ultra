package com.mapping;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class DecompteExtraction {
	private List<RowExtraction> bills; //fait
	private int idcertificat; //fait
	private Date certificatdate; //fait
	private String contractor; //fait
	private String societe; //fait
	private RowExtraction retention; //fait
	private RowExtraction subtotal1; //fait
	private RowExtraction subtotal2; //fait
	private RowExtraction avance;
	private RowExtraction lessrepayment; //fait
	private RowExtraction matonsite;//fait
	
	public DecompteExtraction(){
		setBills(new ArrayList<RowExtraction>());
	}
	
	public void calculeSubTotal1(){
		Double last = 0.0;
		Double curr = 0.0;
		Double cumm = 0.0;
		Double tender = 0.0;
		
		for(RowExtraction row:bills){
			tender+=row.getEstimative();
			last+=row.getPrecedant();
			curr+=row.getCurrent();
		}
		cumm=last+curr;
		
		subtotal1 = new RowExtraction();
		subtotal1.setCummulative(cumm);
		subtotal1.setPrecedant(last);
		subtotal1.setCurrent(curr);
		subtotal1.setEstimative(tender);
		
	}
	public void calculeSubTotal2(){
		subtotal2 =  new RowExtraction();
		subtotal2.setCummulative(subtotal1.getCummulative()+retention.getCummulative());
		subtotal2.setCurrent(subtotal1.getCurrent()+retention.getCurrent());
		subtotal2.setPrecedant(subtotal1.getPrecedant()+retention.getPrecedant());
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


	public RowExtraction getLessrepayment() {
		return lessrepayment;
	}


	public void setLessrepayment(RowExtraction resteavance) {
		this.lessrepayment = resteavance;
	}


	public RowExtraction getMatonsite() {
		return matonsite;
	}


	public void setMatonsite(RowExtraction matonsite) {
		this.matonsite = matonsite;
	}
	
}

