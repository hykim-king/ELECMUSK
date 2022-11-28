package com.pcwk.ehr.board.cmn;

public class DTO {
	private int totalCnt;//총글수
	private int num;//글번호
	
	public DTO() {
	}

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
