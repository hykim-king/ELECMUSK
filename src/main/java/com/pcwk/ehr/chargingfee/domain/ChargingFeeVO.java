package com.pcwk.ehr.chargingfee.domain;

import com.pcwk.ehr.evcar.cmn.evDTO;

public class ChargingFeeVO extends evDTO {
	
	private int provider_seq;		//충전기순번
	private String image;			//이미지경로
	private String enterprenuer;	//사업자명
	private int rapid_below100;		//급속100kW미만요금
	private int rapid_above100;		//급속100kW이상요금
	private int slow_fee;			//완속충전요금
	
	public ChargingFeeVO() {}

	public ChargingFeeVO(int provider_seq, String image, String enterprenuer, int rapid_below100, int rapid_above100,
			int slow_fee) {
		super();
		this.provider_seq = provider_seq;
		this.image = image;
		this.enterprenuer = enterprenuer;
		this.rapid_below100 = rapid_below100;
		this.rapid_above100 = rapid_above100;
		this.slow_fee = slow_fee;
	}

	public int getProvider_seq() {
		return provider_seq;
	}

	public void setProvider_seq(int provider_seq) {
		this.provider_seq = provider_seq;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getEnterprenuer() {
		return enterprenuer;
	}

	public void setEnterprenuer(String enterprenuer) {
		this.enterprenuer = enterprenuer;
	}

	public int getRapid_below100() {
		return rapid_below100;
	}

	public void setRapid_below100(int rapid_below100) {
		this.rapid_below100 = rapid_below100;
	}

	public int getRapid_above100() {
		return rapid_above100;
	}

	public void setRapid_above100(int rapid_above100) {
		this.rapid_above100 = rapid_above100;
	}

	public int getSlow_fee() {
		return slow_fee;
	}

	public void setSlow_fee(int slow_fee) {
		this.slow_fee = slow_fee;
	}

	@Override
	public String toString() {
		return "ChargingFeeVO [provider_seq=" + provider_seq + ", image=" + image + ", enterprenuer=" + enterprenuer
				+ ", rapid_below100=" + rapid_below100 + ", rapid_above100=" + rapid_above100 + ", slow_fee=" + slow_fee
				+ "]";
	}

	
	
}
