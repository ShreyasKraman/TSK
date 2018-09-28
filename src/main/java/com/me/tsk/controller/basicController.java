package com.me.tsk.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.fileupload.FileUploadBase.FileUploadIOException;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.captcha.botdetect.web.servlet.Captcha;
import com.me.tsk.dao.PatientDAO;
import com.me.tsk.pojo.patient;
import com.sun.mail.iap.Response;

@Controller
public class basicController {

	@Autowired
	@Qualifier("patientDAO")
	PatientDAO patientdao;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String goToHome() {
		return "home";
	}

	@RequestMapping(value = "/login.htm", method = RequestMethod.GET)
	public String goToLogin() {
		return "login";
	}

	@RequestMapping(value = "user/validateemail.htm", method = RequestMethod.GET)
	public ModelAndView validateUser(HttpServletRequest request) {
		HttpSession session = request.getSession();

		String email = request.getParameter("email");

		int key1 = Integer.parseInt(request.getParameter("key1"));

		int key2 = Integer.parseInt(request.getParameter("key2"));

		System.out.println(session.getAttribute("key1"));

		System.out.println(session.getAttribute("key2"));

		try {
			if ((Integer) (session.getAttribute("key1")) == key1 && ((Integer) session.getAttribute("key2")) == key2) {

				try {

					boolean updateStatus = patientdao.updatePatient(email);

					if (updateStatus) {

						return new ModelAndView("login", "successVerify", "Account verified successfully!");

					} else {

						return new ModelAndView("login", "errorVerify",
								"Error while verifying account. Please try after some time");

					}

				} catch (Exception e) {

					e.printStackTrace();

				}

			} else {

				return new ModelAndView("login", "expired", "Link expired, generate new link.");

			}
		} catch (NullPointerException e) {
			return new ModelAndView("login", "expired", "Link expired, generate new link.");
		}
		return new ModelAndView("login");
	}
	
	@RequestMapping(value = "user/validateregister.htm", method = RequestMethod.GET)
	public ModelAndView validateRegister(HttpServletRequest request) {
		HttpSession session = request.getSession();

		String email = request.getParameter("email");

		int key1 = Integer.parseInt(request.getParameter("regKey"));

		System.out.println(session.getAttribute("key1"));

		try {
			if ((Integer) (session.getAttribute("key1")) == key1) {

				try {
					
					if (session.getAttribute("username") != null)
						session.invalidate();

					boolean updateStatus = patientdao.updatePatient(email);
					patient pat = patientdao.getPatientInfo(email);
					if (updateStatus) {

						return new ModelAndView("patient-register", "re_register", pat);

					} else {

						return new ModelAndView("patient-register", "re_register_error",
								"It seems the link expired or wrong record link was sent."
										+ " No worries, register here yourself and rest will be taken care by us");

					}

				} catch (Exception e) {

					e.printStackTrace();

				}

			} else {

				return new ModelAndView("patient-register", "re_register_error",
						"It seems the link expired or wrong record link was sent."
								+ " No worries, register here yourself and rest will be taken care by us");

			}
		} catch (NullPointerException e) {
			return new ModelAndView("patient-register", "re_register_error",
					"It seems the link expired or wrong record link was sent."
							+ " No worries, register here yourself and rest will be taken care by us");
		}
		return new ModelAndView("patient-register");
	}

	@RequestMapping(value = "/login.htm", method = RequestMethod.POST)
	public String patientLogin(HttpServletRequest request, ModelMap map, HttpServletResponse response) {

		String username = request.getParameter("username");

		String password = request.getParameter("password");

		if (username.equals("admin@gmail.com") && password.equals("admin")) {
			HttpSession session = request.getSession();
			session.setAttribute("username", "admin");
			session.setAttribute("regDocId", "ME88726");
			return "redirect:/doctor/dashboard.htm";
		}

		String hashedPassword = DigestUtils.sha1Hex(password);
		try {

			patient pat = patientdao.get(username, hashedPassword);
			if (pat != null && pat.isVerify()) {

				HttpSession session = request.getSession();
				if (session != null) {
					session.setAttribute("username", pat.getFirstName());
					session.setAttribute("email", pat.getEmail());
				}

				return "redirect:/";

			} else if (pat != null && !pat.isVerify()) {

				request.setAttribute("errorMessage", "Please activate your account from your email address to login!");

				return "login";

			} else {

				request.setAttribute("errorMessage", "Invalid username/password!");

				return "login";

			}

		} catch (Exception e) {

			// TODO Auto-generated catch block

			e.printStackTrace();

		}
		return null;

	}

	@RequestMapping(value = "/register.htm", method = RequestMethod.GET)
	public String goToRegister() {
		return "patient-register";
	}

	@RequestMapping(value = "/register.htm", method = RequestMethod.POST)
	public ModelAndView registerUser(HttpServletRequest request, @RequestParam("profilePicture") MultipartFile file) {

		Captcha captcha = Captcha.load(request, "CaptchaObject");

		String captchaCode = request.getParameter("captchaCode");

		HttpSession session = request.getSession();

		if (captcha.validate(captchaCode)) {

			String useremail = request.getParameter("emailAddress");

			String password = request.getParameter("password");

			String address = request.getParameter("address");

			String mobileNumber = request.getParameter("mobileNumber");

			String addressField = request.getParameter("address");

			String pincode = request.getParameter("pincode");

			String firstName = request.getParameter("firstName");

			String lastName = request.getParameter("lastName");

			patient pat = new patient();

			pat.setFirstName(firstName);

			pat.setLastName(lastName);

			try {
				pat.setPincode(Integer.parseInt(pincode));
			} catch (NumberFormatException ex) {
				return new ModelAndView("register-patient", "errorValue",
						"Pincode Not Valid. Please enter numeric value only");
			} catch (Exception e) {
				e.printStackTrace();
				return new ModelAndView("register-patient", "errorValue",
						"Error while processsing data. Please try after sometime");
			}
			pat.setVerify(false);

			try {
				pat.setMobileNumber(Long.parseLong(mobileNumber));
			} catch (NumberFormatException ex) {
				return new ModelAndView("register-patient", "errorValue",
						"Mobile Number Not Valid. Please enter numeric value only");
			} catch (Exception e) {
				e.printStackTrace();
				return new ModelAndView("register-patient", "errorValue",
						"Error while processsing data. Please try after sometime");

			}
			pat.setEmail(useremail);

			String sha1Password = DigestUtils.sha1Hex(password);

			pat.setPassword(sha1Password);

			pat.setAddress(addressField);

			try {
				if (file != null) {
					String filePath = "C:\\Users\\shrey\\TSK\\"+ pat.getFirstName() + "_" + pat.getLastName()
							+ "\\profile_pic";
					
					
					File newFile = new File(filePath, file.getOriginalFilename());

					if (!newFile.exists()) {
						newFile.getParentFile().mkdirs();
					}
					file.transferTo(newFile);
					pat.setImagePath(filePath + "\\" + file.getOriginalFilename());
				}
			} catch (Exception fe) {
				fe.printStackTrace();
			}

			try {

				boolean flag = patientdao.registerPatient(pat);

				if (flag) {
					Random rand = new Random();

					int randomNum1 = rand.nextInt(5000000);

					int randomNum2 = rand.nextInt(5000000);

					try {

						String str = "http://localhost:8080/tsk/user/validateemail.htm?email=" + useremail + "&key1="

								+ randomNum1 + "&key2=" + randomNum2;

						session.setAttribute("key1", randomNum1);

						session.setAttribute("key2", randomNum2);

						// session set to one whole day
						session.setMaxInactiveInterval(24 * 60 * 60);

						String message = "<!doctype html><html><body>Hi User,<br>Click on this link to activate your account :"
								+ str
								+ " <br> This link will be valid for 24 hrs only.<br><br>Thanks & Regards, <br>TSK Team.<br>&copy; Health-cure Team</body></html>";

						sendEmail(useremail, message);

						return new ModelAndView("login", "verification", "true");

					} catch (Exception e) {

						System.out.println("Email cannot be sent");

					}
				}

			} catch (Exception e) {

				e.printStackTrace();

			}

		} else {
			return new ModelAndView("patient-register", "errorValue", "Invalid Captcha");

		}

		return new ModelAndView("login", "successVerify", "Account updated successfully");
	}

	@RequestMapping(value = "user/resendemail.htm", method = RequestMethod.GET)
	public String resendEmailUI() {
		return "resend-verify";
	}

	@RequestMapping(value = "user/resendemail.htm", method = RequestMethod.POST)

	public ModelAndView resendEmail(HttpServletRequest request) {

		HttpSession session = request.getSession();

		String useremail = request.getParameter("username");

		Random rand = new Random();

		int randomNum1 = rand.nextInt(5000000);

		int randomNum2 = rand.nextInt(5000000);

		try {

			String str = "http://localhost:8080/tsk/user/validateemail.htm?email=" + useremail + "&key1=" + randomNum1

					+ "&key2=" + randomNum2;

			session.setAttribute("key1", randomNum1);

			session.setAttribute("key2", randomNum2);

			sendEmail(useremail,

					"Click on this link to activate your account : " + str);

		} catch (Exception e) {

			System.out.println("Email cannot be sent");

		}

		return new ModelAndView("login", "verification", "true");

	}

	@RequestMapping(value = "user/resendRegisterEmail.htm", method = RequestMethod.POST)

	public ModelAndView resendRegisterEmail(HttpServletRequest request) {

		HttpSession session = request.getSession();

		String useremail = request.getParameter("username");

		Random rand = new Random();

		int randomNum1 = rand.nextInt(5000000);

		try {

			String str = "http://localhost:8080/tsk/user/validateregister.htm?email=" + useremail + "&regKey="
					+ randomNum1;

			session.setAttribute("key1", randomNum1);

			sendEmail(useremail,

					"Click on this link to activate your account : " + str);

		} catch (Exception e) {

			System.out.println("Email cannot be sent");

		}

		return new ModelAndView("login", "verification", "true");

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


	@RequestMapping(value = "/user/logout.htm", method = RequestMethod.GET)
	public String userLogout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("username") != null)
			session.invalidate();
		return "redirect:/";
	}

}
