package com.mwyq.dao;

import com.mwyq.model.weiBo;
import com.mwyq.model.weiBoExample;
import com.mwyq.model.weiboEmotion;
import com.mwyq.model.weiboGroup;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface weiBoMapper {
    int countByExample(weiBoExample example);

    int deleteByExample(weiBoExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(weiBo record);

    int insertSelective(weiBo record);

    List<weiBo> selectByExample(weiBoExample example);

    weiBo selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") weiBo record, @Param("example") weiBoExample example);

    int updateByExample(@Param("record") weiBo record, @Param("example") weiBoExample example);

    int updateByPrimaryKeySelective(weiBo record);

    int updateByPrimaryKey(weiBo record);
    
    List<weiBo> getWeiBoNews(@Param("lang") String lang);
    
    List<weiBo> getWeiBoByEmotion(@Param("lang") String lang,@Param("emotion") String emotion);
    
    List<weiboGroup> getAuthorGroup(@Param("lang") String lang);
    
    List<weiboEmotion> getWeiboEmotion(@Param("lang") String lang);
    
    List<weiBo> getAuthorWeibo(@Param("name") String name);
}