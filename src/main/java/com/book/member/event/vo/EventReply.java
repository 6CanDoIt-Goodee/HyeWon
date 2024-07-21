package com.book.member.event.vo;

import java.time.LocalDateTime;

public class EventReply {
	private int ev_reply_no;
	private int ev_parent_no;
	private int event_no;
	private int user_no;
	private String ev_reply_content;
	private LocalDateTime ev_reg_date;
	private LocalDateTime ev_mod_date;
	private int is_deleted;
	
	public EventReply() {
		super();
	}

	public EventReply(int ev_reply_no, int ev_parent_no, int event_no, int user_no, String ev_reply_content,
			LocalDateTime ev_reg_date, LocalDateTime ev_mod_date, int is_deleted) {
		super();
		this.ev_reply_no = ev_reply_no;
		this.ev_parent_no = ev_parent_no;
		this.event_no = event_no;
		this.user_no = user_no;
		this.ev_reply_content = ev_reply_content;
		this.ev_reg_date = ev_reg_date;
		this.ev_mod_date = ev_mod_date;
		this.is_deleted = is_deleted;
	}

	public int getEv_reply_no() {
		return ev_reply_no;
	}

	public void setEv_reply_no(int ev_reply_no) {
		this.ev_reply_no = ev_reply_no;
	}

	public int getEv_parent_no() {
		return ev_parent_no;
	}

	public void setEv_parent_no(int ev_parent_no) {
		this.ev_parent_no = ev_parent_no;
	}

	public int getEvent_no() {
		return event_no;
	}

	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getEv_reply_content() {
		return ev_reply_content;
	}

	public void setEv_reply_content(String ev_reply_content) {
		this.ev_reply_content = ev_reply_content;
	}

	public LocalDateTime getEv_reg_date() {
		return ev_reg_date;
	}

	public void setEv_reg_date(LocalDateTime ev_reg_date) {
		this.ev_reg_date = ev_reg_date;
	}

	public LocalDateTime getEv_mod_date() {
		return ev_mod_date;
	}

	public void setEv_mod_date(LocalDateTime ev_mod_date) {
		this.ev_mod_date = ev_mod_date;
	}

	public int getIs_deleted() {
		return is_deleted;
	}

	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}

	@Override
	public String toString() {
		return ev_reply_no + " || " + ev_parent_no + " || " + event_no
				+ " || " + user_no + " || " + ev_reply_content + " || " + ev_reg_date
				+ " || " + ev_mod_date + " || " + is_deleted;
	}
	
	
	
}
