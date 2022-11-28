package com.pcwk.ehr.board.cmn;

import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;

/**
 * 개발 환경에서는 메일 전송이 되지 않게 한다.
 * @author ITSC
 *
 */
public class DummyMailSender implements MailSender {

	@Override
	public void send(SimpleMailMessage simpleMessage) throws MailException {
		// TODO Auto-generated method stub

	}

	@Override
	public void send(SimpleMailMessage... simpleMessages) throws MailException {
		// TODO Auto-generated method stub

	}

}
