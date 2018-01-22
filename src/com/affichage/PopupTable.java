package com.affichage;

import java.lang.reflect.InvocationTargetException;

import javax.servlet.http.HttpServletRequest;

import com.mapping.DataEntity;
import com.mapping.ListPaginner;

import utilitaire.SessionUtil;

public class PopupTable<T extends DataEntity>  extends TableBuilder<T> {

	public PopupTable(T entity, HttpServletRequest request) throws Exception {
		super(entity, request);
	}
	public PopupTable(T entity,ListPaginner<T> data,HttpServletRequest request) throws Exception{
		super(entity,data,request);
	}
	
	@Override
	public String getHTML(boolean withcheckbox,String nomCheckbox) throws Exception{
		setLienForId(null);
		String reponse=super.getHTML(withcheckbox, nomCheckbox);
		return reponse;
	}
	
	@Override
	public String getOption(DataEntity ob) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		String libelle = (String) ob.getValueForField(ob.getFieldByName(SessionUtil.getValForAttr(request, "libtable")));
		return "<a href=\"javascript:;\" onclick=\"select("+ob.getValueForField(ob.getFieldByName(ob.getPkName()))+",'"+libelle+"')\" class=\"btn btn-success  btn-xs\">Select</a>";
	}
	@Override
	public String getSimpleLien() throws Exception {
		if(lien!="" && lien!=null)
			return lien;
		return request.getRequestURI()+"?cible="+request.getParameter("cible")+getCompletFilterString()+"&libtable="+SessionUtil.getValForAttr(request, "libtable")+"&inputname="+SessionUtil.getValForAttr(request, "inputname");
	}
	@Override
	public String getCompletLien() throws Exception {
		if(lien!="" && lien!=null)
			return lien;
		return request.getRequestURI()+"?cible="+request.getParameter("cible")+getCompletFilterString()+"&libtable="+SessionUtil.getValForAttr(request, "libtable")+"&inputname="+SessionUtil.getValForAttr(request, "inputname");
	}
}
