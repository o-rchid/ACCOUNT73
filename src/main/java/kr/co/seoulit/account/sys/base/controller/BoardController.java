package kr.co.seoulit.account.sys.base.controller;

import kr.co.seoulit.account.sys.base.service.BaseService;
import kr.co.seoulit.account.sys.base.to.BoardBean;
import kr.co.seoulit.account.sys.base.to.BoardFIleBean;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.net.URLEncoder;
import java.util.*;

@RestController
@RequestMapping("/base")
public class BoardController {
	@Autowired
	private BaseService baseService;

	@GetMapping("/boardlist")
	public ArrayList<BoardBean> findParentboardList() {
		System.out.println("컨트롤러 호출@@@@@@@@@@@@@@");
		return baseService.findParentboardList();
	}

	@PostMapping("/boardDetailList")
	public ArrayList<BoardBean> findDetailBoardList(@RequestBody BoardBean boardBean) throws Exception {

		baseService.updateLookup(boardBean.getId());

		return baseService.findDetailboardList(boardBean.getId());
	}
	@PostMapping("/boardDetailList1")
	public ArrayList<BoardBean> findDetailBoardList1(@RequestBody BoardBean boardBean) throws Exception {

		baseService.updateLookup(boardBean.getId());

		return baseService.findDetailboardList1(boardBean.getId());
	}
	@PostMapping("/boardreplyList")
	public ArrayList<BoardBean> boardRelpyList(@RequestBody BoardBean boardBean) {

		ArrayList<BoardBean> replybean = baseService.showreply(boardBean.getId());

		return   replybean;
	}
	@PostMapping("/boardDelete")
	public void deleteBoard(@RequestBody BoardBean boardBean) {

		baseService.deleteBoard(boardBean.getId());
	}

	@PostMapping("/boardreg")
	public ModelAndView insertData(
			BoardBean boardBean
			,MultipartHttpServletRequest multipartHttpServletRequest
			,HttpServletRequest request)throws Exception {

		System.out.println("찾아라요");
		System.out.println(boardBean.getTitle());
		System.out.println(boardBean.getWrittenBy());
		System.out.println(boardBean.getContents());

		ModelAndView mav=new ModelAndView("redirect:/base/board");


		if(ObjectUtils.isEmpty(multipartHttpServletRequest)){
			System.out.println("empty");

			baseService.insertBoard(boardBean);

			return mav;
		}else {

			baseService.insertBoard(boardBean);

			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

			String fileUrl = request.getServletContext().getRealPath("/") + "assets\\uploadFiles\\";

			System.out.println("iterator++++++++++++++++++++++" + iterator.hasNext());
			while (iterator.hasNext()) {
				List<MultipartFile> list = multipartHttpServletRequest.getFiles(iterator.next());
				for (MultipartFile multipartFile : list) {
					String filename = multipartFile.getOriginalFilename();
					String fileNameExtension = FilenameUtils.getExtension(filename).toLowerCase();
					File destinationFile;
					String destnationFileName;

					destnationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + fileNameExtension;
					destinationFile = new File(fileUrl + destnationFileName);

					destinationFile.getParentFile().mkdirs();
					multipartFile.transferTo(destinationFile);

					BoardFIleBean boardFileBean = new BoardFIleBean();

					boardFileBean.setBoardId(boardBean.getBoardId());
					boardFileBean.setFileName(destnationFileName);
					boardFileBean.setFileOriName(filename);
					boardFileBean.setFileUrl(fileUrl);

					baseService.fileInsert(boardFileBean);
				}
			}
		}

		return mav;

	}

	@PostMapping("/boardModify")
	public ModelAndView boardModify(
			BoardBean boardBean) {

		ModelAndView mav=new ModelAndView("redirect:/base/board");

		System.out.println("@@글번호"+boardBean.getId()+"@@@제목:"+boardBean.getTitle()+"@@@내용 :"+boardBean.getContents()+"@@@@@@@@@@@@@");
		baseService.boardModify(boardBean);
		return mav;
	}

	@PostMapping("/board_re_insert")
	public Map<String, Object> insertreply(
			BoardBean boardBean) {
		HashMap<String, Object> map = new HashMap<>();

		map.put("Msg","성공ㅎㅎ");

		baseService.insertReBoard(boardBean);

		return map;
	}

	@PostMapping("/replyDelete")
	public void redeleteBoard(@RequestBody BoardBean boardBean) {
		baseService.deletereBoard(boardBean.getRid());

	}
	@PostMapping("/board_re_modify")
	public void boardReModify(@RequestBody BoardBean boardBean) {

		baseService.boardReModify(boardBean);

	}

	@GetMapping("/downloadFile")
	public HttpServletResponse fileDown(
			@RequestBody BoardBean boardBean
			 , HttpServletRequest request
			, HttpServletResponse response) throws Exception {


		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File(request.getServletContext().getRealPath("/")+"assets/uploadFiles/" + boardBean.getFileName()));

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(boardBean.getFileName(), "UTF-8") + "\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();

		return response;
	}

}
