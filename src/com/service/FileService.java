package com.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.apache.commons.io.FilenameUtils;

import com.mapping.Attachement;

import dao.Connecteur;
import dao.DaoModele;
import utilitaire.ConfigUtil;

public class FileService {
	private static FileService instance;
	private FileService(){
		
	}
	public static FileService getInstance(){
		if(instance==null)
			instance = new FileService();
		return instance;
	}
	
	public void saveAndUploadFile(HttpServletRequest request,String fileInputname,String table,int idintable)throws Exception{
		Connection conn=null;
		try{
			conn = Connecteur.getConnection();
			conn.setAutoCommit(false);
			
			saveAndUploadFile(request,fileInputname,table,idintable,conn);
			
			conn.commit();
		}
		catch(Exception ex){
			if(conn!=null)
				conn.rollback();
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	
	public void saveAndUploadFile(HttpServletRequest request,String fileInputname,String table,int idintable,Connection conn)throws Exception{
		Part part = request.getPart(fileInputname);
		if(part==null)
			return;
		InputStream stream = null;
		OutputStream output = null;
		try{
			String filename = table+"_"+idintable+"."+FilenameUtils.getExtension(getSubmittedFileName(part));
			Attachement attache = new Attachement();
			attache.setTable(table);
			attache.setIdintable(idintable);
			attache.setCible(filename);
			DaoModele.getInstance().save(attache, conn);
			
			stream = part.getInputStream();
			String filepath = ConfigUtil.getConfigBundle().getString("file.file.path");
			File tofile = new File(filepath+"/"+filename);
			output = new FileOutputStream(tofile);
			byte[] scid = new byte[1024];
			while((stream.read(scid))>0){
				output.write(scid);
			}
		}
		catch(Exception ex){
			throw ex;
		}
		finally
		{
			if(stream!=null)
				stream.close();
			if(output!=null)
				output.close();
		}
	}
	
	public List<Attachement> getAttachement(String nomtable,int idintable)throws Exception{
		Attachement crit = new Attachement();
		crit.setTable(nomtable);
		crit.setIdintable(idintable);
		return DaoModele.getInstance().findPageGenerique(1, crit);
	}
	
	private static String getSubmittedFileName(Part part) {
	    for (String cd : part.getHeader("content-disposition").split(";")) {
	        if (cd.trim().startsWith("filename")) {
	            String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
	            return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
	        }
	    }
	    return null;
	}
}
