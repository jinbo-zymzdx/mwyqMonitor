package com.mwyq.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mwyq.model.CustomMonitor;
import com.mwyq.model.Topic;

public interface CustomMonitorMapper {
    int deleteByPrimaryKey(Integer id);
    
    int deleteByKeyWord(String keyWord);

    int insert(CustomMonitor record);

    int insertSelective(CustomMonitor record);

    CustomMonitor selectByPrimaryKey(Integer id);
    
    List<CustomMonitor> getAllCustomMonitor();

    int updateByPrimaryKeySelective(CustomMonitor record);

    int updateByPrimaryKey(CustomMonitor record);
    
    CustomMonitor getCustomByWord(@Param("keyWord") String keyWord);
   
}