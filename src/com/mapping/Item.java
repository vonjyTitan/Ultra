package com.mapping;

import com.annotations.Entity;
import com.annotations.ForeignKey;
import com.annotations.Parameter;
import com.annotations.Required;

@Entity(pkName="iditem",reference="item",actionName="item")
public class Item extends DataEntity {
	private String code;
	private int iditem;
	@Parameter(libelle="Unit")
	@ForeignKey(toclasse=Unite.class,pktable="idunite",libtable="libelle")
	private int idunite;
	@Parameter(libelle="Unit")
	private String unite;
	@Required
	@Parameter(libelle="label")
	private String libelle;
	@Parameter(libelle="Description")
	private String discription;
	
	public String getUnite() {
		return unite;
	}
	public void setUnite(String unite) {
		this.unite = unite;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getIditem() {
		return iditem;
	}
	public void setIditem(int iditem) {
		this.iditem = iditem;
	}
	public int getIdunite() {
		return idunite;
	}
	public void setIdunite(int idunite) {
		this.idunite = idunite;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
	public String getDiscription() {
		return discription;
	}
	public void setDiscription(String description) {
		this.discription = description;
	}
}
