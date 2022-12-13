package com.pcwk.ehr.evcar.cmn;

public class evMessageVO extends evDTO {

	private String msgId;//메시지 ID
	private String msgContents;//메시지
	
	public evMessageVO() {}

	public evMessageVO(String msgId, String msgContents) {
		super();
		this.msgId = msgId;
		this.msgContents = msgContents;
	}

	public String getMsgId() {
		return msgId;
	}

	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}

	public String getMsgContents() {
		return msgContents;
	}

	public void setMsgContents(String msgContents) {
		this.msgContents = msgContents;
	}

	@Override
	public String toString() {
		return "MessageVO [msgId=" + msgId + ", msgContents=" + msgContents + "]";
	}
	
	
}
