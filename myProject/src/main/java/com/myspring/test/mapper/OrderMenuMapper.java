package com.myspring.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.myspring.test.shop.OrderMenu;

@Mapper
public interface OrderMenuMapper {
	public void insertOrder(OrderMenu orderMenu);
}
