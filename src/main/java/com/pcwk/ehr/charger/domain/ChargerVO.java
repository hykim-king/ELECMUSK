package com.pcwk.ehr.charger.domain;

import com.pcwk.ehr.evcar.cmn.evDTO;

public class ChargerVO extends evDTO {
	
	private int charger_seq;	    //충전기순번
	private String connector;		//충전기명
	private String image;			//이미지경로
	private String ev_current;		//충전전류
	private String ev_voltage;		//충전전압
	private String ev_power;		//충전전력
	private String ev_level;		//충전레벨
	private String ev_support;		//지원차량
	
	public ChargerVO() {}

	public ChargerVO(int charger_seq, String connector, String image, String ev_current, String ev_voltage,
			String ev_power, String ev_level, String ev_support) {
		super();
		this.charger_seq = charger_seq;
		this.connector = connector;
		this.image = image;
		this.ev_current = ev_current;
		this.ev_voltage = ev_voltage;
		this.ev_power = ev_power;
		this.ev_level = ev_level;
		this.ev_support = ev_support;
	}

	public int getCharger_seq() {
		return charger_seq;
	}

	public void setCharger_seq(int charger_seq) {
		this.charger_seq = charger_seq;
	}

	public String getConnector() {
		return connector;
	}

	public void setConnector(String connector) {
		this.connector = connector;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getEv_current() {
		return ev_current;
	}

	public void setEv_current(String ev_current) {
		this.ev_current = ev_current;
	}

	public String getEv_voltage() {
		return ev_voltage;
	}

	public void setEv_voltage(String ev_voltage) {
		this.ev_voltage = ev_voltage;
	}

	public String getEv_power() {
		return ev_power;
	}

	public void setEv_power(String ev_power) {
		this.ev_power = ev_power;
	}

	public String getEv_level() {
		return ev_level;
	}

	public void setEv_level(String ev_level) {
		this.ev_level = ev_level;
	}

	public String getEv_support() {
		return ev_support;
	}

	public void setEv_support(String ev_support) {
		this.ev_support = ev_support;
	}

	@Override
	public String toString() {
		return "ChargerVO [charger_seq=" + charger_seq + ", connector=" + connector + ", image=" + image
				+ ", ev_current=" + ev_current + ", ev_voltage=" + ev_voltage + ", ev_power=" + ev_power + ", ev_level="
				+ ev_level + ", ev_support=" + ev_support + "]";
	}

	
}
