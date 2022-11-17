package kr.co.seoulit.account.settlement.trialbalance.to;

import lombok.Data;

@Data
public class TotalTrialBalanceBean {
    private long lev;
    private String accountName;
    private String accountInnerCode;
    private long debitsSumBalance;
    private long debitsSum;
    private long creditsSum;
    private long creditsSumBalance;
}
