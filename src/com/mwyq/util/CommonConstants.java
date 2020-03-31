/************************************************
 @description:CommonConstants.java是用来....
 @author:shishansong
 @date:2016年4月25日 下午7:34:10
 @version:1.0
 *************************************************/
package com.mwyq.util;

import java.util.HashMap;
import java.util.Map;

public class CommonConstants {
   
    public final static Map<String, String> MAP_LANGUAGE = new HashMap<String, String>() {{
        put("cn", "中文");
        put("meng", "蒙文");
        put("zang", "藏文");
        put("wei", "维文");
    }};
}
