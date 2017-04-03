package com.service;

import java.util.ArrayList;
import java.util.List;

import com.mapping.Client;

public class ExportService {

	public static List<Client> getExportData()
	{
		List<Client> list = new ArrayList<Client>();
		Client c1 = new Client();
		c1.setNom("client1");
		Client c2 = new Client();
		c2.setNom("client2");
		Client c3 = new Client();
		c3.setNom("client3");
		list.add(c2);
		list.add(c1);
		list.add(c3);
		return list;
	}
}
