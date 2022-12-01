package com.pcwk.ehr.evcar.cmn;

public class evDTO {
	private int totalCnt;//총글수
	private int num;//글번호
	
	public evDTO() {}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	@Override
	public String toString() {
		return "DTO [totalCnt=" + totalCnt + ", num=" + num + "]";
	}
}
