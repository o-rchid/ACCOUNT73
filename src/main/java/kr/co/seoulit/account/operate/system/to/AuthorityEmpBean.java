package kr.co.seoulit.account.operate.system.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class AuthorityEmpBean extends BaseBean {
    private String empCode;
    private String empName;
    private String authorityCode;
    private String authorityName;
    private String isAuthority;
    private String menuCode;
    private String menuName;
    private String authority;
    private String deptCode;
    private String authorityGroup;
}
