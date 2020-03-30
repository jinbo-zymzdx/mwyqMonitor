package com.mwyq.model;

public class TopicAndEntity {
	
	private String topic_id;
	private Integer entity_id;
    private String entity_type;
    private String entity_key;
    private Double distribution;
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
	public String getEntity_type() {
		return entity_type;
	}
	public void setEntity_type(String entity_type) {
		this.entity_type = entity_type;
	}
	public String getEntity_key() {
		return entity_key;
	}
	public void setEntity_key(String entity_key) {
		this.entity_key = entity_key;
	}
	public Double getDistribution() {
		return distribution;
	}
	public void setDistribution(Double distribution) {
		this.distribution = distribution;
	}
	@Override
	public String toString() {
		return "TopicAndEntity [topic_id=" + topic_id + ", entity_id=" + entity_id + ", entity_type=" + entity_type
				+ ", entity_key=" + entity_key + ", distribution=" + distribution + "]";
	}
}
