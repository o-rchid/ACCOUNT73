package kr.co.seoulit.account.operate.humanresource.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class EmployeeBean extends BaseBean {
    private String BasicAddress;
    private String DetailAddress;
    private String userOrNot;
    private String deptName;
    private String empCode;
    private String empName;
    private String companyCode;
    private String workPlaceCode;
    private String deptCode;
    private String positionCode;
    private String positionName;
    private String socialSecurityNumber;
    private String birthDate;
    private String gender;
    private String eMail;
    private String phoneNumber;
    private String Image;
    private String userPw;
    private String ZipCode;

}
