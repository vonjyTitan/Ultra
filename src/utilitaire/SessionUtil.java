package utilitaire;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;

import com.mapping.Utilisateur;
import com.service.LoginService;

public class SessionUtil {
	
	public static void testAcces(HttpServletRequest request)throws Exception{
		String cible=getValForAttr(request,"cible");
		if(!LoginService.getInstance().isAllowed((Utilisateur) request.getSession().getAttribute("utilisateur"),cible))
			throw new Exception("You do not have access to this page");
	}
	
	public static void isExisteSession(HttpServletRequest request)throws Exception{
		if(request.getSession().getAttribute("utilisateur")==null)
			throw new Exception("Please login first!");
	}
	public static String getValForAttr(HttpServletRequest request,String attr){
		String reponse=request.getParameter(attr);
		if(reponse==null || reponse.compareToIgnoreCase("null")==0 || reponse.length()==0)
		{
			reponse = (String) request.getAttribute(attr);
			if(reponse==null || reponse.compareToIgnoreCase("null")==0 || reponse.length()==0)
				reponse="";
		}
		return reponse;
	}
	public static String getValForAttr(List<FileItem> items,String attr){
		String response = "";
		boolean trouver = false;
		for (FileItem item : items) {
            if (item.isFormField() && item.getFieldName().compareToIgnoreCase(attr)==0) {
            	trouver = true;
            	response+= (response.length()>0) ? ","+item.getString() : item.getString();
            } 
		}
		if(trouver)
			return response;
		return null;
	}
	public static String[] getParameterValues(List<FileItem> items,String attr){
		String val = getValForAttr(items,attr);
		return val!=null ? val.split(",") : new String[]{};
	}
	
}
