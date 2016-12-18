package com.mapping;

import com.annotations.Entity;
import com.annotations.ForeignKey;
import com.annotations.Parameter;
import com.annotations.Required;

@Entity(pkName="idmateriel",reference="materiel")
public class Materiel extends DataEntity {
	@Parameter(libelle="idmaterial")
	private int idmateriel;
	@ForeignKey(toclasse=Unite.class,pktable="idunite",libtable="libelle")
	@Parameter(libelle="Unit")
	private int idunite;
	@Required
	@Parameter(libelle="label")
	private String libelle;
	private String description;
	@Parameter(libelle="Unit")
	private String unite;
	public int getIdmateriel() {
		return idmateriel;
	}
	public void setIdmateriel(int idmateriel) {
		this.idmateriel = idmateriel;
	}
	public int getIdunite() {
		return idunite;
	}
	public void setIdunite(int idunite) {
		this.idunite = idunite;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getLibelle() {
		return libelle;
	}
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}
	public String getUnite() {
		return unite;
	}
	public void setUnite(String unite) {
		this.unite = unite;
	}
}
