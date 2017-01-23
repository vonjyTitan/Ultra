package com.service;

public class BillService {
	private static BillService instance;
	private BillService(){
		
	}
	public static BillService getInstance(){
		if(instance==null)
			instance =  new BillService();
		return instance;
	}
}
