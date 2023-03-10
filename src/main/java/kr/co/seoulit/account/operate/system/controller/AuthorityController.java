package kr.co.seoulit.account.operate.system.controller;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONObject;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.co.seoulit.account.sys.common.exception.DataAccessException;
import kr.co.seoulit.account.operate.system.service.SystemService;

import kr.co.seoulit.account.operate.system.to.AuthorityEmpBean;
import kr.co.seoulit.account.operate.system.to.AuthorityMenuBean;

@RestController
@RequestMapping("/operate")
public class AuthorityController {

	@Autowired
	private SystemService systemService;

	@PostMapping("/authorityemp")
    public ArrayList<AuthorityEmpBean> findAuthorityEmp(@RequestBody AuthorityEmpBean authorityEmpBean) {

        return systemService.findAuthorityEmp(authorityEmpBean.getDeptCode());
    }
	
	@GetMapping("/authoritygroupmodification")
    public void modifyAuthorityGroup(@RequestParam String authority,
    								 @RequestParam String deptCode) {
        
        	Gson gson = new Gson();
			ArrayList<AuthorityEmpBean> authorityEmpBean = gson.fromJson(authority,
					new TypeToken<ArrayList<AuthorityEmpBean>>() {
					}.getType());
        	
			systemService.modifyAuthorityGroup(authorityEmpBean , deptCode);

 
    }
	@GetMapping("/authoritygroupcode")
    public ArrayList<AuthorityEmpBean> findAuthorityGroupCode() {
		return systemService.findAuthorityGroupCode();
    }

	@GetMapping("/additionauthoritygroup")
    public void addAuthorityGroup(@RequestParam String addAuthority,
			 							  @RequestParam String nextGroupCode) {
       
        	
		systemService.addAuthorityGroup(addAuthority,nextGroupCode);
             
        
    }

	@GetMapping("/authoritygroupremoval")
    public void removeAuthorityGroup(@RequestParam String groupCode) {
       
        	
		systemService.removeAuthorityGroup(groupCode);

    }
	@GetMapping("/authoritygroup")
    public ArrayList<AuthorityMenuBean> findAuthorityGroup() {

		return systemService.findAuthorityGroup();
    }

	@PostMapping("/authoritymenu")
    public ArrayList<AuthorityMenuBean> findAuthorityMenu(@RequestBody AuthorityMenuBean authorityMenuBean) {

		return systemService.findAuthorityMenu(authorityMenuBean.getMenuName());
    }

	@GetMapping("/authoritymenumodification")
    public void modifyAuthorityMenu(@RequestParam String authority,@RequestParam String deptCode) {
        
  
        	Gson gson = new Gson();
			ArrayList<AuthorityMenuBean> authorityMenuBean = gson.fromJson(authority,
					new TypeToken<ArrayList<AuthorityMenuBean>>() {
					}.getType());
        	
            	
			systemService.modifyAuthorityMenu(authorityMenuBean , deptCode);
       
    }
}
