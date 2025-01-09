package com.myspring.test.shop;

import lombok.Data;

@Data	// Lombok API
public class Item {
	private int item_number;
	private String item_category;
	private String item_name;
	private int item_price;
	private int item_stock;
	private String item_image;
	private String item_info;
	private int item_discount;
}
