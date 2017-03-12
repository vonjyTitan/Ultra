package com.service;

import java.util.ArrayList;
import java.util.List;

import com.mapping.DataEntity;
import com.mapping.DecompteStat;
import com.mapping.Estimation;
import com.mapping.Parametre;
import com.mapping.Projet;
import com.mapping.ProjetStat;

import dao.DaoModele;

public class StatService {

	private static StatService instance=null;
	private StatService(){
		
	}
	public static StatService getInstance(){
		if(instance==null)
			instance = new StatService();
		return instance;
	}
	
	public List<ProjetStat> getStatProjetEnCour() throws Exception{
		Parametre param = ParametreService.getInstance().getParameter(ParametreService.TOP_PROJET_LIMITE);
		ProjetStat crit = new ProjetStat();
		crit.setPackSize(Integer.valueOf(param.getValeur1()));
		List<ProjetStat> reponse = DaoModele.getInstance().findPageGenerique(1, crit);
		return reponse;
	}

	public List<Estimation> getStatProjet(int idprojet) throws Exception{
		
		Estimation crit=new Estimation();
		crit.setNomChampOrder("mois");
		crit.setOrdering(DataEntity.ASC);
		crit.setPackSize(100);
		List<Estimation> EstimationResult=DaoModele.getInstance().findPageGenerique(1, crit," and idprojet= " + idprojet);
		return EstimationResult;
	}
	
}
