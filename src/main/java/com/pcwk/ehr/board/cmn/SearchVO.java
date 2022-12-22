package com.pcwk.ehr.board.cmn;

public class SearchVO extends DTO {
	
	private int pageSize;//페이즈 사이즈(default = 10)
	private int pageNo;//페이지 번호(default = 1)
	private String searchDiv;//검색구분(default = "")
	private String searchWord;//검색어(default = "")
	
	private String category;//카테고리
	
	public SearchVO() {}



	public SearchVO(int pageSize, int pageNo, String searchDiv, String searchWord, String category) {
		super();
		this.pageSize = pageSize;
		this.pageNo = pageNo;
		this.searchDiv = searchDiv;
		this.searchWord = searchWord;
		this.category = category;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
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


	@Override
	public String toString() {
		return "SearchVO [pageSize=" + pageSize + ", pageNo=" + pageNo + ", searchDiv=" + searchDiv + ", searchWord="
				+ searchWord + ", category=" + category + ", toString()=" + super.toString() + "]";
	}


	
}
