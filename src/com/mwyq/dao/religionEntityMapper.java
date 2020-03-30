package com.mwyq.dao;

import com.mwyq.model.religionEntity;
import com.mwyq.model.religionEntityExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface religionEntityMapper {
    int countByExample(religionEntityExample example);

    int deleteByExample(religionEntityExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(religionEntity record);

    int insertSelective(religionEntity record);

    List<religionEntity> selectByExample(religionEntityExample example);

    religionEntity selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") religionEntity record, @Param("example") religionEntityExample example);

    int updateByExample(@Param("record") religionEntity record, @Param("example") religionEntityExample example);

    int updateByPrimaryKeySelective(religionEntity record);

    int updateByPrimaryKey(religionEntity record);
}