package com.myspring.test.board;

import lombok.Data;

@Data
public class Board {
	private int board_number;
	private String board_writer;
	private String board_subject;
	private String board_content;
	private String board_date;
	private int board_readcount;
	private int board_ref;
	private int board_step;
	private int board_level;
}
