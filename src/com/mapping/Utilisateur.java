package com.mapping;

import java.lang.reflect.InvocationTargetException;

import com.annotations.Entity;
import com.annotations.ForeignKey;
import com.annotations.Parameter;
import com.annotations.Required;
import com.annotations.StringRestrict;

import utilitaire.UtilCrypto;

@Entity(reference="utilisateur",pkName="idutilisateur")
public class Utilisateur extends DataEntity {
	private int idutilisateur;
	@Required
	@StringRestrict(minLength=4)
	@Parameter(libelle="Last name")
	private String nom;
	@Required
	@StringRestrict(minLength=4)
	@Parameter(libelle="First name")
	private String prenom;
	@Required
	@StringRestrict(minLength=4)
	private String login;
	@Parameter(libelle="Password")
	@Required
	private String passe;
	@Parameter(libelle="Status")
	private int etat;
	@Parameter(libelle="Role of the user",reference="idrole")
	@ForeignKey(toclasse=Role.class,pktable="idrole",libtable="libelle")
	private int idrole;
	private String role;
	
	public int getIdutilisateur() {
		return idutilisateur;
	}
	public void setIdutilisateur(int idutilisateur) {
		this.idutilisateur = idutilisateur;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getPasse() {
		return passe;
	}
	public void setPasse(String passe) {
		this.passe = passe;
	}
	public int getIdrole() {
		return idrole;
	}
	public void setIdrole(int idrole) {
		this.idrole = idrole;
	}
	public String findPasseDecrypted() throws Exception{
		return UtilCrypto.decrypt(passe);
	}
	public String findActive(){
		if(getEtat()==1)
			return "<span class=\"label label-success label-mini\">Active</span>";
		return "<span class=\"label label-danger label-mini\">Not active</span>";
	}
	public String getOption() throws IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		String reponse=super.getOption();
		if(getEtat()==2){
			reponse+= "<a class=\"btn btn-success btn-xs\" href=\"login-active?id="+getIdutilisateur()+"\"><i class=\"fa fa-check\"></i></a>";
		}
		else reponse+="<a class=\"btn btn-danger btn-xs\" href=\"login-desactive?id="+getIdutilisateur()+"\"><i class=\"fa fa-trash-o \"></i></a>";
		return reponse;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public int getEtat() {
		return etat;
	}
	public void setEtat(int etat) {
		this.etat = etat;
	}
	
}
