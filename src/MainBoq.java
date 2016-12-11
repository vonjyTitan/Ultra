import utilitaire.UtilCrypto;

public class MainBoq {

	public static void main(String[] args) 
	{
		try{
			System.out.println(UtilCrypto.decrypt("LIKDYP7P+adsCPSdk7Tw8g=="));
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
	}

}
