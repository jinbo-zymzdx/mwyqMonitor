package com.mwyq.dao;

import com.mwyq.model.Twitter;
import com.mwyq.model.TwitterExample;
import com.mwyq.model.TwitterGroup;
import com.mwyq.model.TwitterAuthor;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TwitterMapper {
    int countByExample(TwitterExample example);

    int deleteByExample(TwitterExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Twitter record);

    int insertSelective(Twitter record);

    List<Twitter> selectByExample(TwitterExample example);

    Twitter selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Twitter record, @Param("example") TwitterExample example);

    int updateByExample(@Param("record") Twitter record, @Param("example") TwitterExample example);

    int updateByPrimaryKeySelective(Twitter record);

    int updateByPrimaryKey(Twitter record);
    
    List<Twitter> getTwitterNews();
    
    List<TwitterGroup> getTwitterGroup();
    
    List<TwitterAuthor> getTwitterAuthor();
}