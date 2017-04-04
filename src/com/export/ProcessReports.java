package com.export;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.cert.Certificate;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import com.mapping.AffichageExport;
import com.mapping.Client;
import com.mapping.DecompteExtraction;
import com.mapping.RowExtraction;
import com.service.DecompteService;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ProcessReports {
	List<RowExtraction> bills;
	public void generateReport(File filePath , File savePath, int idMoisProjet ) throws Exception {
		
		System.out.println("test" + idMoisProjet);
		JasperReport jasperReport;
	    JasperPrint jasperPrint;
	    Map<String, Object> parameter = new HashMap<String, Object>();
	    DecompteExtraction retourExport = DecompteService.getInstance().getDataToextract((idMoisProjet));
	    AffichageExport affichageExport = new AffichageExport();
	    affichageExport.setData(retourExport);
	    bills = retourExport.getBills();
	    Client u1 =new Client();
	    u1.setNom("nom1");
	    Client u2 =new Client();
	    u2.setNom("nom2");
	    
	    List<Client> listUser = new ArrayList<Client>();
	    listUser.add(u1);
	    listUser.add(u2);
	    System.out.println(retourExport.getBills().size() +"contractor");
	    
	    JRBeanCollectionDataSource itemsJRBean = new JRBeanCollectionDataSource(retourExport.getBills());
	    parameter.put("ItemDataSource",itemsJRBean);
	    parameter.put("contractor",affichageExport.getContractor());
	    parameter.put("societe",affichageExport.getSociete());

	    try {
	        jasperReport = JasperCompileManager
	                .compileReport(filePath.getPath());

	        jasperPrint = JasperFillManager.fillReport(jasperReport, parameter,new JRBeanCollectionDataSource(affichageExport.getBills()));
	        JasperExportManager.exportReportToPdfFile(jasperPrint,
	        		savePath.getPath());

	    } catch (JRException e) {
	        e.printStackTrace();
	    }
		/*try
		{
			System.out.println("A");
			String pdfPath = savePath.toString();
			savePath.delete();
			//InputStream is = new InputStream(fileJrxml);
			JasperDesign design = JRXmlLoader.load("/Fanilo/Professionel/Maurice/Freelance/BOQ/Developpement/BOQ/Mars/Ultra/src/com/export/Certification.jrxml");
			System.out.println("B");
			JasperReport report = JasperCompileManager.compileReport(design);
			System.out.println("C");
			List<Client> listUser = new ArrayList <Client>();
			JasperPrint print = JasperFillManager.fillReport(report, null,
					new JRBeanCollectionDataSource(listUser));
			System.out.println("D");
			
			OutputStream output;
			try {
				output = new FileOutputStream(new File("/Fanilo/Professionel/Maurice/Freelance/BOQ/Developpement/BOQ/Mars/Ultra/WebContent/GeneratedFile/test2.pdf"));
				JasperExportManager.exportReportToPdfStream(print, output); 
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
			//JasperExportManager.exportReportToPdfFile(print, pdfPath);
			
		}
		catch(JRException ex)
		{
			ex.printStackTrace();
		}*/
	}
	public List<RowExtraction> getBills(){
		return this.bills;
	}
}