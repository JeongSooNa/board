package com.dw.board.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


/**
 * @author 21
 * @crate-date 220616 comment excel download contoller
 */
@Controller // excel을 json으로 할 수 없으니
public class ExcelController {


	// 사진 파일 등등 다운받는건 리턴타입이 없음 = void or ResponseEntity response라는 객체가 있음
	// 페이지 이름으로 리턴하면 안됨!
	@GetMapping("/excel")
	public void downloadExcelFile(HttpServletResponse response) throws Exception {
		String today = new SimpleDateFormat("yyMMdd").format(new Date());
		String title = "DW아카데미_게시판";

		response.setContentType("ms-vnd/excel"); // 엑셀파일을 보내겠다

		response.getOutputStream().flush();
		response.getOutputStream().close();

	}
}