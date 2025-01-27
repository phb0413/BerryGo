package com.myspring.test.shop;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myspring.test.mapper.CartMapper;
import com.myspring.test.mapper.DeliveryMapper;
import com.myspring.test.mapper.ItemMapper;
import com.myspring.test.mapper.OrderMenuMapper;

@RequestMapping("/shop")
@Controller
public class ShopController {
	@Autowired
	private ItemMapper mapper;
	
	@Autowired
	private CartMapper cart_mapper;
	
	@Autowired
	private OrderMenuMapper ordermapper;
	
	@Autowired
	private DeliveryMapper deliverymapper;
	
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
	
	@GetMapping("/cartList.do")
    public String cartList(HttpServletRequest request, Model model) {
		String buyer = (String) request.getSession().getAttribute("log");
        List<Cart> cartList = cart_mapper.getCartByUser(buyer);
        model.addAttribute("cartList", cartList);
        return "shop/cartList";
    }
	
	@PostMapping("/addCartPro.do")
	public ResponseEntity<String> addItemToCart(@RequestBody Map<String, Object> payload) {
	    try {
	    	// JSON 데이터를 객체로 변환
	        String itemNumberStr = (String) payload.get("itemNumber");
	        String buyCountStr = (String) payload.get("buyCount");
	        String log = (String) payload.get("log");
	        String itemName = (String) payload.get("itemName");
	        String itemPriceStr = (String) payload.get("itemPrice");
	        String itemImg = (String) payload.get("itemImg");

	        // itemNumber와 buyCount 값을 String에서 int로 변환
	        int itemNumber = Integer.parseInt(itemNumberStr); // String -> int 변환
	        int buyCount = Integer.parseInt(buyCountStr); // String -> int 변환
	        int itemPrice = Integer.parseInt(itemPriceStr);

	        System.out.println("AJAX 요청 도착: itemNumber=" + itemNumber + ", buyCount=" + buyCount + ", log=" + log + ", itemName=" + itemName + ",itemPrice=" + itemPrice + ",itemImg=" + itemImg);

	        if (log == null || log.trim().isEmpty()) {
	            return ResponseEntity.badRequest().body("<p id='check'>0</p>"); // 로그인 정보 누락
	        }

	        // 장바구니에 아이템 추가
	        Cart cart = new Cart();
	        cart.setCart_fruitnumber(itemNumber);
	        cart.setCart_buyer(log);
	        cart.setCart_buycount(buyCount);
	        cart.setItem_name(itemName);
	        cart.setItem_price(itemPrice);
	        cart.setItem_image(itemImg);
	        
	        Cart existingCart = cart_mapper.getCartItem(cart);

	        if (existingCart != null) {
	            // 이미 존재하는 상품 -> 수량 업데이트
	            cart_mapper.updateCartItemCount(cart);
	        } else {
	            // 새 상품 -> 삽입
	            cart_mapper.addItemToCart(cart);
	        }
	        return ResponseEntity.ok("<p id='check'>-1</p>"); // 성공 응답
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.badRequest().body("<p id='check'>0</p>"); // 실패 응답
	    }
	}
	
	@PostMapping("/removeCartItem.do")
	public ResponseEntity<String> removeCartItem(@RequestParam("cart_number") int cart_number) {
	    try {
	        System.out.println("삭제 요청 도착: cart_number=" + cart_number);
	        
	        cart_mapper.removeItemFromCart(cart_number);
	        return ResponseEntity.ok("success"); // 성공 응답
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(500).body("error"); // 오류 응답
	    }
	}
	
	@GetMapping(value="/addOrder.do")
	public String addOrder(HttpServletRequest request, Model model) {
	    String buyer = (String) request.getSession().getAttribute("log");
	    List<Cart> cartList = cart_mapper.getCartByUser(buyer);
        model.addAttribute("cartList", cartList);
	    return "shop/addOrder";
	}
	
	@PostMapping(value="/addOrderPro.do")
	@Transactional
	public ResponseEntity<String> processOrder(@RequestBody Map<String, Object> payload) {
		String buyer = (String) payload.get("buyer");
		String tel = (String) payload.get("tel");
		String addr = (String) payload.get("addr");
		try {
			
			System.out.println("buyer 값 확인: " + buyer);
	        if (buyer == null || buyer.trim().isEmpty()) {
	            throw new RuntimeException("로그인 정보가 없습니다.");
	        }
	        
			List<Cart> cartList = cart_mapper.getCartByUser(buyer);
			 if (cartList == null || cartList.isEmpty()) {
	                throw new RuntimeException("장바구니가 비어 있습니다.");
	         }
	        System.out.println("장바구니 데이터: " + cartList);
			
			Delivery delivery = new Delivery();
			delivery.setDelivery_name(buyer);
			delivery.setDelivery_addr(addr);
			delivery.setDelivery_tel(tel);
			deliverymapper.insertDelivery(delivery);
			
			if (delivery.getDelivery_number() == 0) {
                throw new RuntimeException("배송 데이터 저장 실패");
            }
            System.out.println("배송 번호: " + delivery.getDelivery_number());

			
			for(Cart cart : cartList) {
				
				System.out.println("Cart 데이터: " + cart);
			    System.out.println("Cart fruitnumber: " + cart.getCart_fruitnumber());
			    
				OrderMenu order = new OrderMenu();
				order.setOrder_deliverynumber(delivery.getDelivery_number());
				order.setOrder_fruitnumber(cart.getCart_fruitnumber());
				order.setOrder_buycount(cart.getCart_buycount());
				order.setOrder_buyer(buyer);
				
			    System.out.println("주문 데이터: " + order);
			    
			    try {
			        ordermapper.insertOrder(order);
			        System.out.println("주문 저장 완료: " + order);
			    } catch (Exception e) {
			        e.printStackTrace();
			        throw new RuntimeException("주문 저장 중 오류 발생: " + e.getMessage());
			    }
			}
			
			cart_mapper.deleteCartItems(buyer);
			 System.out.println("장바구니 데이터 삭제 완료");
			return ResponseEntity.ok("Order processed successfully");
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(500).body("Failed to process order");
		}
		
	}
	
	@GetMapping(value="/orderList.do")
	public String orderList(HttpServletRequest request, Model model) {
		String buyer = (String) request.getSession().getAttribute("log");
		System.out.println("buyer = " + buyer);
		
		if(buyer==null || buyer.trim().isEmpty()) {
			throw new RuntimeException("로그인 정보가 없습니다.");
		}
		
		List<OrderMenu> orderList = ordermapper.getOrderListByBuyer(buyer);
		 if (orderList == null || orderList.isEmpty()) {
             throw new RuntimeException("주문목록이 비어 있습니다.");
		 }
		model.addAttribute("orderList", orderList);
		return "shop/orderList";
	}
	
	
}
