package com.me.tsk.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/admin/**")
public class adminController {

	@RequestMapping(value="/admin/dashboard.htm",method=RequestMethod.GET)
	public String adminDashboard() {
		
		return "admin-dashboard";
	}
	
	@RequestMapping(value="/admin/add-clinic.htm",method=RequestMethod.GET)
	public String addClinic() {	
		return "add-clinic";
	}
	
	@RequestMapping(value="/admin/add-clinic.htm",method=RequestMethod.POST)
	public String registerClinic(HttpServletRequest request, ModelMap map) {	
		
		
		return "admin-dashboard";
	}
	
}
