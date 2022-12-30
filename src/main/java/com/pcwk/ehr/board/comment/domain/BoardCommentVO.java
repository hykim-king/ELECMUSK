package com.pcwk.ehr.board.comment.domain;

import com.pcwk.ehr.board.cmn.DTO;

public class BoardCommentVO extends DTO {
	private int cmSeq;// 댓글순번
	private int bdSeq;// 게시판글 순번
	private int  memberSeq;// 작성자  닉네임 
	private String  memberNickname;// 작성자  닉네임 
	private String contents;// 댓글내용
	private String regDt;// 등록일

	public BoardCommentVO() {}

	public BoardCommentVO(int cmSeq, int bdSeq, int memberSeq, String contents,
			String regDt) {
		super();
		this.cmSeq = cmSeq;
		this.bdSeq = bdSeq;
		this.memberSeq = memberSeq;
		this.contents = contents;
		this.regDt = regDt;
	}

	public int getCmSeq() {
		return cmSeq;
	}

	public void setCmSeq(int cmSeq) {
		this.cmSeq = cmSeq;
	}

	public int getBdSeq() {
		return bdSeq;
	}

	public void setBdSeq(int bdSeq) {
		this.bdSeq = bdSeq;
	}

	public int getMemberSeq() {
		return memberSeq;
	}

	public void setMemberSeq(int memberSeq) {
		this.memberSeq = memberSeq;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	@Override
	public String toString() {
		return "BoardCommentVO [cmSeq=" + cmSeq + ", bdSeq=" + bdSeq + ", memberSeq=" + memberSeq + ", memberNickname="
				+ memberNickname + ", contents=" + contents + ", regDt=" + regDt + ", toString()=" + super.toString()
				+ "]";
	}

	
	
}
