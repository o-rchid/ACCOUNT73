package kr.co.seoulit.account.posting.business.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class SlipBean extends BaseBean {
    private String id;
    private String slipNo;
    private String accountPeriodNo;
    private String deptCode;
    private String deptName;
    private String slipType;
    private String expenseReport;
    private String authorizationStatus;
    private String reportingEmpCode;
    private String reportingEmpName;
    private String reportingDate;
    private String approvalEmpCode;
    private String approvalDate;
    private String slipStatus;
    private String balanceDivision;
    private String positionCode;
}
