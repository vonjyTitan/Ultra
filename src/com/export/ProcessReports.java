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
	   
	    
	
	    System.out.println(retourExport.getBills().size() +"contractor");
	    
	    JRBeanCollectionDataSource itemsJRBean = new JRBeanCollectionDataSource(retourExport.getBills());
	    
	    System.out.println(retourExport.getBills().get(0).getLibelle() + "ksdkjfkjdskjf");
	    
	    parameter.put("ItemDataSource",itemsJRBean);
	    
	    parameter.put("idcertificat",retourExport.getIdcertificat());
	    parameter.put("certificatdate",retourExport.getContractor());
	    parameter.put("contractor",retourExport.getContractor());
	    parameter.put("societe",retourExport.getSociete());
	    
	    parameter.put("libelleSubtitle1",retourExport.getSubtotal1().getLibelle());
	    parameter.put("estimateSubtitle1",retourExport.getSubtotal1().getEstimative());
	    parameter.put("currentSubttile1",retourExport.getSubtotal1().getCurrent());
	    parameter.put("cummulativeSubtitle",retourExport.getSubtotal1().getCummulative());
	    parameter.put("precedantSubtitle",retourExport.getSubtotal1().getPrecedant());
	    
	    parameter.put("libelleSubtitle2",retourExport.getSubtotal2().getLibelle());
	    parameter.put("estimateSubtitle2",retourExport.getSubtotal2().getEstimative());
	    parameter.put("currentSubttile2",retourExport.getSubtotal2().getCurrent());
	    parameter.put("cummulativeSubtitle2",retourExport.getSubtotal2().getCummulative());
	    parameter.put("precedantSubtitle2",retourExport.getSubtotal2().getPrecedant());
	    
	    parameter.put("libelleSubtitle1",retourExport.getSubtotal1().getLibelle());
	    parameter.put("estimateSubtitle1",retourExport.getSubtotal1().getEstimative());
	    parameter.put("currentSubttile1",retourExport.getSubtotal1().getCurrent());
	    parameter.put("cummulativeSubtitle",retourExport.getSubtotal1().getCummulative());
	    parameter.put("precedantSubtitle",retourExport.getSubtotal1().getPrecedant());
	    
	    parameter.put("libelleAvance",retourExport.getAvance().getLibelle());
	    parameter.put("estimateAvance",retourExport.getAvance().getEstimative());
	    parameter.put("currentAvance",retourExport.getAvance().getCurrent());
	    parameter.put("cummulativeAvance",retourExport.getAvance().getCummulative());
	    parameter.put("precedantAvance",retourExport.getAvance().getPrecedant());
	    
	    parameter.put("libelleLessrepayment",retourExport.getLessrepayment().getLibelle());
	    parameter.put("estimateLessrepayment",retourExport.getLessrepayment().getEstimative());
	    parameter.put("currentLessrepayment",retourExport.getLessrepayment().getCurrent());
	    parameter.put("cummulativeLessrepayment",retourExport.getLessrepayment().getCummulative());
	    parameter.put("precedantLessrepayment",retourExport.getLessrepayment().getPrecedant());

	    parameter.put("libelleMatonsite",retourExport.getMatonsite().getLibelle());
	    parameter.put("estimateMatonsite",retourExport.getMatonsite().getEstimative());
	    parameter.put("currentMatonsite",retourExport.getMatonsite().getCurrent());
	    parameter.put("cummulativeMatonsite",retourExport.getMatonsite().getCummulative());
	    parameter.put("precedantMatonsite",retourExport.getMatonsite().getPrecedant());
	    	    
	    parameter.put("libelleTotal",retourExport.getTotal().getLibelle());
	    parameter.put("estimateTotal",retourExport.getTotal().getEstimative());
	    parameter.put("currentTotal",retourExport.getTotal().getCurrent());
	    parameter.put("cummulativeTotal",retourExport.getTotal().getCummulative());
	    parameter.put("precedantTotal",retourExport.getTotal().getPrecedant());
	    
	    parameter.put("totalAmoutExctVta",retourExport.getTotalAmoutExctVta());
	    parameter.put("totalAmoutIncVta",retourExport.getTotalAmoutIncVta());
	    parameter.put("addVta",retourExport.getAddVta());
	    parameter.put("contractValue",retourExport.getContractValue());
	    
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
