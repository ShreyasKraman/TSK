package com.me.tsk.pojo;

import java.util.ArrayList;
import java.util.Date;
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
@Table(name="Patient_Table")
public class patient {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="Patient_ID")
	private long patientId;
	
	@Column(name="First_Name")
	private String firstName;

	@Column(name="Last_Name")
	private String lastName;
	
	@Column(name="Age")
	private int age;
	
	@Column(name="gender")
	private String gender;
	
	@Column(name="Mobile_Number")
	private long mobileNumber;
	
	@Column(name="Address")
	private String address;
	
	@Column(name="ProfilePic")
	private String imagePath;
	
	@Column(name="Pincode")
	private int pincode;
	
	@Column(name="Email_ID")
	private String email;
	
	@Column(name="Password")
	private String password;
	
	@Column(name="Email_Verification")
	private boolean verify;
	
	@Column(name="Course_length")
	private int course_length;
	
	@Column(name="Course_start")
	private Date course_start_date;
	
	@ManyToOne
	private doctor doc;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(cascade=CascadeType.ALL)
	@JoinColumn(name="patientId")
	private List<UserReports> reports;
	
	
	public patient() {
		reports = new ArrayList<UserReports>();
	}
	
	
	public int getCourse_length() {
		return course_length;
	}

	public void setCourse_length(int course_length) {
		this.course_length = course_length;
	}



	public Date getCourse_start_date() {
		return course_start_date;
	}



	public void setCourse_start_date(Date course_start_date) {
		this.course_start_date = course_start_date;
	}


	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public doctor getDoc() {
		return doc;
	}

	public void setDoc(doctor doc) {
		this.doc = doc;
	}

	public List<UserReports> getReports() {
		return reports;
	}

	public void setReports(List<UserReports> reports) {
		this.reports = reports;
	}

	public long getPatientId() {
		return patientId;
	}

	public void setPatientId(long patientId) {
		this.patientId = patientId;
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

	public long getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(long mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getPincode() {
		return pincode;
	}

	public void setPincode(int pincode) {
		this.pincode = pincode;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isVerify() {
		return verify;
	}

	public void setVerify(boolean verify) {
		this.verify = verify;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
	
	
	
}
