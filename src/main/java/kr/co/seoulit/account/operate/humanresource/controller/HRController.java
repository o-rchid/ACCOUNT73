package kr.co.seoulit.account.operate.humanresource.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import kr.co.seoulit.account.operate.humanresource.service.HumanResourceService;

import kr.co.seoulit.account.operate.humanresource.to.DepartmentBean;
import kr.co.seoulit.account.operate.humanresource.to.EmployeeBean;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("/operate")
public class HRController {

    @Autowired
    private HumanResourceService humanResourceService;

    ModelAndView mav;
    ModelMap map = new ModelMap();
    
    @PostMapping("/employeelist")
	public ArrayList<EmployeeBean> findEmployeeList(@RequestBody EmployeeBean employeeBean) {

            ArrayList<EmployeeBean> empList = humanResourceService.findEmployeeList(employeeBean.getDeptCode());
            return empList;
    }
    
    @GetMapping("/employeeListall")
    public ArrayList<EmployeeBean> findEmployeeListAll() {

            ArrayList<EmployeeBean> empList = humanResourceService.findEmployeeList();
            
            return empList;
    }

    @PostMapping("/employee")
    public EmployeeBean findEmployee(@RequestBody EmployeeBean employeeBean) {

            EmployeeBean employeeresultBean = humanResourceService.findEmployee(employeeBean.getEmpCode());

            return employeeresultBean;
    }

    @GetMapping("/batchempinfo")
    public void batchEmpInfo(@RequestParam String employeeInfo,@RequestParam String image) {
      
            JSONObject jsonObject = JSONObject.fromObject(employeeInfo);
         
            EmployeeBean employeeBean = (EmployeeBean) JSONObject.toBean(jsonObject, EmployeeBean.class);
            employeeBean.setImage(image);
            humanResourceService.batchEmployeeInfo(employeeBean);
           
   
    }

    @PostMapping("/employeeremoval")
    public void removeEmployee(@RequestBody EmployeeBean employeeBean) {
    	
            humanResourceService.removeEmployee(employeeBean);
          
    }
    @GetMapping("/deptlist")
    public ArrayList<DepartmentBean> findDeptList() {
       
            ArrayList<DepartmentBean> deptList = humanResourceService.findDeptList();
         
        return deptList;
    }
    
    @PostMapping("/detaildeptlist")
    public ArrayList<DepartmentBean> findDetailDeptList(@RequestBody DepartmentBean departmentBean) {

            ArrayList<DepartmentBean> detailDeptList = humanResourceService.findDetailDeptList(departmentBean.getWorkplaceCode());
        
        return detailDeptList;
    }
}
