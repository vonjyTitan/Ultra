package com.action;

import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.rooteur.Action;
import com.service.FileService;

public class ProjectAction extends Action {
	public void ajout(HttpServletRequest request, HttpServletResponse response)throws Exception{
		 final Part filePart = request.getPart("file");
		 InputStream filecontent = null;
		 try{
			 filecontent = filePart.getInputStream();
			 int idproject = 0;
			//TODO save other information in database
			 FileService.getInstance().saveAndUploadFile(filecontent,"projet",String.valueOf(idproject));
		 }
		 catch(Exception ex){
			 throw new Exception("Internal server error");
		 }
		 finally{
			 if(filecontent!=null)
				 filecontent.close();
		 }
	}
}
