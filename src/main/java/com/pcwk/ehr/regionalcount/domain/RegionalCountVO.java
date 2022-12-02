package com.pcwk.ehr.regionalcount.domain;

import com.pcwk.ehr.cmn.DTO;

public class RegionalCountVO extends DTO {
	
	private int ulsan;				//울산
	private int choongbuk;			//충분
	private int count_sum;			//전기차현황 합계
	private int	seoul;				//서울
	private int	jeonbuk;			//전북
	private int gyeonggi;			//경기
	private int	choongnam;			//충남
	private int busan;				//부산
	private String standard_date;	//기준일
	private int gangwon;			//강원
	private int gyeongbuk;			//경북
	private int daejeon;			//대전
	private int sejong;				//세종
	private int jeju;				//세종
	private int daegu;				//대구
	private int incheon;			//인천
	private int jeonnam;			//전남
	private int gyeongnam;			//경남
	private int gwangju;			//광주
	
	public RegionalCountVO() {}

	public RegionalCountVO(int ulsan, int choongbuk, int count_sum, int seoul, int jeonbuk, int gyeonggi, int choongnam,
			int busan, String standard_date, int gangwon, int gyeongbuk, int daejeon, int sejong, int jeju, int daegu,
			int incheon, int jeonnam, int gyeongnam, int gwangju) {
		super();
		this.ulsan = ulsan;
		this.choongbuk = choongbuk;
		this.count_sum = count_sum;
		this.seoul = seoul;
		this.jeonbuk = jeonbuk;
		this.gyeonggi = gyeonggi;
		this.choongnam = choongnam;
		this.busan = busan;
		this.standard_date = standard_date;
		this.gangwon = gangwon;
		this.gyeongbuk = gyeongbuk;
		this.daejeon = daejeon;
		this.sejong = sejong;
		this.jeju = jeju;
		this.daegu = daegu;
		this.incheon = incheon;
		this.jeonnam = jeonnam;
		this.gyeongnam = gyeongnam;
		this.gwangju = gwangju;
	}

	public int getUlsan() {
		return ulsan;
	}

	public void setUlsan(int ulsan) {
		this.ulsan = ulsan;
	}

	public int getChoongbuk() {
		return choongbuk;
	}

	public void setChoongbuk(int choongbuk) {
		this.choongbuk = choongbuk;
	}

	public int getCount_sum() {
		return count_sum;
	}

	public void setCount_sum(int count_sum) {
		this.count_sum = count_sum;
	}

	public int getSeoul() {
		return seoul;
	}

	public void setSeoul(int seoul) {
		this.seoul = seoul;
	}

	public int getJeonbuk() {
		return jeonbuk;
	}

	public void setJeonbuk(int jeonbuk) {
		this.jeonbuk = jeonbuk;
	}

	public int getGyeonggi() {
		return gyeonggi;
	}

	public void setGyeonggi(int gyeonggi) {
		this.gyeonggi = gyeonggi;
	}

	public int getChoongnam() {
		return choongnam;
	}

	public void setChoongnam(int choongnam) {
		this.choongnam = choongnam;
	}

	public int getBusan() {
		return busan;
	}

	public void setBusan(int busan) {
		this.busan = busan;
	}

	public String getStandard_date() {
		return standard_date;
	}

	public void setStandard_date(String standard_date) {
		this.standard_date = standard_date;
	}

	public int getGangwon() {
		return gangwon;
	}

	public void setGangwon(int gangwon) {
		this.gangwon = gangwon;
	}

	public int getGyeongbuk() {
		return gyeongbuk;
	}

	public void setGyeongbuk(int gyeongbuk) {
		this.gyeongbuk = gyeongbuk;
	}

	public int getDaejeon() {
		return daejeon;
	}

	public void setDaejeon(int daejeon) {
		this.daejeon = daejeon;
	}

	public int getSejong() {
		return sejong;
	}

	public void setSejong(int sejong) {
		this.sejong = sejong;
	}

	public int getJeju() {
		return jeju;
	}

	public void setJeju(int jeju) {
		this.jeju = jeju;
	}

	public int getDaegu() {
		return daegu;
	}

	public void setDaegu(int daegu) {
		this.daegu = daegu;
	}

	public int getIncheon() {
		return incheon;
	}

	public void setIncheon(int incheon) {
		this.incheon = incheon;
	}

	public int getJeonnam() {
		return jeonnam;
	}

	public void setJeonnam(int jeonnam) {
		this.jeonnam = jeonnam;
	}

	public int getGyeongnam() {
		return gyeongnam;
	}

	public void setGyeongnam(int gyeongnam) {
		this.gyeongnam = gyeongnam;
	}

	public int getGwangju() {
		return gwangju;
	}

	public void setGwangju(int gwangju) {
		this.gwangju = gwangju;
	}

	@Override
	public String toString() {
		return "RegionalCountVO [ulsan=" + ulsan + ", choongbuk=" + choongbuk + ", count_sum=" + count_sum + ", seoul="
				+ seoul + ", jeonbuk=" + jeonbuk + ", gyeonggi=" + gyeonggi + ", choongnam=" + choongnam + ", busan="
				+ busan + ", standard_date=" + standard_date + ", gangwon=" + gangwon + ", gyeongbuk=" + gyeongbuk
				+ ", daejeon=" + daejeon + ", sejong=" + sejong + ", jeju=" + jeju + ", daegu=" + daegu + ", incheon="
				+ incheon + ", jeonnam=" + jeonnam + ", gyeongnam=" + gyeongnam + ", gwangju=" + gwangju + "]";
	}
	
	
}
