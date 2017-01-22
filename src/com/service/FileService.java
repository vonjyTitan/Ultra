package com.service;

import java.io.InputStream;

public class FileService {
	private static FileService instance;
	private FileService(){
		
	}
	public static FileService getInstance(){
		if(instance==null)
			instance = new FileService();
		return instance;
	}
	
	public void saveAndUploadFile(InputStream input,String table,String idintable)throws Exception{
	}
	//public List<>
}
