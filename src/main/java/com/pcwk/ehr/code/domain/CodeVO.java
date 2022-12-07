package com.pcwk.ehr.code.domain;

import com.pcwk.ehr.board.cmn.DTO;

public class CodeVO extends DTO {
	private String mstCode ; //마스터코드
	private String detCode ; //디테일코드
	private String mstName ; //마스터명
	private String detName ; //디테일명
	private int    seq 	   ; //순서
	private String useYn   ; //사용여부
	
	public CodeVO() {}

	public CodeVO(String mstCode, String detCode, String mstName, String detName, int seq, String useYn) {
		super();
		this.mstCode = mstCode;
		this.detCode = detCode;
		this.mstName = mstName;
		this.detName = detName;
		this.seq = seq;
		this.useYn = useYn;
	}

	public String getMstCode() {
		return mstCode;
	}

	public void setMstCode(String mstCode) {
		this.mstCode = mstCode;
	}

	public String getDetCode() {
		return detCode;
	}

	public void setDetCode(String detCode) {
		this.detCode = detCode;
	}

	public String getMstName() {
		return mstName;
	}

	public void setMstName(String mstName) {
		this.mstName = mstName;
	}

	public String getDetName() {
		return detName;
	}

	public void setDetName(String detName) {
		this.detName = detName;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	@Override
	public String toString() {
		return "CodeVo [mstCode=" + mstCode + ", detCode=" + detCode + ", mstName=" + mstName + ", detName=" + detName
				+ ", seq=" + seq + ", useYn=" + useYn + ", toString()=" + super.toString() + "]";
	}
	
	
}
