package kr.co.seoulit.account.operate.system.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import kr.co.seoulit.account.sys.common.util.BeanCreator;

import kr.co.seoulit.account.operate.system.service.SystemService;

import kr.co.seoulit.account.operate.system.to.BusinessBean;
import kr.co.seoulit.account.operate.system.to.DetailBusinessBean;
import kr.co.seoulit.account.operate.system.to.WorkplaceBean;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/operate")
public class CustomerController {

	@Autowired
	private SystemService systemService;

	 ModelAndView mav;
	 ModelMap map = new ModelMap();

	// 업태리스트조회
	@GetMapping("/businesslist")
	public ArrayList<BusinessBean> findBusinessList() {

		return systemService.findBusinessList();

	}
	 
	@PostMapping("/detailbusiness")
	public ArrayList<DetailBusinessBean> findDetailBusiness(@RequestBody String businessCode) {

		return systemService.findDetailBusiness(businessCode);
	

	}
	
	@PostMapping("/registerworkplace")
	public void registerworkPlace(@RequestBody WorkplaceBean workplaceBean) {
         
         systemService.registerWorkplace(workplaceBean); //insert

 }
    @GetMapping("/workplaceremoval")
    public void removeWorkplace(@RequestParam String codes) {
    	
    	ArrayList<String> getCodes=null;
     	getCodes=new ArrayList<>();

			JSONArray jsonArray=JSONArray.fromObject(codes);
			for(Object obj :jsonArray) {
				String code=(String)obj;
				getCodes.add(code);
			}
         
			systemService.removeWorkplace(getCodes); //delete

 }
    @PostMapping("/workplace")
	public WorkplaceBean findWorkplace(@RequestBody WorkplaceBean workplaceBean) {

//     WorkplaceBean  workplaceBean = new WorkplaceBean();

//     workplaceBean = systemService.findWorkplace(workplaceCode);

     return systemService.findWorkplace(workplaceBean.getWorkplaceCode());
 }
    
	@PostMapping("/allworkplacelist")
	public ArrayList<WorkplaceBean> findAllWorkplaceList() {

		return systemService.findAllWorkplaceList();

	}
	
	@GetMapping("/approvalstatusmodification")
	public void modifyApprovalStatus(@RequestParam String status,
											 @RequestParam String codes	) {
		
		ArrayList<String> getCodes=new ArrayList<>();

			JSONArray jsonArray=JSONArray.fromObject(codes);
			for(Object obj :jsonArray) {
				String code=(String)obj;
				getCodes.add(code);
			}
	
			systemService.modifyApprovalStatus(getCodes,status);

	}

}
