package com.mwyq.dao;

import com.mwyq.model.EntityTopicRelation;
import com.mwyq.model.EntityTopicRelationExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EntityTopicRelationMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    int countByExample(EntityTopicRelationExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    int deleteByExample(EntityTopicRelationExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    int insert(EntityTopicRelation record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    int insertSelective(EntityTopicRelation record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    List<EntityTopicRelation> selectByExample(EntityTopicRelationExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    EntityTopicRelation selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") EntityTopicRelation record, @Param("example") EntityTopicRelationExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") EntityTopicRelation record, @Param("example") EntityTopicRelationExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(EntityTopicRelation record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table entity_topic_relation
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(EntityTopicRelation record);
}