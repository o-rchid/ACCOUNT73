package kr.co.seoulit.account.operate.system.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class WorkplaceBean extends BaseBean{
	private String workplaceCode;
    private String companyCode;
    private String workplaceName;
    private String businessLicense;
    private String corporationLicence;
    private String workplaceCeoName;
    private String businessConditions;
    private String businessItems;
    private String workplaceTelNumber;
    private String workplaceFaxNumber;
    private String workplaceBasicAddress;
    private String approvalStatus; 
    private String workplaceZipCode;
    private String workplaceDetailAddress;
}
