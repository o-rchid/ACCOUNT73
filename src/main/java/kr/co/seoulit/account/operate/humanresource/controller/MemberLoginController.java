package kr.co.seoulit.account.operate.humanresource.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.seoulit.account.operate.humanresource.exception.IdNotFoundException;
import kr.co.seoulit.account.operate.humanresource.exception.PwMissmatchException;
import kr.co.seoulit.account.sys.base.service.BaseService;
import kr.co.seoulit.account.sys.base.to.MenuBean;
import kr.co.seoulit.account.operate.humanresource.to.EmployeeBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

@Controller
public class MemberLoginController {
    @Autowired
    private BaseService baseService;

    @PostMapping("/login")
    public ModelAndView handleRequestInternal(EmployeeBean employeeBean, HttpServletRequest request) {

        String viewName = null;
        String periodNo=null;
        HashMap<String, Object> model = new HashMap<>();
        HttpSession session = request.getSession();
        try {
            System.out.println("      @ 로그인 폼에서 파라메터로 받아온 empCode22: " + employeeBean.getEmpCode());
            System.out.println("      @ 로그인 폼에서 파라메터로 받아온 userPw: " + employeeBean.getUserPw());
            String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            System.out.println("      @ 로그인 폼에서 파라메터로 받아온 today: " + today);

            EmployeeBean employeeResultBean = baseService.findLoginData(employeeBean);
            System.out.println(employeeBean);
            System.out.println(employeeResultBean);
            System.out.println(employeeResultBean.getEmpCode());
            System.out.println("      @ BaseService에서 접근 권한을 얻어옴");
            periodNo=baseService.findPeriodNo(today);     //회계기수를 반환함. 오늘날짜가 period기수정보 테이블에 없으면 null
            System.out.println("today: "+today);
            System.out.println("      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@: " + periodNo);

            	System.out.println("여기");
            	System.out.println(today);
            if(periodNo==null) {
               String[] str=today.split("-");   // str={"2020","02","05"}
               System.out.println(str);
               String sdate=str[0]+"-"+"01-01";
               System.out.println(sdate);
               String edate=str[0]+"-"+"12-31";
               System.out.println(edate);
               baseService.registerPeriodNo(sdate,edate);	// sdate=2020-01-01 sdate=2020-12-31
               periodNo=baseService.findPeriodNo(today);	
            }
            
            session.setAttribute("periodNo", periodNo);
            
            if (employeeBean != null) {
                System.out.println("      @ 로그인 : " + employeeResultBean.getEmpName());
                session.setAttribute("empCode", employeeResultBean.getEmpCode());
                session.setAttribute("empName", employeeResultBean.getEmpName());
                session.setAttribute("deptCode", employeeResultBean.getDeptCode());
                session.setAttribute("deptName", employeeResultBean.getDeptName());
                session.setAttribute("positionName", employeeResultBean.getPositionName());
                viewName = "redirect:hello";
            }
            System.out.println("부서" + employeeResultBean.getDeptCode());
            ArrayList<MenuBean> menuList = baseService.findUserMenuList(employeeResultBean.getDeptCode());
            ArrayList<String> list = new ArrayList<>();
            for(MenuBean menu : menuList) {
            	list.add(menu.getMenuName());
            }
            String deptCode = employeeResultBean.getDeptCode();
            session.setAttribute("menuList", list);
            System.out.println("      @ 뷰네임: " + viewName);
		     model.put("deptCode",deptCode); 
        } catch (IdNotFoundException e) {
            model.put("errorCode", -1);
            model.put("errorMsg", /*e.getMessage()*/ "존재하지 않는 계정입니다");
            viewName = "loginform";

        } catch (PwMissmatchException e) {
            model.put("errorCode", -3);
            model.put("errorMsg", /*e.getMessage()*/ "비밀번호가 맞지 않습니다");
            viewName = "loginform";

        } catch (Exception e) {
            e.printStackTrace();
            model.put("errorCode", -4);
            model.put("errorMsg", /*e.getMessage()*/ "예기치 못한 오류 발생");
            viewName = "loginform";
        }

        ModelAndView modelAndView = new ModelAndView(viewName, model); //model엔 null 담음
        return modelAndView;
    }

}