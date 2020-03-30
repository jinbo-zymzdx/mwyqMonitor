package com.mwyq.model;

import java.sql.Date;

public class StatisticEntity {
    private Integer id;
    private String type;
    private String topic_id;
    private Integer entity_id;
    private String name;
    private int count;
    private Date creat_time;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTopic_id() {
		return topic_id;
	}
	public void setTopic_id(String topic_id) {
		this.topic_id = topic_id;
	}
	public Integer getEntity_id() {
		return entity_id;
	}
	public void setEntity_id(Integer entity_id) {
		this.entity_id = entity_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Date getCreat_time() {
		return creat_time;
	}
	public void setCreat_time(Date creat_time) {
		this.creat_time = creat_time;
	}
	@Override
	public String toString() {
		return "StatisticEntity [id=" + id + ", type=" + type + ", topic_id=" + topic_id + ", entity_id=" + entity_id
				+ ", name=" + name + ", count=" + count + ", creat_time=" + creat_time + "]";
	} 
}
