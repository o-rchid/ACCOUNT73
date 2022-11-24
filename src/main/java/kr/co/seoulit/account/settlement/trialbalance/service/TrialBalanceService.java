package kr.co.seoulit.account.settlement.trialbalance.service;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.seoulit.account.settlement.trialbalance.to.DetailTrialBalanceBean;
import kr.co.seoulit.account.settlement.trialbalance.to.EarlyAssetBean;

public interface TrialBalanceService {

	 public HashMap<String, Object> findTotalTrialBalance(HashMap<String, Object> params);


	 public HashMap<String, Object> findEarlyStatements(HashMap<String, Object> params);
	 
	 public HashMap<String, Object> findchangeAccountingSettlement(HashMap<String, Object> params);
	 
	 public ArrayList<DetailTrialBalanceBean> findDetailTrialBalance(String fromDate, String toDate);
	 
}
