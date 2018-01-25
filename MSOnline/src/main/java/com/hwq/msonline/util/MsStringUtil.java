package com.hwq.msonline.util;
/**
 * 字符串操作工具类
 * @author Administrator
 *
 */
public class MsStringUtil {
      public static boolean isEmpty(String str){
    	  if(null == str || str.length()<=0){ //为空
    		  return  true;
    	  }else{
    		  return false;
    	  }
      }
}
