package com.myspring.test.shop;

import lombok.Data;

@Data
public class OrderMenu {
	private int order_number;
	private int order_deliverynumber;
	private int order_fruitnumber;
	private int order_buycount;
	private String order_buyer;
}
