package com.me.tsk.pojo;

import java.util.Date;

public class AppointmentData {
	
	private long id;
	private String date;
	private String day;
	private String time;
	private String doc_name;
	private String clinic_name;
	private String clinic_address;
	private String appointment_status;
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getDoc_name() {
		return doc_name;
	}
	public void setDoc_name(String doc_name) {
		this.doc_name = doc_name;
	}
	public String getClinic_name() {
		return clinic_name;
	}
	public void setClinic_name(String clinc_name) {
		this.clinic_name = clinc_name;
	}
	public String getClinic_address() {
		return clinic_address;
	}
	public void setClinic_address(String clinic_address) {
		this.clinic_address = clinic_address;
	}
	public String getAppointment_status() {
		return appointment_status;
	}
	public void setAppointment_status(String appointment_status) {
		this.appointment_status = appointment_status;
	}
	
	
	
	
}
