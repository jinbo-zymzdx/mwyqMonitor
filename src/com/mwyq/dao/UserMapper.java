package com.mwyq.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mwyq.model.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    int getUser(@Param("username") String username, @Param("passwd") String passwd);
    
    List<User> getSelectedUser(@Param("username") String username, @Param("passwd") String passwd);
}