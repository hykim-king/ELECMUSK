package com.pcwk.ehr.evcar.cmn;

public class evSearchVO extends evDTO{
	
	private int pageSize;//페이지 사이즈
	private int pageNo;//페이지 번호
	private String searchDiv;//검색구분
	private String searchWord;//검색어
	private String manufactureKeyword; //제조사 키워드
	private String appearanceKeyword;  // 차종 키워드
	private String modelKeyword;	   // 모델 키워드
	private String batteryTypeKeyword; // 배터리타입 키워드
	private String submodelKeyword; // 보조금차종 키워드
	private String madebyKeyword; //생산지 키워드
	private String subsidyKeyword; //보조금 키워드
	private String addrKeyword;//충전소 주소 키워드
	private String cpnmKeyword;//충전소 충전기타입 키워드
	private String cptpKeyword;//충전소 충전방식 키워드
	
	public evSearchVO() {}

	public evSearchVO(int pageSize, int pageNo, String searchDiv, String searchWord, String manufactureKeyword,
			String appearanceKeyword, String modelKeyword, String batteryTypeKeyword, String submodelKeyword,
			String madebyKeyword, String subsidyKeyword, String addrKeyword, String cpnmKeyword, String cptpKeyword) {
		super();
		this.pageSize = pageSize;
		this.pageNo = pageNo;
		this.searchDiv = searchDiv;
		this.searchWord = searchWord;
		this.manufactureKeyword = manufactureKeyword;
		this.appearanceKeyword = appearanceKeyword;
		this.modelKeyword = modelKeyword;
		this.batteryTypeKeyword = batteryTypeKeyword;
		this.submodelKeyword = submodelKeyword;
		this.madebyKeyword = madebyKeyword;
		this.subsidyKeyword = subsidyKeyword;
		this.addrKeyword = addrKeyword;
		this.cpnmKeyword = cpnmKeyword;
		this.cptpKeyword = cptpKeyword;
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

	public String getSearchDiv() {
		return searchDiv;
	}

	public void setSearchDiv(String searchDiv) {
		this.searchDiv = searchDiv;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
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

	public String getSubmodelKeyword() {
		return submodelKeyword;
	}

	public void setSubmodelKeyword(String submodelKeyword) {
		this.submodelKeyword = submodelKeyword;
	}

	public String getMadebyKeyword() {
		return madebyKeyword;
	}

	public void setMadebyKeyword(String madebyKeyword) {
		this.madebyKeyword = madebyKeyword;
	}

	public String getSubsidyKeyword() {
		return subsidyKeyword;
	}

	public void setSubsidyKeyword(String subsidyKeyword) {
		this.subsidyKeyword = subsidyKeyword;
	}

	public String getAddrKeyword() {
		return addrKeyword;
	}

	public void setAddrKeyword(String addrKeyword) {
		this.addrKeyword = addrKeyword;
	}

	public String getCpnmKeyword() {
		return cpnmKeyword;
	}

	public void setCpnmKeyword(String cpnmKeyword) {
		this.cpnmKeyword = cpnmKeyword;
	}

	public String getCptpKeyword() {
		return cptpKeyword;
	}

	public void setCptpKeyword(String cptpKeyword) {
		this.cptpKeyword = cptpKeyword;
	}

	@Override
	public String toString() {
		return "evSearchVO [pageSize=" + pageSize + ", pageNo=" + pageNo + ", searchDiv=" + searchDiv + ", searchWord="
				+ searchWord + ", manufactureKeyword=" + manufactureKeyword + ", appearanceKeyword=" + appearanceKeyword
				+ ", modelKeyword=" + modelKeyword + ", batteryTypeKeyword=" + batteryTypeKeyword + ", submodelKeyword="
				+ submodelKeyword + ", madebyKeyword=" + madebyKeyword + ", subsidyKeyword=" + subsidyKeyword
				+ ", addrKeyword=" + addrKeyword + ", cpnmKeyword=" + cpnmKeyword + ", cptpKeyword=" + cptpKeyword
				+ ", toString()=" + super.toString() + "]";
	}
	
}
