package com.me.tsk.pojo;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "clinic_table")
public class clinic {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "clinic_Id", nullable = false, unique = true)
	private long clinic_id;
	
	@Column(name="clinic_register_no", nullable=false,unique=true)
	private String registerationID;
	
	@Column(name = "username", unique = true, nullable = false)
	private String username;

	@Column(name = "password")
	private String password;

	@Column(name = "clinic_name")
	private String clinic_name;

	@Column(name = "Address")
	private String address;

	@Column(name = "state")
	private String state;

	@Column(name = "country")
	private String country;

	@Column(name = "pincode")
	private String pincode;

	@Column(name = "Tele_no")
	private String telephone_number;

	@Column(name = "TB_cases_reported")
	private int tbCaseReportCount;

	@Column(name = "Tb_case_cured")
	private int tbCaseCured;

/********************* Mapping ******************************/	
	
	@OneToOne(mappedBy = "clinic", cascade = CascadeType.ALL)
	private doctor main_doc;

	@ManyToMany(mappedBy = "clinic")
	private List<doctor> visitingDoctors = new ArrayList<doctor>();
	
/********************* Getters and Setters ******************************/	
	
	
	
	public String getUsername() {
		return username;
	}

	public String getRegisterationID() {
	return registerationID;
}

public void setRegisterationID(String registerationID) {
	this.registerationID = registerationID;
}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public List<doctor> getVisitingDoctors() {
		return visitingDoctors;
	}

	public void setVisitingDoctors(List<doctor> visitingDoctors) {
		this.visitingDoctors = visitingDoctors;
	}

	public long getClinic_id() {
		return clinic_id;
	}

	public void setClinic_id(long clinic_id) {
		this.clinic_id = clinic_id;
	}

	public String getClinic_name() {
		return clinic_name;
	}

	public void setClinic_name(String clinic_name) {
		this.clinic_name = clinic_name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getTelephone_number() {
		return telephone_number;
	}

	public void setTelephone_number(String telephone_number) {
		this.telephone_number = telephone_number;
	}

	public doctor getMain_doc() {
		return main_doc;
	}

	public void setMain_doc(doctor main_doc) {
		this.main_doc = main_doc;
	}

	public int getTbCaseReportCount() {
		return tbCaseReportCount;
	}

	public void setTbCaseReportCount(int tbCaseReportCount) {
		this.tbCaseReportCount = tbCaseReportCount;
	}

	public int getTbCaseCured() {
		return tbCaseCured;
	}

	public void setTbCaseCured(int tbCaseCured) {
		this.tbCaseCured = tbCaseCured;
	}

}
