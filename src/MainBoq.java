import com.mapping.DecompteExtraction;
import com.service.DecompteService;

import utilitaire.UtilCrypto;

public class MainBoq {

	public static void main(String[] args) 
	{
		try{
			DecompteExtraction data = DecompteService.getInstance().getDataToextract(10);
			System.out.println(" taille : " +data.getBills().size());
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
	}

}
