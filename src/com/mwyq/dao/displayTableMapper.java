package com.mwyq.dao;

import com.mwyq.model.displayTable;
import com.mwyq.model.displayTableExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface displayTableMapper {
    int countByExample(displayTableExample example);

    int deleteByExample(displayTableExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(displayTable record);

    int insertSelective(displayTable record);

    List<displayTable> selectByExample(displayTableExample example);

    displayTable selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") displayTable record, @Param("example") displayTableExample example);

    int updateByExample(@Param("record") displayTable record, @Param("example") displayTableExample example);

    int updateByPrimaryKeySelective(displayTable record);

    int updateByPrimaryKey(displayTable record);
}