package com.pcwk.ehr.chart.domain;

import com.pcwk.ehr.evcar.cmn.evDTO;

public class evChartVO  extends evDTO {
	
	private String standardDate;
	private int countSum;
	private int ulsan;
	private int choongbuk;
	private int seoul;
	private int jeonbuk;
	private int gyeonggi;
	private int choongnam;
	private int busan;
	private int gangwon;
	private int gyeongbuk;
	private int daejeon;
	private int sejong;
	private int jeju;
	private int daegu;
	private int incheon;
	private int jeonnam;
	private int gyeongnam;
	private int gwangju;
	
	public evChartVO() {}

	public evChartVO(String standardDate, int countSum, int ulsan, int choongbuk, int seoul, int jeonbuk, int gyeonggi,
			int choongnam, int busan, int gangwon, int gyeongbuk, int daejeon, int sejong, int jeju, int daegu,
			int incheon, int jeonnam, int gyeongnam, int gwangju) {
		super();
		this.standardDate = standardDate;
		this.countSum = countSum;
		this.ulsan = ulsan;
		this.choongbuk = choongbuk;
		this.seoul = seoul;
		this.jeonbuk = jeonbuk;
		this.gyeonggi = gyeonggi;
		this.choongnam = choongnam;
		this.busan = busan;
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

	public String getStandardDate() {
		return standardDate;
	}

	public void setStandardDate(String standardDate) {
		this.standardDate = standardDate;
	}

	public int getCountSum() {
		return countSum;
	}

	public void setCountSum(int countSum) {
		this.countSum = countSum;
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
		return "evChartVO [standardDate=" + standardDate + ", countSum=" + countSum + ", ulsan=" + ulsan
				+ ", choongbuk=" + choongbuk + ", seoul=" + seoul + ", jeonbuk=" + jeonbuk + ", gyeonggi=" + gyeonggi
				+ ", choongnam=" + choongnam + ", busan=" + busan + ", gangwon=" + gangwon + ", gyeongbuk=" + gyeongbuk
				+ ", daejeon=" + daejeon + ", sejong=" + sejong + ", jeju=" + jeju + ", daegu=" + daegu + ", incheon="
				+ incheon + ", jeonnam=" + jeonnam + ", gyeongnam=" + gyeongnam + ", gwangju=" + gwangju
				+ ", toString()=" + super.toString() + "]";
	}

	
}
