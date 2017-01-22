package com.mapping;

import com.annotations.Entity;

@Entity(pkName="idattachement",reference="attachement")
public class Attachement extends DataEntity{
	private int idattachement;
	private String nomtable;
}
