package com.myspring.test.shop;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myspring.test.mapper.CartMapper;
import com.myspring.test.mapper.ItemMapper;

@RequestMapping("/shop")
@Controller
public class ShopController {
	@Autowired
	private ItemMapper mapper;
	
	@Autowired
	private CartMapper cart_mapper;
	
	@GetMapping(value="/itemList.do")
	public String itemList(Model model) {
		ArrayList<Item> itemList = mapper.getItemList();
		model.addAttribute("itemList", itemList);
		
		return "shop/itemList";
	}
	
	@GetMapping(value="/itemInfo.do")
	public String itemInfo(HttpServletRequest request, Model model) {
		int itemNumber = Integer.parseInt(request.getParameter("itemNumber"));
		
		System.out.println("itemInfo.do");
		 System.out.println("itemNumber = " + itemNumber);
		 
		 Item item = mapper.getItem(itemNumber);
		 model.addAttribute("item", item);
		 
		 return "shop/itemInfo";
	}
	
	@GetMapping(value="/cartList.do")
	public String cartList(HttpServletRequest request, Model model) {
		
		String buyer = request.getParameter("buyer");
		List<Cart> cartList = cart_mapper.getCartByUser(buyer);
		
		model.addAttribute(cartList);
		return "shop/cartList";
	}
	
	@PostMapping(value="/addCartPro.do")
	public ResponseEntity<String> addItemToCart(@RequestParam("itemNumber") int itemNumber, @RequestParam("buyCount") int buyCount, @RequestParam("log") String log) {
		try {
			Cart cart = new Cart();
			cart.setCart_fruitnumber(itemNumber);
			cart.setCart_buyer(log);
			cart.setCart_buycount(buyCount);
			
			cart_mapper.addItemToCart(cart);
			return ResponseEntity.ok("<p id='check'>-1</p>");
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.ok("<p id='check'>0</p>");
		}
	}
	
	
}
