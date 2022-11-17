package kr.co.seoulit.account.settlement.financialstatements.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class ImFinancialStatementBean extends BaseBean {
	private String accountName1;
	private String amount1;
	private String accountName2;
	private String amount2;
}
