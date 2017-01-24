package com.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.codehaus.jackson.map.ser.std.StdJdkSerializers.FileSerializer;

import com.rooteur.Action;
import com.service.FileService;

public class AttachementAction extends Action{
	public void ajout(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			List<FileItem> items =new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
			String table = "";
			int id = 0;
			String callback = "";
			for (FileItem item : items) {
	            if (item.isFormField()) {
	            		if(item.getName()=="id"){
	            			id = Integer.valueOf("0"+item.getString());
	            		}
	            		else if(item.getName()=="tb"){
	            			table = item.getString();
	            		}
	            		else if(item.getName()=="cb"){
	            			callback = item.getString();
	            		}
	            	}
	            }
			FileService.getInstance().saveAndUploadFile(items, table, id);
			goTo(request, response,"get", "main.jsp?cible="+callback);
		}
		catch(Exception ex){
			ex.printStackTrace();
			throw new Exception("Internal server error");
		}
	}
}
