package utilitaire;

import java.lang.reflect.Field;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class UtileAffichage {
	public static Object getNonNullValue(Object value,Class f){
		if(value=="")
			return "";
		if(f.equals(String.class)){
			if(value==null)
				return "";
			return value;
		}
		if(f.equals(java.util.Date.class) || f.equals(java.sql.Date.class)){
			if(value==null){
				return "";
			}
			return formatAfficherDate((java.util.Date) value);
		}
		 if((f.equals(Double.class) || f.equals(double.class) || f.equals(Float.class) || f.equals(float.class))){
				return UtileAffichage.formatMoney(value);
			}
		return value;
	}
	public static Object numberVal(Double ob,Class type)
	{
		if(type.getSimpleName().compareToIgnoreCase("double")==0 || type.getSimpleName().compareToIgnoreCase("float")==0){
			return ob;
		}
		return ob.intValue();
	}
	public static Object parseFromRequest(Object value,Class type) throws ParseException{
		if(type.equals(java.util.Date.class) || type.equals(java.sql.Date.class))
		{
			DateFormat form=new SimpleDateFormat("dd/MM/yyyy"); 
			Date response = (Date) form.parseObject((String) value);
			if(type.equals(java.sql.Date.class)){
				return new java.sql.Date(response.getTime());
			}
			return response;
		}
		else if (type.equals(int.class)){
			return Integer.valueOf("0"+((String)value));
		}
		else if(type.equals(double.class) || type.equals(Double.class)){
			return Double.valueOf(("0"+((String)value)).replaceAll(",", ""));
		}
		else if(type.equals(float.class) || type.equals(Float.class)){
			return Float.valueOf(("0"+((String)value)).replaceAll(",", ""));
		}
		else return value;
	}
	public static String formatMoney(Object nombre){
		if(nombre==null || (Double)nombre==0)
			return "000,000.000";
		DecimalFormat myNumberFormat = new DecimalFormat("###,###.###");
		return myNumberFormat.format(nombre);
	}
	public static String formatDate(java.sql.Date date){
		if(date==null)
			return "";
		Date date_var = new java.sql.Date(date.getTime());
		DateFormat myDateFormat=new SimpleDateFormat("dd-MM-yyyy");
		return myDateFormat.format(date_var);
		
	}
	public static String formatDate(java.util.Date date){
		if(date==null)
			return "";
		DateFormat myDateFormat=new SimpleDateFormat("dd-MM-yyyy");
		return myDateFormat.format(date);
		
	}
	public static String formatAfficherDate(java.sql.Date date){
		if(date==null)
			return "";
		Date date_var = new java.sql.Date(date.getTime());
		DateFormat myDateFormat=new SimpleDateFormat("dd/MM/yyyy");
		return myDateFormat.format(date_var);
	}
	public static String formatAfficherDate(java.util.Date date){
		if(date==null)
			return "";
		DateFormat myDateFormat=new SimpleDateFormat("dd/MM/yyyy");
		return myDateFormat.format(date);
	}
	public static String getMonthLibeleByDate(java.sql.Date date){
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int month = cal.get(Calendar.MONTH);
		
		String[] moisName ={"January","February","March","April","May","June","July","August","September","October","November","December"};
		
		return moisName[month];
	}
	public static int getYearByDate(java.sql.Date date){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.YEAR);
	}
	public static Date getDateNow(){
		return new java.util.Date();
	}
}
