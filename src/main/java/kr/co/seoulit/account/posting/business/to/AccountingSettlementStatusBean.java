package kr.co.seoulit.account.posting.business.to;

import lombok.Data;

@Data
public class AccountingSettlementStatusBean {
	private long accountPeriodNo;
	private String totalTrialBalance;
	private String incomeStatement;
	private String financialPosition;
}
