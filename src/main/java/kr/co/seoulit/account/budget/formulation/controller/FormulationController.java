package kr.co.seoulit.account.budget.formulation.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.seoulit.account.budget.formulation.service.FormulationService;
import kr.co.seoulit.account.budget.formulation.to.BudgetBean;
import kr.co.seoulit.account.sys.common.util.BeanCreator;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
@RequestMapping("/budget")
public class FormulationController {

    @Autowired
    private FormulationService formulationService;

    ModelMap map = null;
    BeanCreator beanCreator = BeanCreator.getInstance();

    @GetMapping("/budget")
    public BudgetBean findBudget(/*@RequestParam String budgetObj*/@RequestBody BudgetBean budgetBean) {

//        JSONObject budgetJsonObj = JSONObject.fromObject(budgetObj); //예산
//        BudgetBean budgetBean = beanCreator.create(budgetJsonObj, BudgetBean.class);


        return formulationService.findBudget(budgetBean);
    }

    @GetMapping("/budgetorganization")
    public BudgetBean findBudgetorganization(@RequestParam String budgetObj) {

        JSONObject budgetJsonObj = JSONObject.fromObject(budgetObj); //예산
        BudgetBean budgetBean = beanCreator.create(budgetJsonObj, BudgetBean.class);


        return formulationService.findBudgetorganization(budgetBean);
    }

    @GetMapping("/budgetlist")
    public void findBudgetList(@RequestParam String budgetObj) {


        JSONObject budgetJsonObj = JSONObject.fromObject(budgetObj); //예산
        BudgetBean budgetBean = beanCreator.create(budgetJsonObj, BudgetBean.class);
        formulationService.findBudgetList(budgetBean);

    }

    @PostMapping("/budgetlist")
    public ModelMap registerBudget(@RequestParam(value = "budgetObj") String budgetObj) {
        JSONObject budgetJsonObj = JSONObject.fromObject(budgetObj); //예산
        BudgetBean budgetBean = beanCreator.create(budgetJsonObj, BudgetBean.class);
        map = formulationService.registerBudget(budgetBean);
        return map;

    }

    ;

    @PutMapping("/budgetlist")
    public ModelMap modifyBudget(@RequestParam(value = "budgetObj") String budgetObj) {
        JSONObject budgetJsonObj = JSONObject.fromObject(budgetObj); //예산
        BudgetBean budgetBean = beanCreator.create(budgetJsonObj, BudgetBean.class);
        map = new ModelMap();
        try {
            formulationService.modifyBudget(budgetBean);
            map.put("errorCode", 1);
            map.put("errorMsg", "성공!");
        } catch (Exception e) {
            map.put("errorCode", -1);
            map.put("exceptionClass", e.getClass());
        }
        return map;
    }


    @GetMapping("/budgetstatus")
    public HashMap<String, Object> findBudgetStatus(@RequestParam String budgetObj) {

        HashMap<String, Object> params = new HashMap<>();
        JSONObject budgetJsonObj = JSONObject.fromObject(budgetObj); //예산
        BudgetBean budgetBean = beanCreator.create(budgetJsonObj, BudgetBean.class);
        params.put("accountPeriodNo", budgetBean.getAccountPeriodNo());
        params.put("deptCode", budgetBean.getDeptCode());
        params.put("workplaceCode", budgetBean.getWorkplaceCode());
        formulationService.findBudgetStatus(params);

        return params;
    }

    @GetMapping("/budgetappl")
    public BudgetBean findBudgetAppl(@RequestParam String budgetObj) {

        JSONObject budgetJsonObj = JSONObject.fromObject(budgetObj); //예산
        BudgetBean budgetBean = beanCreator.create(budgetJsonObj, BudgetBean.class);

        return formulationService.findBudgetAppl(budgetBean);
    }

    @GetMapping("/comparisonBudget")
    public HashMap<String, Object> findComparisonBudget(@RequestParam String budgetObj) {

        System.out.println("budgetObj = " + budgetObj);
        HashMap<String, Object> params = new HashMap<>();
        JSONObject budgetJsonObj = JSONObject.fromObject(budgetObj); //예산
        BudgetBean budgetBean = beanCreator.create(budgetJsonObj, BudgetBean.class);

        params.put("accountPeriodNo", budgetBean.getAccountPeriodNo());
        params.put("deptCode", budgetBean.getDeptCode());
        params.put("workplaceCode", budgetBean.getWorkplaceCode());
        params.put("accountInnerCode", budgetBean.getAccountInnerCode());

        params = formulationService.findComparisonBudget(params);

        System.out.println("params = " + params);
        return params;
    }

    @GetMapping("/currentbudget")
    public BudgetBean findCurrentBudget(@RequestParam String budgetObj) {

        JSONObject budgetJsonObj = JSONObject.fromObject(budgetObj); //예산
        System.out.println("budgetJsonObj = " + budgetJsonObj);
        BudgetBean budgetBean = beanCreator.create(budgetJsonObj, BudgetBean.class);

        return formulationService.findCurrentBudget(budgetBean);
    }
}
