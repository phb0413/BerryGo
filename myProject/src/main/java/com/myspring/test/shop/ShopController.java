package com.myspring.test.shop;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myspring.test.mapper.ItemMapper;

@RequestMapping("/shop")
@Controller
public class ShopController {
	@Autowired
	private ItemMapper mapper;
	
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
}
