package com.me.tsk.pojo;

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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.GeneratorType;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name="Doctor_Table")
public class doctor {
	
	@Id
//	@GeneratedValue(generator = "generator")
//	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "clinic"))
	
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="doc_id", unique=true, nullable=false)
	private long id;
	
	@Column(name="reg_id")
	private String registered_id;
	
	@Column(name="First_Name")
	private String firstName;
	
	@Column(name="Last_Name")
	private String lastName;
	
	@Column(name="Address")
	private String address;
	
	@Column(name="phoneNo")
	private String mobileNo;
	
	@Column(name="Qualification")
	private String qualification;
	
//	@OneToOne
//	@PrimaryKeyJoinColumn
//	private clinic clinic;
	
//	@ManyToMany
//	@JoinTable (
//		       name="clinic_visiting_doc_table",
//		       joinColumns = {@JoinColumn(name="doc_id", nullable = false, updatable = false)},
//		       inverseJoinColumns = {@JoinColumn(name="clinic_Id" )}
//		    )
//	private List<clinic> clinics = new ArrayList<clinic>();
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(cascade=CascadeType.ALL)
	@JoinColumn(name="doctor_id")
	List <patient> patients; 
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(cascade=CascadeType.ALL)
	@JoinColumn(name="doctor_id")
	List <PatientAppointment> doctorAppointments;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(cascade=CascadeType.ALL)
	@JoinColumn(name="doctor_id")
	List <sendEmail> email;
	
	public doctor() {
		patients = new ArrayList<patient>();
		doctorAppointments = new ArrayList<PatientAppointment>();
		email = new ArrayList<sendEmail>();
	}
	
	
	public List<sendEmail> getEmail() {
		return email;
	}

	public void setEmail(List<sendEmail> email) {
		this.email = email;
	}



	public List<PatientAppointment> getDoctorAppointments() {
		return doctorAppointments;
	}



	public void setDoctorAppointments(List<PatientAppointment> doctorAppointments) {
		this.doctorAppointments = doctorAppointments;
	}



	public List<patient> getPatients() {
		return patients;
	}

	public void setPatients(List<patient> patients) {
		this.patients = patients;
	}

	public String getRegistered_id() {
		return registered_id;
	}

	public void setRegistered_id(String registered_id) {
		this.registered_id = registered_id;
	}

//	public List<clinic> getClinics() {
//		return clinics;
//	}
//
//	public void setClinics(List<clinic> clinics) {
//		this.clinics = clinics;
//	}

//	public void setClinic(clinic clinic) {
//		this.clinic = clinic;
//	}

//	public List<clinic> getClinic() {
//		return clinics;
//	}
//
//	public void setClinic(List<clinic> clinics) {
//		this.clinics = clinics;
//	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}
	
	
}
