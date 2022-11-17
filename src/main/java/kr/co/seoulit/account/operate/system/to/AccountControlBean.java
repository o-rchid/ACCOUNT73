package kr.co.seoulit.account.operate.system.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class
AccountControlBean extends BaseBean {
    private String accountControlCode;
    private String accountControlName;
    private String accountControlType;
    private String accountControlDescription;
}
