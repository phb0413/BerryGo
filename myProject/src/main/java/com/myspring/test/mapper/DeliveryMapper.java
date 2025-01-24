package com.myspring.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.myspring.test.shop.Delivery;

@Mapper
public interface DeliveryMapper {
	public void insertDelivery(Delivery delivery);
}
