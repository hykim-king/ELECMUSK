package com.pcwk.ehr.evcar.domain;

import com.pcwk.ehr.evcar.cmn.evDTO;

public class EvCarVO extends evDTO {
	
	private int carNo;
	private String carName;
	private String imgUrl;
	private String carPrice;
	private String manufacture;
	private int productYear;
	private String appearance;
	private String carModel;
	private String maxDistance;
	private String batteryType;
	private String batteryCapa;
	private int maxSpeed;
	private String outPut;
	
	public EvCarVO() {}


	public EvCarVO(int carNo, String carName, String imgUrl, String carPrice, String manufacture, int productYear,
			String appearance, String carModel, String maxDistance, String batteryType, String batteryCapa,
			int maxSpeed, String outPut) {
		super();
		this.carNo = carNo;
		this.carName = carName;
		this.imgUrl = imgUrl;
		this.carPrice = carPrice;
		this.manufacture = manufacture;
		this.productYear = productYear;
		this.appearance = appearance;
		this.carModel = carModel;
		this.maxDistance = maxDistance;
		this.batteryType = batteryType;
		this.batteryCapa = batteryCapa;
		this.maxSpeed = maxSpeed;
		this.outPut = outPut;
	}


	public int getCarNo() {
		return carNo;
	}

	public void setCarNo(int carNo) {
		this.carNo = carNo;
	}

	public String getCarName() {
		return carName;
	}

	public void setCarName(String carName) {
		this.carName = carName;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getCarPrice() {
		return carPrice;
	}

	public void setCarPrice(String carPrice) {
		this.carPrice = carPrice;
	}

	public String getManufacture() {
		return manufacture;
	}

	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}


	public int getProductYear() {
		return productYear;
	}


	public void setProductYear(int productYear) {
		this.productYear = productYear;
	}


	public String getAppearance() {
		return appearance;
	}

	public void setAppearance(String appearance) {
		this.appearance = appearance;
	}

	public String getCarModel() {
		return carModel;
	}

	public void setCarModel(String carModel) {
		this.carModel = carModel;
	}

	public String getMaxDistance() {
		return maxDistance;
	}

	public void setMaxDistance(String maxDistance) {
		this.maxDistance = maxDistance;
	}

	public String getBatteryType() {
		return batteryType;
	}

	public void setBatteryType(String batteryType) {
		this.batteryType = batteryType;
	}

	public String getBatteryCapa() {
		return batteryCapa;
	}

	public void setBatteryCapa(String batteryCapa) {
		this.batteryCapa = batteryCapa;
	}

	public int getMaxSpeed() {
		return maxSpeed;
	}

	public void setMaxSpeed(int maxSpeed) {
		this.maxSpeed = maxSpeed;
	}

	public String getOutPut() {
		return outPut;
	}

	public void setOutPut(String outPut) {
		this.outPut = outPut;
	}


	@Override
	public String toString() {
		return "EvCarVO [carNo=" + carNo + ", carName=" + carName + ", imgUrl=" + imgUrl + ", carPrice=" + carPrice
				+ ", manufacture=" + manufacture + ", productYear=" + productYear + ", appearance=" + appearance
				+ ", carModel=" + carModel + ", maxDistance=" + maxDistance + ", batteryType=" + batteryType
				+ ", batteryCapa=" + batteryCapa + ", maxSpeed=" + maxSpeed + ", outPut=" + outPut + ", toString()="
				+ super.toString() + "]";
	}

	
	
	
}
