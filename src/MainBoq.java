import com.mapping.DecompteExtraction;
import com.service.DecompteService;

import dao.DaoModele;
import utilitaire.UtilCrypto;

public class MainBoq {

	public static void main(String[] args) 
	{
		try{
			DaoModele.getInstance().executeUpdate("delete ...");
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
	}

}
