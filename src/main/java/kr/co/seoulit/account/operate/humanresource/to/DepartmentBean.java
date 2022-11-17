package kr.co.seoulit.account.operate.humanresource.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class DepartmentBean extends BaseBean{
	
	private String workplaceCode;
	private String workplaceName;
	private String deptCode;
	private String deptName;
	private String companyCode;
	private String deptStartDate;
	private String deptEndDate;


}
