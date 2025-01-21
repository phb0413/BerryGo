package com.myspring.test.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.myspring.test.board.Board;

@Mapper
public interface BoardMapper {
	public int getAllCount();
	public ArrayList<Board> getAllBoard(Map<String, Object> data);
	public Board getOneBoard(Map<String, Object> data);
	public int getMaxRef();
	public int insertBoard(Map<String, Object> data);
	public int getLastBoardNumber();
	public void updateBoardReadCount(int num);
	public void updateBoard(Board board);
	public void boardDelete(int num);
	public void updateReBoard(Board board);
	public void reWriteBoard(Board board);
}
