package com.pcwk.ehr.user.domain;

import com.pcwk.ehr.cmn.DTO;

public class UserSearchVO extends DTO{
	
	private int pageSize;//페이지 사이즈
	private int pageNo;//페이지 번호
	private String searchDiv;//검색구분
	private String searchWord;//검색어
	private String userDiv;//상태 구분 
	
	public UserSearchVO() {}

	public UserSearchVO(int pageSize, int pageNo, String searchDiv, String searchWord, String userDiv) {
		super();
		this.pageSize = pageSize;
		this.pageNo = pageNo;
		this.searchDiv = searchDiv;
		this.searchWord = searchWord;
		this.userDiv = userDiv;
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

	public String getUserDiv() {
		return userDiv;
	}

	public void setUserDiv(String userDiv) {
		this.userDiv = userDiv;
	}

	@Override
	public String toString() {
		return "UserSearchVO [pageSize=" + pageSize + ", pageNo=" + pageNo + ", searchDiv=" + searchDiv
				+ ", searchWord=" + searchWord + ", userDiv=" + userDiv + ", toString()=" + super.toString() + "]";
	}

}
