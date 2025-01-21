package com.myspring.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.myspring.test.shop.Cart;

@Mapper
public interface CartMapper {
	public void addItemToCart(Cart cart);
	public List<Cart> getCartByUser(String buyer);
	public void updateCartItemCount(Cart cart);
	public void removeItemFromCart(int cart_number);
	
}
