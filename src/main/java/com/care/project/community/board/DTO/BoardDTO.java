package com.care.project.community.board.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class BoardDTO {
	private int write_no, hit;
	private String id, title, content, imageFileName,saveDate;
	
	public int getWrite_no() {
		return write_no;
	}
	public void setWrite_no(int write_no) {
		this.write_no = write_no;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getSaveDate() {
		return saveDate;
	}
	public void setSaveDate(Timestamp saveDate) {
		SimpleDateFormat fo = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		this.saveDate = fo.format( saveDate );
	}
	
}
