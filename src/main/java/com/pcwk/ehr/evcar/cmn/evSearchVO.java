package com.pcwk.ehr.evcar.cmn;

public class evSearchVO extends evDTO{
	
	private int pageSize;//페이지 사이즈
	private int pageNo;//페이지 번호
	private String manufactureKeyword; //제조사 키워드
	private String appearanceKeyword;  // 차종 키워드
	private String modelKeyword;	   // 모델 키워드
	private String batteryTypeKeyword; // 배터리타입 키워드
	
	public evSearchVO() {}

	public evSearchVO(int pageSize, int pageNo, String manufactureKeyword, String appearanceKeyword,
			String modelKeyword, String batteryTypeKeyword) {
		super();
		this.pageSize = pageSize;
		this.pageNo = pageNo;
		this.manufactureKeyword = manufactureKeyword;
		this.appearanceKeyword = appearanceKeyword;
		this.modelKeyword = modelKeyword;
		this.batteryTypeKeyword = batteryTypeKeyword;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String getManufactureKeyword() {
		return manufactureKeyword;
	}

	public void setManufactureKeyword(String manufactureKeyword) {
		this.manufactureKeyword = manufactureKeyword;
	}

	public String getAppearanceKeyword() {
		return appearanceKeyword;
	}

	public void setAppearanceKeyword(String appearanceKeyword) {
		this.appearanceKeyword = appearanceKeyword;
	}

	public String getModelKeyword() {
		return modelKeyword;
	}

	public void setModelKeyword(String modelKeyword) {
		this.modelKeyword = modelKeyword;
	}

	public String getBatteryTypeKeyword() {
		return batteryTypeKeyword;
	}

	public void setBatteryTypeKeyword(String batteryTypeKeyword) {
		this.batteryTypeKeyword = batteryTypeKeyword;
	}

	@Override
	public String toString() {
		return "evSearchVO [pageSize=" + pageSize + ", pageNo=" + pageNo + ", manufactureKeyword=" + manufactureKeyword
				+ ", appearanceKeyword=" + appearanceKeyword + ", modelKeyword=" + modelKeyword
				+ ", batteryTypeKeyword=" + batteryTypeKeyword + ", toString()=" + super.toString() + "]";
	}
}
