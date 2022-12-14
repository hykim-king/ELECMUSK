package com.pcwk.ehr.board.comment.domain;

public class BoardCommentVO {
 private int cmSeq;//댓글순번
 private int bdSeq;//게시판순번
 private String contents;//댓글내용
 private String regDt;//등록일
 
 public BoardCommentVO() {}



public BoardCommentVO(int cmSeq, int bdSeq, String contents, String regDt) {
	super();
	this.cmSeq = cmSeq;
	this.bdSeq = bdSeq;
	this.contents = contents;
	this.regDt = regDt;
}








public int getCmSeq() {
	return cmSeq;
}

public int getBdSeq() {
	return bdSeq;
}

public String getContents() {
	return contents;
}

public String getRegDt() {
	return regDt;
}

public void setCmSeq(int cmSeq) {
	this.cmSeq = cmSeq;
}

public void setBdSeq(int bdSeq) {
	this.bdSeq = bdSeq;
}

public void setContents(String contents) {
	this.contents = contents;
}

public void setRegDt(String regDt) {
	this.regDt = regDt;
}



@Override
public String toString() {
	return "BoardCommentVO [cmSeq=" + cmSeq + ", bdSeq=" + bdSeq + ", contents=" + contents + ", regDt=" + regDt
			+ "]";
}


 
}
