package com.service;

import java.sql.Connection;

import com.mapping.Role;

import dao.Connecteur;
import dao.DaoModele;

public class RoleService {
	private static RoleService instance;
	private RoleService(){
		
	}
	
	public static RoleService getInstance(){
		return instance!=null ? instance : (instance = new RoleService()); 
	}
	
	public void insertRole(Role role,String[]idfonctionnalites)throws Exception{
		Connection conn=null;
		try{
			conn=Connecteur.getConnection(role.findDataBaseKey());
			conn.setAutoCommit(false);
			
			DaoModele.getInstance().save(role, conn);
			for(String idfonct : idfonctionnalites){
				DaoModele.getInstance().executeUpdate("INSERT INTO `rolefonctionnalite`(`IDFONCTIONNALITE`, `IDROLE`) VALUES ("+idfonct+","+role.getIdrole()+")", conn);
			}
			conn.commit();
		}
		catch(Exception ex){
			if(conn!=null && !conn.getAutoCommit())
				conn.rollback();
			ex.printStackTrace();
			throw new Exception("An error occurred during the Role add");
		}
		finally{
			if(conn!=null){
				conn.close();
			}
		}
	}
	
	public void updateRole(Role role,String[]idfonctionnalites)throws Exception{
		Connection conn=null;
		try{
			conn=Connecteur.getConnection(role.findDataBaseKey());
			conn.setAutoCommit(false);
			
			DaoModele.getInstance().update(role, conn);
			DaoModele.getInstance().executeUpdate("delete from rolefonctionnalite where idrole="+role.getIdrole(), conn);
			
			for(String idfonct : idfonctionnalites){
				DaoModele.getInstance().executeUpdate("INSERT INTO `rolefonctionnalite`(`IDFONCTIONNALITE`, `IDROLE`) VALUES ("+idfonct+","+role.getIdrole()+")", conn);
			}
			conn.commit();
		}
		catch(Exception ex){
			if(conn!=null && !conn.getAutoCommit())
				conn.rollback();
			ex.printStackTrace();
			throw new Exception("An error occurred during the Role add");
		}
		finally{
			if(conn!=null){
				conn.close();
			}
		}
	}
}
