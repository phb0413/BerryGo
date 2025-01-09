package com.myspring.test.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.myspring.test.shop.Item;

@Mapper
public interface ItemMapper {
	
	public ArrayList<Item> getItemList();
	public Item getItem(int itemNumber);
}
