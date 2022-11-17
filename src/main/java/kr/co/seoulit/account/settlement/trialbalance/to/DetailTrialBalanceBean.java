package kr.co.seoulit.account.settlement.trialbalance.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class DetailTrialBalanceBean extends BaseBean {
	private long lev;
	private String accountInnerCode;
	private long debitsSum;
	private long exceptCashDebits;
	private long cashDebits;
	private String accountName;
	private long creditsSumBalance;
	private long debitsSumBalance;
	private long cashCredits;
	private long exceptCashCredits;
	private long creditsSum;
}
