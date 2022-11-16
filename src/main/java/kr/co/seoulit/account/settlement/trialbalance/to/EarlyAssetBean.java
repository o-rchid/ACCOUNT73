package kr.co.seoulit.account.settlement.trialbalance.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class EarlyAssetBean extends BaseBean {
    private String gropuCode;
    private String accountInnerCode;
    private String accountName;
    private String price;
    private String statementsDivision;
    private String balanceDivision;
    private String leftDebtorPrice;
    private String rightCreditsPrice;

}
