package com.pcwk.ehr.board.comment.domain;

import com.pcwk.ehr.board.cmn.DTO;

public class BoardCommentSearchVO extends DTO {
	
	private int bdSeq;// 게시판글 번호 
	private int pageSize;//페이즈 사이즈(default = 10)
	private int pageNo;//페이지 번호(default = 1)
	private String searchDiv;//검색구분(default = "")
	private String searchWord;//검색어(default = "")
	
	public BoardCommentSearchVO() {}

	public BoardCommentSearchVO(int bdSeq, int pageSize, int pageNo, String searchDiv, String searchWord) {
		super();
		this.bdSeq = bdSeq;
		this.pageSize = pageSize;
		this.pageNo = pageNo;
		this.searchDiv = searchDiv;
		this.searchWord = searchWord;
	}

	public int getBdSeq() {
		return bdSeq;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getPageNo() {
		return pageNo;
	}

	public String getSearchDiv() {
		return searchDiv;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setBdSeq(int bdSeq) {
		this.bdSeq = bdSeq;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public void setSearchDiv(String searchDiv) {
		this.searchDiv = searchDiv;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	@Override
	public String toString() {
		return "BoardCommentSearchVO [bdSeq=" + bdSeq + ", pageSize=" + pageSize + ", pageNo=" + pageNo + ", searchDiv="
				+ searchDiv + ", searchWord=" + searchWord + ", toString()=" + super.toString() + "]";
	}
	
}
