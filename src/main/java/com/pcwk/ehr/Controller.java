package com.pcwk.ehr;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@org.springframework.stereotype.Controller
public class Controller {

	@RequestMapping(value = "/elecmusk/everything.do", method = RequestMethod.GET)
	public String mainHome(Model model) {
		
		System.out.println("======================================");
		System.out.println("=구동중이다=");
		System.out.println("======================================");
		/*
		 * servlet-context.xml
		 * InternalResourceVidwresolver
		 * WEB-INF/views/+'hello'+.jsp
		 */
		return "/elecmusk/main_home";
	}
	
}
