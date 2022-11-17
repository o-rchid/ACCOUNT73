package kr.co.seoulit.account.settlement.trialbalance.to;

import lombok.Data;

@Data
public class ImTotalTrialBalanceBean {
private String accountName;
private long leftBalance;
private long  sumLeftDebtorPrice;
private long rightBalance;
private long sumRightCreditsPrice;
}
