package com.myspring.test.board;

import lombok.Data;

@Data
public class Board {
	private int num;
	private String writer;
	private String subject;
	private String content;
	private String reg_date;
	private int readcount;
	private int ref;
	private int re_step;
	private int re_level;
}
