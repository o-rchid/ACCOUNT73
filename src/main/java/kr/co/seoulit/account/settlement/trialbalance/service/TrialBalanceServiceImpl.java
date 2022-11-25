package kr.co.seoulit.account.settlement.trialbalance.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.seoulit.account.settlement.trialbalance.mapper.TotalTrialBalanceMapper;
import kr.co.seoulit.account.settlement.trialbalance.to.DetailTrialBalanceBean;

@Service
@Transactional
public class TrialBalanceServiceImpl implements TrialBalanceService{
    
	@Autowired
    private TotalTrialBalanceMapper totalTrialBalanceDAO;

    @Override
    public HashMap<String, Object> findTotalTrialBalance(HashMap<String,Object> params) {

        	HashMap<String, Object> trialBalanceList = null;
        	trialBalanceList = totalTrialBalanceDAO.selectcallTotalTrialBalance(params);
		System.out.println("확인용"+params.get("totalTrialBalance"));
        	
        return trialBalanceList;
    }

    
    @Override
	public HashMap<String, Object> findEarlyStatements(HashMap<String,Object> params) {

    		 totalTrialBalanceDAO.selectcallEarlyStatements(params);

	     return params;
	 }
    
    @Override
	public HashMap<String, Object> findchangeAccountingSettlement(HashMap<String,Object> params) {

        	totalTrialBalanceDAO.selectAccountingSettlement(params);

			return params;
    }
    
    @Override
	public ArrayList<DetailTrialBalanceBean> findDetailTrialBalance(String fromDate, String toDate) {
    		
				HashMap<String, Object> params = new HashMap<>();
				params.put("fromDate",fromDate);
				params.put("toDate",toDate);
		
				ArrayList<DetailTrialBalanceBean> detailTrialBalanceList = totalTrialBalanceDAO.selectDetailTrialBalance(params);

	        return detailTrialBalanceList;
    }
}
