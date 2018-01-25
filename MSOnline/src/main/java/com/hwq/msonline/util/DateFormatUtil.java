package com.hwq.msonline.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormatUtil {
    public static Date formatDate(String dateStr,String format) throws ParseException{
    	SimpleDateFormat sdf = new SimpleDateFormat(format);
    	Date date = sdf.parse(dateStr);
    	return date;
    }
}
