package com.pcwk.ehr.subsidy.domain;

import com.pcwk.ehr.evcar.cmn.evDTO;

public class SubsidyVO extends evDTO {
	
	private int subsidy_no;			//보조금번호
	private String name;			//자동차명
	private String model;			//차종(소형,중형,대형)
	private int subsidy;			//보조금(만원)
	private String manufacturer;	//제조사(현대,기아)
	private String madeby;			//생산지(국산,수입)
	
	public SubsidyVO() {}

	public SubsidyVO(int subsidy_no, String name, String model, int subsidy, String manufacturer, String madeby) {
		super();
		this.subsidy_no = subsidy_no;
		this.name = name;
		this.model = model;
		this.subsidy = subsidy;
		this.manufacturer = manufacturer;
		this.madeby = madeby;
	}

	public int getSubsidy_no() {
		return subsidy_no;
	}

	public void setSubsidy_no(int subsidy_no) {
		this.subsidy_no = subsidy_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public int getSubsidy() {
		return subsidy;
	}

	public void setSubsidy(int subsidy) {
		this.subsidy = subsidy;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getMadeby() {
		return madeby;
	}

	public void setMadeby(String madeby) {
		this.madeby = madeby;
	}

	@Override
	public String toString() {
		return "Subsidy [subsidy_no=" + subsidy_no + ", name=" + name + ", model=" + model + ", subsidy=" + subsidy
				+ ", manufacturer=" + manufacturer + ", madeby=" + madeby + "]";
	}
	
	
}
