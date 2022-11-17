package kr.co.seoulit.account.operate.system.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class PeriodBean extends BaseBean{

	private String accountPeriodNo;
	private String fiscalYear;
	private String workplaceCode;
	private String periodStartDate;
	private String periodEndDate;

}
