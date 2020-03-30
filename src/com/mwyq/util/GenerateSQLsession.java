package com.mwyq.util;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Logger;

/**
 * @Title:  
 * @Description: 
 * @param:  
 * @throws:
 * @author: liwei
 * @date: 2018/7/22
 */
public class GenerateSQLsession {
	 private static SqlSessionFactory sqlSessionFactory;
	    private static Reader reader; 
	    static{
	        try{
	        	BasicConfigurator.configure();
	            reader    = Resources.getResourceAsReader("mybatis-config.xml");
	            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
	        }catch(Exception e){
	            e.printStackTrace();
	        }
	    }
	    
	    public static SqlSession getSession(){
	    	return sqlSessionFactory.openSession();
	    }
}
