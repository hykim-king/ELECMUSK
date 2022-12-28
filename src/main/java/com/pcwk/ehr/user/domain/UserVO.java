package com.pcwk.ehr.user.domain;

import com.pcwk.ehr.cmn.DTO;

public class UserVO extends DTO {
	private int mSeq; // 순번
	private String userId; // 아이디
	private String nickname; // 닉네임
	private String userPw; // 비밀번호
	private String name; // 이름
	private String birth; // 생년월일
	private String email; // 이메일
	private String backupQuestion; // 복구용질문
	private String backupAnswer; // 복구용답변
	private int point; // 등급용 포인트
	private String joinDate; // 가입일
	private int status; // 상태(회원/비활성화/관리자)
	private String lastLogin;// 마지막 로그인(포인트 용)
	private String lastPost;// 마지막 글쓰기(포인트 용)

	public UserVO() {
	}

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
		this.birth = "";
		this.email = "";
		this.backupQuestion = "";
		this.backupAnswer = "";
		this.point = 0;
		this.status = 1;
		this.lastLogin = "";
		this.lastPost = "";
	}

	public UserVO(int mSeq, String userId, String nickname, String userPw, String name, String birth, String email,
			String backupQuestion, String backupAnswer, int point, String joinDate, int status, String lastLogin,
			String lastPost) {
		super();
		this.mSeq = mSeq;
		this.userId = userId;
		this.nickname = nickname;
		this.userPw = userPw;
		this.name = name;
		this.birth = birth;
		this.email = email;
		this.backupQuestion = backupQuestion;
		this.backupAnswer = backupAnswer;
		this.point = point;
		this.joinDate = joinDate;
		this.status = status;
		this.lastLogin = lastLogin;
		this.lastPost = lastPost;
	}

	public int getmSeq() {
		return mSeq;
	}

	public void setmSeq(int mSeq) {
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

	public String getBackupQuestion() {
		return backupQuestion;
	}

	public void setBackupQuestion(String backupQuestion) {
		this.backupQuestion = backupQuestion;
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

	public String getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(String lastLogin) {
		this.lastLogin = lastLogin;
	}

	public String getLastPost() {
		return lastPost;
	}

	public void setLastPost(String lastPost) {
		this.lastPost = lastPost;
	}

	@Override
	public String toString() {
		return "UserVO [mSeq=" + mSeq + ", userId=" + userId + ", nickname=" + nickname + ", userPw=" + userPw
				+ ", name=" + name + ", birth=" + birth + ", email=" + email + ", backupQuestion=" + backupQuestion
				+ ", backupAnswer=" + backupAnswer + ", point=" + point + ", joinDate=" + joinDate + ", status="
				+ status + ", lastLogin=" + lastLogin + ", lastPost=" + lastPost + ", toString()=" + super.toString()
				+ "]";
	}

}