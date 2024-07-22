package com.book.admin.sg.vo;

public class SuggestionReply {
	private int sg_reply_no;
	private int sg_no;
	private int user_no;
	private String sg_reply_content;
	
	public SuggestionReply() {
		super();
	}

	public SuggestionReply(int sg_reply_no, int sg_no, int user_no, String sg_reply_content) {
		super();
		this.sg_reply_no = sg_reply_no;
		this.sg_no = sg_no;
		this.user_no = user_no;
		this.sg_reply_content = sg_reply_content;
	}

	public int getSg_reply_no() {
		return sg_reply_no;
	}

	public void setSg_reply_no(int sg_reply_no) {
		this.sg_reply_no = sg_reply_no;
	}

	public int getSg_no() {
		return sg_no;
	}

	public void setSg_no(int sg_no) {
		this.sg_no = sg_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getSg_reply_content() {
		return sg_reply_content;
	}

	public void setSg_reply_content(String sg_reply_content) {
		this.sg_reply_content = sg_reply_content;
	}

	@Override
	public String toString() {
		return sg_reply_no + " || " + sg_no + " || " + user_no
				+ " || " + sg_reply_content;
	}
	
	
	
}
