package com.pcwk.ehr.board.domain;

public class BoardVO {
	private int bdSeq;
	private String nickName;
	private int category;
	private String title;
	private String contents;
	private int readCnt;
	private int recommendation;
	private String csnm;
	private String regDt;
	private String regIt;
	private String modDt;
	private String modId;
	
	public BoardVO() {}

	public BoardVO(int bdSeq, String nickName, int category, String title, String contents, int readCnt,
			int recommendation, String csnm, String regDt, String regIt, String modDt, String modId) {
		super();
		this.bdSeq = bdSeq;
		this.nickName = nickName;
		this.category = category;
		this.title = title;
		this.contents = contents;
		this.readCnt = readCnt;
		this.recommendation = recommendation;
		this.csnm = csnm;
		this.regDt = regDt;
		this.regIt = regIt;
		this.modDt = modDt;
		this.modId = modId;
	}

	public int getBdSeq() {
		return bdSeq;
	}

	public void setBdSeq(int bdSeq) {
		this.bdSeq = bdSeq;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}

	public int getRecommendation() {
		return recommendation;
	}

	public void setRecommendation(int recommendation) {
		this.recommendation = recommendation;
	}

	public String getCsnm() {
		return csnm;
	}

	public void setCsnm(String csnm) {
		this.csnm = csnm;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getRegIt() {
		return regIt;
	}

	public void setRegIt(String regIt) {
		this.regIt = regIt;
	}

	public String getModDt() {
		return modDt;
	}

	public void setModDt(String modDt) {
		this.modDt = modDt;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	@Override
	public String toString() {
		return "boardVO [bdSeq=" + bdSeq + ", nickName=" + nickName + ", category=" + category + ", title=" + title
				+ ", contents=" + contents + ", readCnt=" + readCnt + ", recommendation=" + recommendation + ", csnm="
				+ csnm + ", regDt=" + regDt + ", regIt=" + regIt + ", modDt=" + modDt + ", modId=" + modId + "]";
	}

}
