package com.me.tsk.pojo;

import java.sql.Time;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GeneratorType;

@Entity
@Table(name="patient_appointments")
public class PatientAppointment {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="Appointment_id", unique=true,nullable=false)
	private long id;
	
	@Column(name="Appointment_date")
	private Date date;
	
	@Column(name="Appointment_time")
	private String time;
	
	@Column(name="Appointment_status")
	private String status;
	
	
	@ManyToOne
	private UserReports patientReports;
	
	@ManyToOne
	private doctor doctor;
	
	
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public UserReports getPatientReports() {
		return patientReports;
	}

	public void setPatientReports(UserReports patientReports) {
		this.patientReports = patientReports;
	}

	public doctor getDoctor() {
		return doctor;
	}

	public void setDoctor(doctor doctor) {
		this.doctor = doctor;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

}
