package com.pcwk.ehr;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller("HomeController")
public class HomeController {
	
	private static final Logger LOG = LoggerFactory.getLogger(HomeController.class);
	
	final String VIEW_NAME = "elecmusk/main_home";
	
	public HomeController() {}
	
	@RequestMapping(value = "/elecmusk/view.do", method = RequestMethod.GET)
	public String mainHome() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                 mainHome                  │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return VIEW_NAME;
	}
	
	@RequestMapping(value = "/elecmusk/evcar.do", method = RequestMethod.GET)
	public String evCar() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                   evCar                   │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return "elecmusk/evCar";
	}
	
	@RequestMapping(value = "/elecmusk/subsidy.do", method = RequestMethod.GET)
	public String subsidy() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                   subsidy                 │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return "elecmusk/subsidy";
	}
	
	@RequestMapping(value = "/elecmusk/station.do", method = RequestMethod.GET)
	public String station() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│                   station                 │");
		LOG.debug("└───────────────────────────────────────────┘");		
		
		return "elecmusk/station";
	}

}
