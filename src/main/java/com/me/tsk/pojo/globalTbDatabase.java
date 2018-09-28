package com.me.tsk.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="global_tb_db")
public class globalTbDatabase {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="data_id",nullable=false, unique=true)
	private long id;
	
	@Column(name="City")
	private String city;
	
}
