package egovframework.example.sample.vo;

import java.util.Date;
import java.util.Objects;

public class BoardVoCopy {
	Integer bno;
	String writer;
	String title;
	String content;
	Date reg_date ;	
	int view_cnt;
	int isadmin;
	
	
	/*
	 * public BoardVo() {} public BoardVo(String writer, String title, String
	 * content) { this.writer = writer; this.title = title; this.content = content;
	 * }
	 */
	
	@Override
	public String toString() {
		return "BoardVo [bno=" + bno + ", writer=" + writer + ", title=" + title + ", content=" + content + ", reg_date="
				+ reg_date + ", view_cnt=" + view_cnt + ", isadmin=" + isadmin + "]";
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public int getView_cnt() {
		return view_cnt;
	}

	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	
	
	public int getIsadmin() {
		return isadmin;
	}
	public void setIsadmin(int isadmin) {
		this.isadmin = isadmin;
	}
	@Override
	public int hashCode() {
		return Objects.hash(bno, content, writer, reg_date, title, view_cnt);
	}
}
