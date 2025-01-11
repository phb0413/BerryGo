package com.myspring.test.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.myspring.test.board.BoardImage;

@Mapper
public interface BoardImageMapper {
	public int insertBoardImage(Map<String, Object> data);
	
	public ArrayList<BoardImage> getBoardImageList(Map<String, Object> data);
}
