package com.pcwk.ehr.user.domain;

public class UserVO {
	private int mSeq; // 순번
	private String userId; // 아이디
	private String nickname; // 닉네임
	private String userPw; // 비밀번호
	private String name; // 이름
	private String birth; // 생년월일
	private String email; // 이메일
	private String backupQusetion; // 복구용질문
	private String backupAnswer; // 복구용답변
	private int point; // 등급용 포인트
	private String joinDate; // 가입일
	private int status; // 상태(회원/비활성화/관리자)

	public UserVO() {};

	/**
	 * 필수정보 4개만 넣고 만드는 생성자. 순서대로 아이디, 닉네임, 비밀번호, 이름
	 * 
	 * @param userId
	 * @param nickname
	 * @param userPw
	 * @param name
	 */
	public UserVO(String userId, String nickname, String userPw, String name) {
		super();
		this.userId = userId;
		this.nickname = nickname;
		this.userPw = userPw;
		this.name = name;
		this.email = "";
		this.birth = "";
		this.backupQusetion = "";
		this.backupAnswer = "";
		/*this.point = 0;
		this.joinDate = "";
		this.status = 1;*/
	}

	public UserVO(int mSeq, String userId, String nickname, String userPw, String name, String birth, String email,
			String backupQusetion, String backupAnswer, int point, String joinDate, int status) {
		super();
		this.mSeq = mSeq;
		this.userId = userId;
		this.nickname = nickname;
		this.userPw = userPw;
		this.name = name;
		this.birth = birth;
		this.email = email;
		this.backupQusetion = backupQusetion;
		this.backupAnswer = backupAnswer;
		this.point = point;
		this.joinDate = joinDate;
		this.status = status;
	}

	public int getMemberSeq() {
		return mSeq;
	}

	public void setMemberSeq(int mSeq) {
		this.mSeq = mSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBackupQusetion() {
		return backupQusetion;
	}

	public void setBackupQusetion(String backupQusetion) {
		this.backupQusetion = backupQusetion;
	}

	public String getBackupAnswer() {
		return backupAnswer;
	}

	public void setBackupAnswer(String backupAnswer) {
		this.backupAnswer = backupAnswer;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "UserVO [mSeq=" + mSeq + ", userId=" + userId + ", nickname=" + nickname + ", userPw=" + userPw
				+ ", name=" + name + ", birth=" + birth + ", email=" + email + ", backupQusetion=" + backupQusetion
				+ ", backupAnswer=" + backupAnswer + ", point=" + point + ", joinDate=" + joinDate + ", status="
				+ status + "]";
	}

}
