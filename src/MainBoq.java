import utilitaire.UtilCrypto;

public class MainBoq {

	public static void main(String[] args) 
	{
		try{
			System.out.println(UtilCrypto.encrypt("fanilo"));
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
	}

}
