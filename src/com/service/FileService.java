package com.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import com.mapping.Attachement;
import com.mapping.DataEntity;

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
	
	public void saveAndUploadFile(DataEntity entity,String table,int idintable)throws Exception{
		Connection conn=null;
		try{
			conn = Connecteur.getConnection();
			conn.setAutoCommit(false);
			
			saveAndUploadFile(entity,conn);
			
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
	public void saveAndUploadFile(List<FileItem> items,String table,int idintable)throws Exception{
		Connection conn = null;
		try{
			conn = Connecteur.getConnection();
			conn.setAutoCommit(false);
			
			saveAndUploadFile(items,table,idintable,conn);
			
			conn.commit();
		}
		catch(Exception ex){
			if(conn!=null)
				conn.rollback();;
			throw ex;
		}
		finally{
			if(conn!=null)
				conn.close();
		}
	}
	public void saveAndUploadFile(List<FileItem> items,String table,int idintable,Connection conn)throws Exception{

		String filepath = ConfigUtil.getConfigBundle().getString("file.path")+"/"+table+"_"+idintable;
		File folder = new File(filepath);
		if(!folder.exists()){
			try{
				folder.mkdirs();
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
		if(!folder.exists())
			return;
		for (FileItem item : items) {
            if (!item.isFormField()) {
                InputStream stream = item.getInputStream();
                if(item.getName() == null || item.getName().isEmpty()||item.getSize() == 0)
                	continue;
        		OutputStream output = null;
        		try{
        			String filename = item.getName();
        			Attachement attache = new Attachement();
        			attache.setTable(table);
        			attache.setIdintable(idintable);
        			attache.setCible(table+"_"+idintable+"/"+filename);
        			DaoModele.getInstance().save(attache, conn);
        			
        			File tofile = new File(filepath+"/"+filename);
        			output = new FileOutputStream(tofile);
        			byte[] scid = new byte[1024];
        			while((stream.read(scid))>0){
        				output.write(scid);
        			}
        			output.flush();
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
        }
	}
	public void saveAndUploadFile(DataEntity entity,Connection conn)throws Exception{
		int idintable=(int) entity.getPkValue();
		String table=entity.findReference();
		List<FileItem> items =entity.getFileItems();
		saveAndUploadFile(items,table,idintable,conn);
	}
	
	public List<Attachement> getAttachement(String nomtable,int idintable)throws Exception{
		Attachement crit = new Attachement();
		crit.setTable(nomtable);
		crit.setIdintable(idintable);
		return DaoModele.getInstance().findPageGenerique(1, crit);
	}
}
