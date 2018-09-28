package com.me.tsk.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.parser.PdfTextExtractor;
import com.me.tsk.dao.DoctorDAO;
import com.me.tsk.dao.PatientDAO;
import com.me.tsk.dao.appointmentDAO;
import com.me.tsk.pojo.AppointmentData;
import com.me.tsk.pojo.PatientAppointment;
import com.me.tsk.pojo.UserReports;
import com.me.tsk.pojo.doctor;
import com.me.tsk.pojo.patient;

@Controller
@RequestMapping(value = "/user/**")
public class patientController {

	@Autowired
	@Qualifier("patientDAO")
	PatientDAO patientdao;

	@Autowired
	@Qualifier("doctorDAO")
	DoctorDAO doctordao;

	@Autowired
	@Qualifier("appointmentDAO")
	appointmentDAO appoint;

	@RequestMapping(value = "/user/dashboard.htm", method = RequestMethod.GET)
	public ModelAndView patient_dashboard(HttpServletRequest request) {
		patient pat = null;
		HttpSession session = request.getSession();
		if (session.getAttribute("username") != null) {
			String username = (String) session.getAttribute("email");
			try {
				pat = patientdao.getPatientInfo(username);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		HashMap<String, Object> patientData = new HashMap<String, Object>();

		if (null != pat.getReports()) {

			List<UserReports> patientReports = pat.getReports();

			// Sort Ascending
			Collections.sort(patientReports, new Comparator<UserReports>() {

				@Override
				public int compare(UserReports o1, UserReports o2) {
					// TODO Auto-generated method stub
					return o1.getDate().compareTo(o2.getDate());
				}
			});

			// Sort Descending
			Collections.sort(patientReports, Collections.reverseOrder());

			patientData.put("reports", patientReports);
			patientData.put("patient", pat);

			Iterator iterate = patientReports.iterator();

			if (iterate != null) {
				UserReports report = (UserReports) iterate.next();

				patientData.put("recentReport", report);

			}

			return new ModelAndView("patient-dashboard", "patientdata", patientData);
		}
		patientData.put("recentReport", null);
		patientData.put("patient", pat);
		patientData.put("recentReport", null);
		return new ModelAndView("patient-dashboard", "patientdata", patientData);

	}

	// @RequestMapping(value="/user/getImage/{imageId}")
	// @ResponseBody
	// public byte[] getImage(@PathVariable long imageId,HttpServletRequest request)
	// {
	// String rpath = request.getRealPath("/");
	//
	//
	// patient pat = patientdao.getPatientImage(imageId);
	//
	// try {
	// String rpath = pat.getImagePath();
	//
	// Path path = Paths.get(rpath);
	//
	// byte[] data = Files.readAllBytes(path);
	//
	// return data;
	// }catch(Exception e) {
	//
	// e.printStackTrace();
	//
	// return null;
	// }
	// }

	@RequestMapping(value = "/user/uploadReports.htm", method = RequestMethod.POST)
	public ModelAndView returnTemplate(HttpServletRequest request, @RequestParam("medicalReport") MultipartFile file,
			@RequestParam("courseDate") String courseDate) {

		PdfReader pdfReader;

		HashMap<String, Object> reportsList = new HashMap<String, Object>();

		patient pat = null;
		HttpSession session = request.getSession();
		if (session.getAttribute("username") != null) {
			String username = (String) session.getAttribute("email");
			try {
				pat = patientdao.getPatientInfo(username);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (file != null) {

			try {
				String filePath = "C:\\Users\\shrey\\TSK\\" + pat.getFirstName() + "_" + pat.getLastName()
						+ "\\medical_reports";

				File newFile = new File(filePath, file.getOriginalFilename());

				if (!newFile.exists()) {
					newFile.getParentFile().mkdirs();
				}
				file.transferTo(newFile);

				pdfReader = new PdfReader(filePath + "\\" + file.getOriginalFilename());

				String textFromPage = PdfTextExtractor.getTextFromPage(pdfReader, 1);

				String[] lines = textFromPage.split("\n");

				int length = lines.length;

				HashMap<String, Object> testResults = new HashMap<String, Object>();

				UserReports reports = new UserReports();
				reports.setHospital_name(lines[0]);

				doctor doc = new doctor();
				String regId = null;
				boolean diseaseIndicator = false;
				for (int i = 1; i < length; i++) {

					if (!lines[i].trim().isEmpty()) {
						if (lines[i].contains(":")) {
							String split[] = lines[i].split(":");
							if (lines[i].contains("Address")) {
								doc.setAddress(split[1].trim());
							}
							if (lines[i].contains("Blood Pressure")) {
								String pressure = split[1].trim();
								String range[] = pressure.split("/");
								reports.setSystolicPressure(Integer.parseInt(range[0]));
								String diastolic[] = range[1].trim().split(" ");
								reports.setDiastolicPressure(Integer.parseInt(diastolic[0]));
							} else if (lines[i].contains("Heart Rate")) {

								reports.setHeart_rate(Integer.parseInt(split[1].trim().substring(0, 2)));
							} else if (lines[i].contains("Disease")) {
								if (split[1].contains("Tuberculosis")) {
									reports.setDis_stat(true);
									diseaseIndicator = true;
								}

								if (diseaseIndicator) {
									if (lines[i].contains("type")) {
										reports.setTb_type(split[1].trim());
									} else if (lines[i].contains("activity")) {
										reports.setTb_activity(split[1].trim());
									}
								}
							} else if (lines[i].contains("Remarks")) {
								reports.setRemarks(split[1].trim());
							} else if (lines[i].contains("Allergy")) {
								reports.setAllergy(split[1].trim());
							} else if (lines[i].contains("Doctor First Name")) {
								doc.setFirstName(split[1].trim());
							} else if (lines[i].contains("Doctor Last Name")) {
								doc.setLastName(split[1].trim());
							} else if (lines[i].contains("Registered")) {
								doc.setRegistered_id(split[1].trim());
								regId = split[1].trim();
							} else if (lines[i].contains("Mob")) {
								doc.setMobileNo(split[1].trim());
							} else if (lines[i].contains("Qualification")) {
								doc.setQualification(split[1].trim());
							} else if (lines[i].contains("Duration")) {
								pat.setCourse_length(Integer.parseInt(split[1].trim().substring(0, 2)));
							}

						} else {

							if (lines[i].contains("TST")) {
								String tst[] = lines[i].split(" ");
								reports.setTst_induration(Float.parseFloat(tst[4]));
								if (tst[5].contains("Positive"))
									reports.setTst_result(true);
								else
									reports.setTst_result(false);

							} else if (lines[i].contains("Rapid Test")) {
								String hiv[] = lines[i].split(" ");
								if (hiv[5].contains("Positive"))
									reports.setHiv_status(true);
								else
									reports.setHiv_status(false);
							}
						}

					}

				}

				DateFormat df = new SimpleDateFormat("dd/mm/yyyy");
				String reverseDate[] = courseDate.split("-");
				String newDate = reverseDate[2] + "/" + reverseDate[1] + "/" + reverseDate[0];
				Date courseStartDate = df.parse(newDate);
				List<PatientAppointment> appointments = calculateAppointmentSchedule(courseStartDate,
						pat.getCourse_length(), regId);

				if (appointments != null) {
					for (PatientAppointment appoint : appointments) {
						reports.getPatientAppointments().add(appoint);
						doc.getDoctorAppointments().add(appoint);
					}
				}

				pat.getReports().add(reports);
				doc.getPatients().add(pat);

				boolean flag = doctordao.registerdoc(doc);
				if (flag) {

					HashMap<String, Object> patientData = new HashMap<String, Object>();

					if (null != pat.getReports()) {

						List<UserReports> patientReports = pat.getReports();

						// Sort Ascending
						Collections.sort(patientReports, new Comparator<UserReports>() {

							@Override
							public int compare(UserReports o1, UserReports o2) {
								// TODO Auto-generated method stub
								return o1.getDate().compareTo(o2.getDate());
							}
						});

						// Sort Descending
						Collections.sort(patientReports, Collections.reverseOrder());

						patientData.put("reports", patientReports);
						patientData.put("patient", pat);

						Iterator iterate = patientReports.iterator();

						if (iterate != null) {
							UserReports report = (UserReports) iterate.next();

							patientData.put("recentReport", report);

						}

						patientData.put("message", "Appointment booked succesfully");
						return new ModelAndView("patient-dashboard", "patientdata", patientData);
					}
					return new ModelAndView("patient-dashboard", "error", "Report could not be parsed properly");
				} else {
					return new ModelAndView("patient-dashboard", "error", "Patient registration failed");
				}

			} catch (Exception e) {
				e.printStackTrace();
				return new ModelAndView("patient-dashboard", "error", "Patient registration failed");
			}

		}

		return new ModelAndView("patient-dashboard", "error", "Patient registration failed");

	}

	public List<PatientAppointment> calculateAppointmentSchedule(Date startDate, int length, String docRegId) {

		int noOfAppointments = length / 10;
		int dateCounter = noOfAppointments;
		doctor doc = appoint.getAppointments(docRegId);
		List<PatientAppointment> appointmentFinal = new ArrayList<PatientAppointment>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(startDate);
		if (doc != null) {
			List<patient> patients = doc.getPatients();
			while (dateCounter != 0) {
				for (patient pat : patients) {

					for (UserReports report : pat.getReports()) {

						for (PatientAppointment app : report.getPatientAppointments()) {
							// if current start date is same as this patients date, increment the date
							if (startDate.compareTo(app.getDate()) == 0) {
								cal.add(Calendar.DATE, 1);
							}
						}
					}

				}

				PatientAppointment pata = new PatientAppointment();
				pata.setDate(cal.getTime());
				pata.setTime("09:00 am");
				appointmentFinal.add(pata);
				// add 10 days for next appointment
				cal.add(Calendar.DATE, 10);

				startDate = cal.getTime();
				dateCounter--;
			}

			if (appointmentFinal != null || !appointmentFinal.isEmpty()) {
				return appointmentFinal;
			} else {
				return null;
			}
		} else {
			while (dateCounter != 0) {
				PatientAppointment pata = new PatientAppointment();
				pata.setDate(cal.getTime());
				pata.setTime("09:00 am");
				appointmentFinal.add(pata);
				// add 10 days for next appointment
				cal.add(Calendar.DATE, 10);

				startDate = cal.getTime();
				dateCounter--;
			}
			if (appointmentFinal != null || !appointmentFinal.isEmpty()) {
				return appointmentFinal;
			} else {
				return null;
			}
		}
	}

	@RequestMapping(value = "/user/appointmentList.htm", method = RequestMethod.GET)
	public ModelAndView returnAppointments(HttpServletRequest request) {

		String patientId = request.getParameter("patient_id");
		patient pat = patientdao.getPatientRecord(Long.parseLong(patientId));

		List<AppointmentData> appointList = new ArrayList<AppointmentData>();

		if (pat != null) {

			if (pat.getReports() != null) {
				for (UserReports reports : pat.getReports()) {

					for (PatientAppointment app : reports.getPatientAppointments()) {
						AppointmentData appointData = new AppointmentData();

						doctor doc = appoint.getDoctor(app.getId());

						appointData.setId(app.getId());

						DateFormat df = new SimpleDateFormat("yyyy-mm-dd");
						String date = df.format(app.getDate());
						Date newDate = null;
						try {
							newDate = df.parse(date);
							appointData.setDate(date);
						} catch (Exception e) {
							appointData.setDate(date);
						}

						appointData.setTime(app.getTime());
						String day = new SimpleDateFormat("EE").format(app.getDate());
						appointData.setDay(day);
						appointData.setDoc_name(doc.getFirstName() + " " + doc.getLastName());
						appointData.setClinic_name(reports.getHospital_name());
						appointData.setClinic_address(doc.getAddress());
						appointData.setAppointment_status(app.getStatus());
						appointList.add(appointData);
					}

				}

			}

		}

		return new ModelAndView("patient-appointment", "appointmentList", appointList);

	}
	
	@RequestMapping(value="/user/editAppointment.htm",method=RequestMethod.POST)
	@ResponseBody
	public String returnReschedule(@RequestBody AppointmentData json) {
		
		if(json != null) {
			System.out.println(json.getId());
		}
		
		return "In Here";
	}
	

}
