package com.pcwk.ehr;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller("HomeController")
@RequestMapping("elecmusk")
public class HomeController {
	
	private static final Logger LOG = LoggerFactory.getLogger(HomeController.class);
	
	public HomeController() {}
	
	@RequestMapping(value = "mainhome.do", method = RequestMethod.GET)
	public String mainHome() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                 mainHome                  │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return "main_home";
	}
	
	@RequestMapping(value = "evcar.do", method = RequestMethod.GET)
	public String evCar() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                   evCar                   │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return "evCar";
	}
	
}
