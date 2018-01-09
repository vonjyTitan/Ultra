package com.affichage;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.Session;

import com.mapping.DataEntity;
import com.mapping.ListPaginner;
import com.mapping.DataEntity;

import dao.DaoModele;
import utilitaire.SessionUtil;
import utilitaire.UtileAffichage;

public class TableBuilder<T extends DataEntity>  extends HTMLBuilder<T>{
	private List<T> data=null;
	private String lienForId=null;
	private String apresWhere="";
	protected String lien="";
	private int actualPage=1;
	private String classForTabe="table table-striped table-advance table-hover table-bordered";
	private Map<Champ,String> classForEntete=null;
	private Map<Champ,String> lienForChamp=null;
	private Map<Champ,Champ> idchampForchamp=null;
	private FilterBuilder filterBuilder=null;
	private boolean isWithFilter=false;
	private String addnewUrl;
	
	public TableBuilder(T entity,HttpServletRequest request) throws Exception{
		super(entity,request);
		this.request=request;
		classForEntete=new HashMap<Champ,String>();
		lienForChamp=new HashMap<Champ,String>();
		idchampForchamp=new HashMap<Champ,Champ>();
		setFilterBuilder(new FilterBuilder(entity, request,this));
	}
	public TableBuilder(T entity,ListPaginner<T> data,HttpServletRequest request) throws Exception{
		this(entity,request);
		this.setData(data);
		this.request=request;
	}
	
	public String getHTML(boolean withcheckbox,String nomCheckbox) throws Exception{
		testData();
		String reponse="<div class=\"col-lg-12 col-md-12 col-sm-12 table-responsive\">";
		reponse+="<table class=\""+getClassForTabe()+"\">";
		
		reponse+="<thead>";
		reponse+="<tr>";
		if(withcheckbox){
			reponse+="<th></th>";
		}
		Champ pk=getFieldByName(entity.getPkName());
		Boolean nvid=pk==null || isNotVisible(pk);
		if(!nvid){
			reponse+="<th>"+getSigne(pk.getField())+" <a href=\""+getSimpleLien()+"&nomChampOrder="+pk.getName()+"&ordering="+getOrderForField(pk.getField())+"\">"+pk.getLibelle()+"</a></th>";
		}
		for(Champ f:fieldsAvalaible){
			if(f.getName().compareToIgnoreCase(entity.getPkName())==0 || isNotVisible(f))
				continue;
			reponse+="<th>"+getSigne(f.getField())+" <a href=\""+getSimpleLien()+"&nomChampOrder="+entity.getReferenceForField(f.getField())+"&ordering="+getOrderForField(f.getField())+"\"> "+f.getLibelle()+"<a></th>";
		}
		reponse+="<th>Options</th>";
		reponse+="</tr>";
		reponse+="</thead>";
		reponse+="<tbody>";
		for(DataEntity ob:data)
		{
			if(!nvid){
				Object valId=ob.getPkValue();
				reponse+="<tr id=\"tr"+valId+"\">";
				if(withcheckbox){
					reponse+="<td style=\"text-align:left;\"><input type=\"checkbox\" value=\""+valId+"\" name=\""+nomCheckbox+"\"/></td>";
				}
				String idval="<td style=\"text-align:left;\">"+valId+"</td>";
				if(lienForId!=null){
					idval="<td style=\"text-align:left;\"><a href=\""+lienForId+"&id="+valId+"\">"+valId+"</a></td>";
				}
				
				reponse+=idval;
			}
			for(Champ f:fieldsAvalaible){
				if(f.getName().compareToIgnoreCase(entity.getPkName())==0 || isNotVisible(f))
					continue;
				Object value=null;
				value=f.getMethodForChamp().invoke(ob, null);
				Class type = f.getField().getType();
				if(type.equals(Date.class) ||type.equals(java.sql.Date.class)){
					value=UtileAffichage.formatAfficherDate((java.sql.Date) value);
				}
				else if((type.equals(Double.class) || type.equals(double.class) || type.equals(Float.class) || type.equals(float.class))){
					value=UtileAffichage.formatMoney(value);
				}
				else if(type.equals(String.class)){
					value=UtileAffichage.getNonNullValue(value, type);
				}
				if(value !=null && DataEntity.isNumberType(value.getClass()))
					reponse+="<td>"+getLienForField(f, value,ob)+"</td>";
				else
					reponse+="<td style=\"text-align:left;\">"+getLienForField(f, value,ob)+"</td>";
			}
			ob.setLienForModif(entity.getLienForModif());
			ob.setLienForDelete(entity.findLienForDelete());
			reponse+="<td style=\"text-align:left;\">"+getOption(ob)+"</td>";
			reponse+="</tr>";
		}
		reponse+="</tbody>";
		reponse+= "</table>";
		reponse+=getAddButton();
		reponse+= getPaginnation();
		reponse+="</div>";
		return reponse;
	}
	public boolean IsShowAddNewButton(){
		return this.getAddnewUrl()!=null && this.getAddnewUrl()!="";
	}
	public String getAddButton(){
		if(IsShowAddNewButton())
			return "<div class=\"col-lg-6\"><a class=\"btn btn-primary pull-left\" href=\""+this.getAddnewUrl()+"\">Add new</a></div>";
		else return "";
	}
	public String getAddnewUrl() {
		return this.addnewUrl;
	}
	public void setAddnewUrl(String url) {
		this.addnewUrl = url;
	}
	
	public String getOption(DataEntity ob) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		return ob.getOption();
	}
	private String getSigne(Field f){
		if(classForEntete.containsKey(f))
			return "<i class=\""+classForEntete.get(f)+"\"></i>";
		return "";
	}
	public String getPaginnation() throws Exception
	{
		testData();
		String sizeClass = IsShowAddNewButton() ? "6" : "12";
		String reponse="<div class=\"col-lg-"+sizeClass+"\">";
		reponse+=  "<ul class=\"pagination  pull-right\">";
		int page=((ListPaginner<T>)data).nbPage;
		if(actualPage>1)
			reponse+="<li><a href=\""+getCompletLien()+"&page="+(actualPage-1)+"\">&laquo;</a></li>";
		int depart=actualPage-2;
		while(depart<=0){
			depart++;
		}
		for(int i=0;i<=5 && depart<=page;i++,depart++){
			if(depart==actualPage){
				reponse+=" <li> <a href=\"javascript:;\" style=\"background: #0086de; color: white;\">"+depart+"</a></li>";
			}
			else
				reponse+="<li><a href=\""+getCompletLien()+"&page="+depart+"\"> "+depart+" </a></li>";
		}
		if(actualPage<page){
			reponse+="<li><a href=\""+getCompletLien()+"&page="+(actualPage+1)+"\">&raquo;</a></li> ";
		}
		return reponse+="</ul></div>";
	}
	private void testData()throws Exception{
		if(data!=null)
			return;
		actualPage=Integer.valueOf("0"+((request.getParameter("page")!=null) ? request.getParameter("page") : "1"));
		if(actualPage<1){
			actualPage=1;			
		}
		if(!isWithFilter)
		{
			String lastCh=entity.findNomChampOrder();
			String lastOrd=entity.findOrdering();
			setEntity((T) entity.getClass().newInstance());
			entity.setNomChampOrder(lastCh);
			entity.setOrdering(lastOrd);
		}
		data=DaoModele.getInstance().findPageGenerique(actualPage, entity,apresWhere);
	}
	public String getCompletFilterString() throws Exception{
		return getSimpleFilterString()+"&nomChampOrder="+entity.findNomChampOrder()+"&ordering="+entity.findOrdering();
	}
	public String getSimpleFilterString() throws Exception{
		String reponse="";
		//Field[]fields=entity.getAllFields();
		for(Champ f:fieldsAvalaible)
		{
			reponse+="&"+f.getName()+"="+UtileAffichage.getNonNullValue(super.defaultValudeForField(f), f.getType());
		}
		return reponse;
	}
	public void setClassForEntete(String champ,String classe)throws Exception{
		Champ f=getFieldByName(champ);
		if(f==null)
			throw new Exception("Champ "+champ+" introuvable");
		classForEntete.put(f, classe);
	}
	public void setClassForEntete(String []champ,String []classe)throws Exception{
		for(int i=0;i<champ.length;i++){
			setClassForEntete(champ[i],classe[i]);
		}
	}
	private String getLienForField(Champ f,Object value,DataEntity ob) throws Exception{
		String reponse="";
		Champ fid=idchampForchamp.get(f);
		if(fid!=null){
			Object id=ob.getValueForField(fid.getField());
			return "<a href=\""+lienForChamp.get(f)+"&id="+id+"\">"+value+"</a>";
		}
		return String.valueOf(value);
	}
	public void setLienForChamp(String champ,String lien,String nomidchamp) throws Exception{
		Champ fchamp=getFieldByName(champ);
		Champ fid=getFieldByName(nomidchamp);
		if(fchamp==null || fid==null)
			throw new Exception("Champ "+champ+" ou "+nomidchamp+" introuvable");
		lienForChamp.put(fchamp, lien);
		idchampForchamp.put(fchamp, fid);
	}
	public void setLienForChamp(String []champ,String []lien,String []nomidchamp) throws Exception{
		for(int i=0;i<champ.length;i++)
			setLienForChamp(champ[i],lien[i],nomidchamp[i]);
	}
	public String getHTML() throws Exception{
		return getHTML(false,"");
	}
	public String getHTMLWithCheckbox() throws Exception{
		return getHTML(true,entity.getPkName());
	}
	public String getHTMLWithCheckbox(String checkboxName) throws Exception{
		return getHTML(true,checkboxName);
	}
	public List<T> getData() {
		return data;
	}
	public void setData(List<T> data) {
		this.data = data;
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public String getLienForId() {
		return lienForId;
	}
	public void setLienForId(String lienForId) {
		this.lienForId = lienForId;
	}
	public String getApresWhere() {
		return apresWhere;
	}
	public void setApresWhere(String apresWhere) {
		this.apresWhere = apresWhere;
	}
	public String getSimpleLien() throws Exception{
		if(lien!="" && lien!=null)
			return lien;
		return request.getRequestURI()+"?cible="+request.getParameter("cible")+"&id="+SessionUtil.getValForAttr(request, "id")+getSimpleFilterString();
	}
	public String getCompletLien() throws Exception {
		if(lien!="" && lien!=null)
			return lien;
		return request.getRequestURI()+"?cible="+request.getParameter("cible")+"&id="+SessionUtil.getValForAttr(request, "id")+getCompletFilterString();
	}
	public String getOrderForField(Field f){
		String lastChampOrder=entity.findNomChampOrder();
		String lastOrder=entity.findOrdering();
		if(lastChampOrder!=null && lastOrder!=null && lastChampOrder.compareTo(entity.getReferenceForField(f))==0 && DataEntity.ASC.contains(lastOrder))
		{
			return DataEntity.DESC;
		}
		return DataEntity.ASC;
	}
	public void setLibelleFor(String champ,String nom)throws Exception{
		super.setLibelleFor(champ, nom);
		try{
			getFilterBuilder().setLibelleFor(champ, nom);
		}
		catch(Exception ex){
			
		}
	}
	public void setLienForDelete(String lien){
		this.entity.setLienForDelete(lien);
	}
	public void setLien(String lien) {
		this.lien = lien;
	}
	public String getClassForTabe() {
		return classForTabe;
	}
	public void setClassForTabe(String classForTabe) {
		this.classForTabe = classForTabe;
	}
	public FilterBuilder getFilterBuilder() {
		return filterBuilder;
	}
	public void setFilterBuilder(FilterBuilder filterBuilder) {
		this.filterBuilder = filterBuilder;
	}
	public void setLienForModif(String lienForModif) {
		entity.setLienForModif(lienForModif);
	}
	public boolean isWithFilter() {
		return isWithFilter;
	}
	public void setWithFilter(boolean isWithFilter) {
		this.isWithFilter = isWithFilter;
	}
}
