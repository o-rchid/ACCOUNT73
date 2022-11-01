package kr.co.seoulit.account.budget.formulation.service;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.*;

import kr.co.seoulit.account.budget.formulation.to.ComparisonBudgetBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.seoulit.account.budget.formulation.mapper.FormulationMapper;
import kr.co.seoulit.account.budget.formulation.to.BudgetBean;
import kr.co.seoulit.account.budget.formulation.to.BudgetStatusBean;
import org.springframework.ui.ModelMap;

@Service
@Transactional
public class FormulationServiceImpl implements FormulationService {

	@Autowired
	private FormulationMapper formulationDAO;


	@Override
	public BudgetBean findBudget(BudgetBean bean) {
		// TODO Auto-generated method stub

			bean = formulationDAO.selectBudget(bean);

		return bean;
	}
	
	public BudgetBean findBudgetorganization(BudgetBean bean) {
		// TODO Auto-generated method stub

		return  formulationDAO.selectBudgetorganization(bean);
	}

	@Override
	public void findBudgetList(BudgetBean bean) {
		// TODO Auto-generated method stub

			formulationDAO.selectBudgetList(bean);

	}

	@Override
	public HashMap<String, Object> findBudgetStatus(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
//		HashMap<String, Object> map = new HashMap();
//		System.out.println("AccountPeriodNo = " + bean.getAccountPeriodNo());
//		System.out.println("WorkplaceCode = " + bean.getWorkplaceCode());
//		System.out.println("DeptCode = " + bean.getDeptCode());
		HashMap<String, Object> budgetStatus = formulationDAO.selectBudgetStatus(params);
		System.out.println("budgetStatus = " + budgetStatus );
		return budgetStatus;
	}

	@Override
	public BudgetBean findBudgetAppl(BudgetBean bean) {
		// TODO Auto-generated method stub
		
		return formulationDAO.selectBudgetAppl(bean);
	}

	@Override
	public ModelMap registerBudget(BudgetBean bean) {
		ModelMap map = new ModelMap();
		try{
		formulationDAO.insertBudget(bean);
		map.put("errorCode", 1);
		map.put("errorMsg", "성공!");
		}
		catch (DuplicateKeyException e){
			map.put("errorCode", -2);
			map.put("exceptionClass", e.getClass());
		}
		catch (Exception e) {
			map.put("errorCode", -1);
			map.put("exceptionClass", e.getClass());
		}
		return map;
	}

	@Override
	public ModelMap modifyBudget(BudgetBean bean) {
		ModelMap map = new ModelMap();
		try{
			formulationDAO.updateBudget(bean);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공!");
		}
		catch (Exception e) {
			map.put("errorCode", -1);
			map.put("exceptionClass", e.getClass());
		}
		return map;
	}

	@Override
	public HashMap<String, Object> findComparisonBudget(HashMap<String, Object> params) {
		formulationDAO.selectComparisonBudget(params);


		return params;
	}

	@Override
	public BudgetBean findCurrentBudget(BudgetBean budgetBean){
		budgetBean = formulationDAO.selectCurrentBudget(budgetBean);

		return budgetBean;

	}
}
