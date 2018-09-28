package com.me.tsk.pojo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
@Table(name="patient_reports")
public class UserReports {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="report_id")
	private int reportId;

	@ManyToOne
	private patient patient;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(cascade=CascadeType.ALL)
	@JoinColumn(name="reportId")
	private List<PatientAppointment> patientAppointments;
	
	@Column(name="Hospital_name")
	private String hospital_name;
	
	@Column(name="bp_systolic")
	private int systolicPressure;
	
	@Column(name="bp_diastolic")
	private int diastolicPressure;
	
	@Column(name="heart_rate")
	private float heart_rate;
	
	@Column(name="TST_result") // Tuberculin Skin test
	private boolean tst_result;
	
	@Column(name="TST_Induration_mm")
	private float tst_induration;

	@Column(name="HIV_Result")
	private boolean hiv_status;
	
	@Column(name="tb_Status")
	private boolean dis_stat;
	
	@Column(name="tb_type")
	private String tb_type;
	
	@Column(name="tb_activity")
	private String tb_activity;
	
	@Column(name="Date")
	private Date date;
	
	@Column(name="Allergy_Info")
	private String allergy;
	
	@Column(name="Remarks")
	private String remarks;
	
	@Column(name="file_path")
	private String filePath;
	
	
	public UserReports() {
		patientAppointments = new ArrayList<PatientAppointment>();
	}
	
	public List<PatientAppointment> getPatientAppointments() {
		return patientAppointments;
	}

	


	public void setPatientAppointments(List<PatientAppointment> patientAppointments) {
		this.patientAppointments = patientAppointments;
	}



	public String getTb_type() {
		return tb_type;
	}

	public void setTb_type(String tb_type) {
		this.tb_type = tb_type;
	}

	public String getTb_activity() {
		return tb_activity;
	}

	public void setTb_activity(String tb_activity) {
		this.tb_activity = tb_activity;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getHospital_name() {
		return hospital_name;
	}

	public void setHospital_name(String hospital_name) {
		this.hospital_name = hospital_name;
	}

	public String getAllergy() {
		return allergy;
	}

	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getReportId() {
		return reportId;
	}

	public void setReportId(int reportId) {
		this.reportId = reportId;
	}

	public patient getPatient() {
		return patient;
	}

	public void setPatient(patient patient) {
		this.patient = patient;
	}

	public int getSystolicPressure() {
		return systolicPressure;
	}

	public void setSystolicPressure(int systolicPressure) {
		this.systolicPressure = systolicPressure;
	}

	public int getDiastolicPressure() {
		return diastolicPressure;
	}

	public void setDiastolicPressure(int diastolicPressure) {
		this.diastolicPressure = diastolicPressure;
	}

	public float getHeart_rate() {
		return heart_rate;
	}

	public void setHeart_rate(float heart_rate) {
		this.heart_rate = heart_rate;
	}

	public boolean getTst_result() {
		return tst_result;
	}

	public void setTst_result(boolean tst_result) {
		this.tst_result = tst_result;
	}

	public float getTst_induration() {
		return tst_induration;
	}

	public void setTst_induration(float tst_induration) {
		this.tst_induration = tst_induration;
	}

	public boolean isHiv_status() {
		return hiv_status;
	}

	public void setHiv_status(boolean hiv_status) {
		this.hiv_status = hiv_status;
	}

	public boolean isDis_stat() {
		return dis_stat;
	}

	public void setDis_stat(boolean dis_stat) {
		this.dis_stat = dis_stat;
	}
	
	
}
