package kr.co.seoulit.account.settlement.financialstatements.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class FinancialPositionBean extends BaseBean {
    private long lev;
    private String category;
    private String accountName;
    private String accountCode;
    private long balanceDetail;
    private long balanceSummary;
    private long preBalanceDetail;
    private long preBalanceSummary;
    private long isThisYear;
}
