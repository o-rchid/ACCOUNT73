package kr.co.seoulit.account.posting.business.to;

import java.util.List;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class JournalBean extends BaseBean {
    private String id;
    private String slipNo;
    private String journalNo;
    private String balanceDivision;
    private String accountCode;
    private String accountName;
    private String customerCode;
    private String customerName;
    private String leftDebtorPrice;
    private String rightCreditsPrice;
    private String price;
    private String deptCode;
    private String accountPeriodNo;
    private List<JournalDetailBean> journalDetailList;
}
