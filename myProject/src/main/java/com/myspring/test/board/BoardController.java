package com.myspring.test.board;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.myspring.test.mapper.BoardImageMapper;
import com.myspring.test.mapper.BoardMapper;

@RequestMapping("/board")
@Controller
public class BoardController {
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private BoardImageMapper imageMapper;
	
	@GetMapping(value="/boardList.do")
	public String boardList(HttpServletRequest request, Model model) {
		int allArticlesCount = mapper.getAllCount(); // 전체 게시글 수
		int onePageArticlesCount = 10; // 한 페이지 보여줄 게시글 수
		int currentPageNumber = 1; // 현재 페이지 번호
		if(request.getParameter("currentPageNumber") != null) {
			currentPageNumber = Integer.parseInt(request.getParameter("currentPageNumber"));
		}
		
		int startRow = (currentPageNumber - 1) * onePageArticlesCount; // 게시글 시작 번호
		int number = allArticlesCount - startRow; // 게시글 번호
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("pageSize", onePageArticlesCount);
		
		ArrayList<Board> boardList = mapper.getAllBoard(map);
		
		int clickablePageCount = 5; // 페이지 번호 개수
		int allPageCount = allArticlesCount / onePageArticlesCount;
		
		if(allArticlesCount % onePageArticlesCount != 0) allPageCount += 1;
		
		int startPageNum = 1;
		if(currentPageNumber % clickablePageCount != 0) {
			startPageNum = (currentPageNumber / clickablePageCount) * clickablePageCount + 1;
		} else {
			startPageNum = (currentPageNumber / clickablePageCount - 1) * clickablePageCount + 1;
		}
		
		int endPageNum = startPageNum + clickablePageCount - 1;
		if(endPageNum > allPageCount) {
			endPageNum = allPageCount;
		}
		
		model.addAttribute("allArticlesCount", allArticlesCount);
		model.addAttribute("onePageArticlesCount", onePageArticlesCount);
		model.addAttribute("number", number);
		model.addAttribute("boardList", boardList);
		model.addAttribute("clickablePageCount", clickablePageCount);
		model.addAttribute("allPageCount", allPageCount);
		model.addAttribute("startPageNum", startPageNum);
		model.addAttribute("endPageNum", endPageNum);
		return "board/boardList";
	}
	
	@GetMapping(value="/boardInfo.do")
	public String boardInfo(HttpServletRequest request, Model model) {
		int num = Integer.parseInt(request.getParameter("num"));
		mapper.updateBoardReadCount(num);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		
		Board board = mapper.getOneBoard(map);
		model.addAttribute("board", board);
		
		ArrayList<BoardImage> boardImageList = imageMapper.getBoardImageList(map);
		model.addAttribute("boardImageList", boardImageList);
		
		return "board/boardInfo";
	}
	
	@GetMapping(value = "/boardWriteForm.do")
	public String boardWriteForm() {
		
		System.out.println("boardWriteForm");
		
		return "board/boardWriteForm";
	}
	
	@ResponseBody
	@PostMapping(value = "/boardWritePro.do")
	public int boardWritePro(MultipartHttpServletRequest mRequest) throws Exception {
		
		// mRequest는 별도의 한글 인코딩 처리가 필요하며, 예외처리도 함께 적용해야 한다.
		mRequest.setCharacterEncoding("UTF-8");
		System.out.println("boardWritePro");
		
		ServletContext context = mRequest.getSession().getServletContext();
		String saveFolder = "/resources/upload/";
		String uploadPath = context.getRealPath(saveFolder);
		System.out.println("uploadPath =" + uploadPath);
		
		Enumeration<String> keyList = mRequest.getParameterNames();
		Map<String, Object> mapList = new HashMap<String, Object>();
		
		while(keyList.hasMoreElements()) {
			String key = keyList.nextElement();
			System.out.println("key = " + key);
			
			String value = mRequest.getParameter(key);
			System.out.println("value = " + value);
			
			mapList.put(key, value);
		}
		
		mapList.put("readcount", 0);
		
		int maxBoardRef = mapper.getMaxRef();
		mapList.put("ref", maxBoardRef + 1);
		
		int check = mapper.insertBoard(mapList);
		
		if(check == 1) {
			int boardNumber = mapper.getLastBoardNumber();
			
			// # getFileNames() : form태그에서 type=file로 지정한 태그의 name값 불러오기
			Iterator<String> iterator = mRequest.getFileNames();
			
			while(iterator.hasNext()) {
				Map<String, Object> imageMapList = new HashMap<String, Object>();
				
				imageMapList.put("boardNumber", boardNumber);
				
				String fileName = iterator.next();
				
				System.out.println("fileName = " + fileName);
				
				MultipartFile mFile = mRequest.getFile(fileName);
				String originFileName = mFile.getOriginalFilename();
				
				System.out.println("originFileName = " + originFileName);
				
				String saveFileName = originFileName;
				
				if(saveFileName != null && !saveFileName.equals("")) {
					// 그 파일의 이름이 기존에 있던 파일들과 이름이 중복되면
					if(new File(uploadPath + saveFileName).exists()) {
						// 파일명 뒤에 _시간을 붙여 이름을 업뎃
						saveFileName = saveFileName + "_"+System.currentTimeMillis();
					}
					
					try {
						// 파일 업로드
						mFile.transferTo(new File(uploadPath+saveFileName));
						
						System.out.println("saveFileName = " + uploadPath+saveFileName);
						
						imageMapList.put("fileName", saveFileName);
						imageMapper.insertBoardImage(imageMapList);
					} catch(Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		return check;
	}
	
	@GetMapping(value="/boardUpdateForm.do")
	public String boardUpdateFrom(HttpServletRequest request, Model model) {
		int num = Integer.parseInt(request.getParameter("num"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		
		Board board = mapper.getOneBoard(map);
		model.addAttribute(board);
		return "board/boardUpdateForm";
	}
	
	@PostMapping(value="/boardUpdatePro.do")
	public String boardUpdatePro(Board board, HttpServletRequest request) {
		mapper.updateBoard(board);
		return "redirect:boardList.do";
	}
	
	@GetMapping(value="/boardReWriteForm.do")
	public String boardReWriteForm(HttpServletRequest request, Model model) {
		int num = Integer.parseInt(request.getParameter("num"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		
		Board board = mapper.getOneBoard(map);
		int ref = board.getRef();
		int re_step = board.getRe_step();
		int re_level = board.getRe_level();
		
		model.addAttribute("ref", ref);
		model.addAttribute("re_step", re_step);
		model.addAttribute("re_level", re_level);
		
		return "board/boardRewriteForm";
	}
	
	@PostMapping(value="/boardReWritePro.do")
	public String boardReWritePro(Board board) {
		mapper.updateReBoard(board);
		mapper.reWriteBoard(board);
		
		return "redirect:boardList.do";
	}
	
	@GetMapping(value="/boardDelete.do")
	public String boardDelete(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		mapper.boardDelete(num);
		return "redirect:boardList.do";
	}
	
}
