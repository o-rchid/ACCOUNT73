package kr.co.seoulit.account.operate.system.to;

import java.util.ArrayList;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class AccountBean extends BaseBean {
    private ArrayList<AccountControlBean> accountControlList;
    private String accountInnerCode;
    private String parentAccountInnercode;
    private String accountCode;
    private String accountCharacter;
    private String accountName;
    private String accountUseCheck;
    private String accountDescription;
    private String editable;
    private String editform;
	private String lev;
    private String budget;
}
