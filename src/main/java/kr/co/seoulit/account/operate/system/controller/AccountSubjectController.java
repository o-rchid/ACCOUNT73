package kr.co.seoulit.account.operate.system.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import kr.co.seoulit.account.operate.system.service.SystemService;

import kr.co.seoulit.account.operate.system.to.AccountBean;
import kr.co.seoulit.account.operate.system.to.AccountControlBean;
import kr.co.seoulit.account.operate.system.to.PeriodBean;

@RestController
@RequestMapping("/operate")
public class AccountSubjectController {
	
	@Autowired
    private SystemService systemService;

	
    ModelAndView mav = null;
    ModelMap map = new ModelMap();
    
    @PostMapping("/account")
    public AccountBean findAccount(@RequestBody AccountBean accountBean) {

        return systemService.findAccount(accountBean.getAccountCode());
    }

    @PostMapping("/accountcontrollist")
    public ArrayList<AccountControlBean> findAccountControlList(@RequestBody AccountBean accountBean) {


        return systemService.findAccountControlList(accountBean.getAccountCode());
    }
    @PostMapping("/accountlistbyname")
    public ArrayList<AccountBean> findAccountListByName(@RequestBody AccountBean accountBean) {

        return systemService.findAccountListByName(accountBean.getAccountName());
    }
    @GetMapping("/parentaccountlist")
    public ArrayList<AccountBean> findParentAccountList() {

        return   systemService.findParentAccountList();
    }
    @GetMapping("/detailaccountlist")
    public ArrayList<AccountBean> findDetailAccountList(@RequestParam String code) {

            ArrayList<AccountBean> accountList = systemService.findDetailAccountList(code);
         
        return accountList;
    }

    @PostMapping("/accountmodification")
    public void modifyAccount(@RequestBody AccountBean accountBean) {
        systemService.modifyAccount(accountBean);

    }
    @GetMapping("/detailbudgetlist")
    public ArrayList<AccountBean> findDetailBudgetList(@RequestParam String code) {

        return systemService.findDetailBudgetList(code);
    }
    
    @GetMapping("/parentbudgetlist")
    public ArrayList<AccountBean> findParentBudgetList() {

        return systemService.findParentBudgetList();
    }

    @GetMapping("/parentbudgetlist2")
    public ArrayList<AccountBean> findParentBudgetList2(@RequestParam String workplaceCode,
                                                        @RequestParam String deptCode,
                                                        @RequestParam String accountPeriodNo) {
        System.out.println("workplaceCode:" +workplaceCode);
        System.out.println("deptCode:" +deptCode);

        return systemService.findParentBudgetList2(workplaceCode,deptCode,accountPeriodNo);
    }

    @GetMapping("/accountperiodlist")
    public ArrayList<PeriodBean> findAccountPeriodList() {

        return systemService.findAccountPeriodList();
    }
}
