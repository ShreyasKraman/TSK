package com.me.tsk.controller;

import java.io.File;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.Multipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.me.tsk.pojo.PatientAppointment;
import com.me.tsk.pojo.UserReports;
import com.me.tsk.pojo.doctor;
import com.me.tsk.pojo.patient;
import com.me.tsk.pojo.sendEmail;

@Controller
public class doctorController {

	@Autowired
	@Qualifier("doctorDAO")
	DoctorDAO docDAO;

	@Autowired
	@Qualifier("appointmentDAO")
	appointmentDAO appoint;

	@Autowired
	@Qualifier("patientDAO")
	PatientDAO patDAO;

	@RequestMapping(value = "/doctor/dashboard.htm", method = RequestMethod.GET)
	public ModelAndView dashBoard(HttpServletRequest request) {

		HttpSession session = request.getSession();
		String regId = (String) session.getAttribute("regDocId");
		try {
			doctor doc = docDAO.getDoc(regId);
			List<patient> patients = doc.getPatients();

			boolean flag = false;
			outer: for (patient pat : patients) {

				for (UserReports report : pat.getReports()) {

					for (PatientAppointment app : report.getPatientAppointments()) {
						flag = true;
						break outer;

					}
				}
			}

			if (!flag) {
				return new ModelAndView("doctor-dashboard", "appointmentMessage",
						"You are all set. There are no appointments Scheduled yet!");
			} else {
				return new ModelAndView("doctor-dashboard", "appointmentList", patients);
			}
		} catch (Exception e) {
			return new ModelAndView("doctor-dashboard", "appointmentMessage",
					"You are all set. There are no appointments Scheduled yet!");
		}
	}

	@RequestMapping(value = "/doctor/register_patient.htm", method = RequestMethod.GET)
	public ModelAndView registerPatient(@ModelAttribute("patientRegister") patient dpregister) {

		return new ModelAndView("doctor-register-patient", "patientRegister", dpregister);
	}

	@RequestMapping(value = "/doctor/register_patient.htm", method = RequestMethod.POST)
	public ModelAndView register(@ModelAttribute("patientRegister") patient pat,
			@RequestParam("medicalReport") MultipartFile file, @RequestParam("courseDate") String courseDate,
			BindingResult result, HttpServletRequest request) {

		PdfReader pdfReader;

		HashMap<String, Object> reportsList = new HashMap<String, Object>();

		if (pat != null) {
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
								} else if (lines[i].contains("Mob")) {
									doc.setMobileNo(split[1].trim());
								} else if (lines[i].contains("Qualification")) {
									doc.setQualification(split[1].trim());
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
					HttpSession session = request.getSession();
					String regDocId = (String) session.getAttribute("regDocId");
					DateFormat df = new SimpleDateFormat("dd/mm/yyyy");
					String reverseDate[] = courseDate.split("-");
					String newDate = reverseDate[2] + "/" + reverseDate[1] + "/" + reverseDate[0];
					Date courseStartDate = df.parse(newDate);
					List<PatientAppointment> appointments = calculateAppointmentSchedule(courseStartDate,
							pat.getCourse_length(), regDocId);

					if (appointments != null) {
						for (PatientAppointment appoint : appointments) {
							reports.getPatientAppointments().add(appoint);
							doc.getDoctorAppointments().add(appoint);
						}
					}
					pat.getReports().add(reports);
					doc.getPatients().add(pat);

					boolean flag = docDAO.registerdoc(doc);
					if (flag) {
						Random rand = new Random();
						int randomNum1 = rand.nextInt(5000000);

						try {

							String str = "http://localhost:8080/tsk/user/validateregister.htm?email=" + pat.getEmail()
									+ "&regKey=" + randomNum1;

							session.setAttribute("key1", randomNum1);
							session.setMaxInactiveInterval(48 * 60 * 60);

							String message = "<!doctype html><html><body>Hi User,<br>Click on this link to activate your account :"
									+ str
									+ " <br> This link will be valid for 48 hrs only.<br><br>Thanks & Regards, <br>TSK Team.<br>&copy; Health-cure Team</body></html>";

							sendEmail(pat.getEmail(), message);
							return new ModelAndView("doctor-register-patient", "success",
									"Patient registered successfully");

						} catch (Exception e) {
							e.printStackTrace();
							return new ModelAndView("doctor-register-patient", "error", "Patient registration failed");
						}
					} else {
						return new ModelAndView("doctor-register-patient", "error", "Patient registration failed");
					}

				} catch (Exception e) {
					e.printStackTrace();
					return new ModelAndView("doctor-register-patient", "error", "Patient registration failed");
				}
			}
		}
		return new ModelAndView("doctor-register-patient", "error", "Patient registration failed");
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

	public void sendEmail(String useremail, String message) {

		try {

			HtmlEmail email = new HtmlEmail();

			email.setHostName("smtp.googlemail.com");

			email.setSmtpPort(465);

			email.setAuthenticator(new DefaultAuthenticator("tsksevakendra@gmail.com", "tskGr@h1k"));

			email.setSSLOnConnect(true);

			email.setFrom("no-reply@tsk.gov.in"); // This user email does not // exist

			email.setSubject("TSK Portal : Account Verification Link");

			email.setHtmlMsg(message); // Retrieve email from the DAO and send this

			email.addTo(useremail);

			email.send();

		} catch (EmailException e) {

			System.out.println("Email cannot be sent");

		}

	}

	@RequestMapping(value = "/doctor/send_email.htm/**", method = RequestMethod.GET)
	public ModelAndView fullAppointmentList(HttpServletRequest request) {
		String email = request.getParameter("email");
		String date = request.getParameter("date");
		String time = request.getParameter("time");
		String reportId = request.getParameter("reportId");
		String clinicName = null;
		try {
			patient pat = patDAO.getPatientInfo(email);
			if (pat != null) {

				for (UserReports report : pat.getReports()) {
					if (report.getReportId() == Long.parseLong(reportId)) {
						clinicName = report.getHospital_name();
						break;
					}
				}

				HashMap<String, Object> mailPackage = new HashMap<String, Object>();
				mailPackage.put("patient", pat);
				mailPackage.put("date", date);
				mailPackage.put("time", time);
				mailPackage.put("clinicName", clinicName);
				return new ModelAndView("doctor-email", "mailPackage", mailPackage);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("doctor-dashboard", "errorMessage",
				"Mailing Service not working! We regret the inconvenience");
	}
	
	@RequestMapping(value = "/doctor/sendmail.htm", method = RequestMethod.POST)
	@ResponseBody
	public boolean sendEmail(@RequestBody sendEmail email,HttpServletRequest request) {
		
		try {

			HtmlEmail mail = new HtmlEmail();

			mail.setHostName("smtp.googlemail.com");

			mail.setSmtpPort(465);

			mail.setAuthenticator(new DefaultAuthenticator("tsksevakendra@gmail.com", "tskGr@h1k"));

			mail.setSSLOnConnect(true);

			mail.setFrom("no-reply@tsk.gov.in"); // This user email does not // exist

			mail.setSubject("TSK Portal : Account Verification Link");

			mail.setHtmlMsg(email.getMessage()); // Retrieve email from the DAO and send this

			mail.addTo(email.getReceiver());

			mail.send();

		} catch (EmailException e) {

			System.out.println("Email cannot be sent");

		}
		
		return false;
	}

}
