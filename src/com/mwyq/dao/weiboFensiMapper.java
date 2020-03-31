package com.mwyq.dao;

import com.mwyq.model.fensi;
import com.mwyq.model.weiboFensi;
import com.mwyq.model.weiboFensiExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface weiboFensiMapper {
    int countByExample(weiboFensiExample example);

    int deleteByExample(weiboFensiExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(weiboFensi record);

    int insertSelective(weiboFensi record);

    List<weiboFensi> selectByExample(weiboFensiExample example);

    weiboFensi selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") weiboFensi record, @Param("example") weiboFensiExample example);

    int updateByExample(@Param("record") weiboFensi record, @Param("example") weiboFensiExample example);

    int updateByPrimaryKeySelective(weiboFensi record);

    int updateByPrimaryKey(weiboFensi record);
    
    List<fensi> getWeiFensi(@Param("lang") String lang);
}