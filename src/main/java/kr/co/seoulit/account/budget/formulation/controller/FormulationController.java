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


    @PostMapping("/budget")
    public BudgetBean findBudget(@RequestBody BudgetBean budgetBean) {

        return formulationService.findBudget(budgetBean);
    }

    @PostMapping("/budgetorganization")
    public BudgetBean findBudgetorganization(@RequestBody BudgetBean budgetBean) {

        return formulationService.findBudgetorganization(budgetBean);
    }

    @PostMapping("/budgetlist")
    public ModelMap registerBudget(@RequestBody BudgetBean budgetBean) {

        map = formulationService.registerBudget(budgetBean);

        return map;

    }

    ;

    @PutMapping("/budgetlist")
    public ModelMap modifyBudget(@RequestBody BudgetBean budgetBean) {

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


    @PostMapping("/budgetstatus")
    public HashMap<String, Object> findBudgetStatus(@RequestBody BudgetBean budgetBean) {

        HashMap<String, Object> params = new HashMap<>();

        params.put("accountPeriodNo", budgetBean.getAccountPeriodNo());
        params.put("deptCode", budgetBean.getDeptCode());
        params.put("workplaceCode", budgetBean.getWorkplaceCode());

        formulationService.findBudgetStatus(params);

        return params;
    }

    @PostMapping("/budgetappl")
    public BudgetBean findBudgetAppl(@RequestBody BudgetBean budgetBean) {

        return formulationService.findBudgetAppl(budgetBean);
    }

    @PostMapping("/comparisonBudget")
    public HashMap<String, Object> findComparisonBudget(@RequestBody BudgetBean budgetBean) {


        HashMap<String, Object> params = new HashMap<>();

        params.put("accountPeriodNo", budgetBean.getAccountPeriodNo());
        params.put("deptCode", budgetBean.getDeptCode());
        params.put("workplaceCode", budgetBean.getWorkplaceCode());
        params.put("accountInnerCode", budgetBean.getAccountInnerCode());

        params = formulationService.findComparisonBudget(params);

        return params;
    }

    @PostMapping("/currentbudget")
    public BudgetBean findCurrentBudget(@RequestBody BudgetBean budgetBean) {

        return formulationService.findCurrentBudget(budgetBean);
    }
}

