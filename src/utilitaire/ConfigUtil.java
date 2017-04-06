package utilitaire;

import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

public class ConfigUtil {

	private static ResourceBundle bundle=null;
	private static Map<String,ResourceBundle> allbundle=new HashMap<String,ResourceBundle>();
	
	public static ResourceBundle getConfigBundle(){
		if(bundle==null)
			bundle=ResourceBundle.getBundle("domaine.properties.project");
		return bundle;
	}
	public static String getConfigValue(String key){
		ResourceBundle configuration = getConfigBundle();
		
		String prefix = "";
		String environement = configuration.getString("config.environement");
		if(!environement.contains("local")){
			prefix = environement.replace(";", "")+".";
		}
		return configuration.getString(prefix+key);
	}
	public static ResourceBundle getBundleByName(String name){
		if(allbundle.containsKey(name)){
			return allbundle.get(name);
		}
		ResourceBundle bundle=ResourceBundle.getBundle(name);
		allbundle.put(name, bundle);
		return bundle;
	}
}
