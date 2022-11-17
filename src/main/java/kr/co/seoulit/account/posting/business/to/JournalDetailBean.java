package kr.co.seoulit.account.posting.business.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;
import lombok.Data;

@Data
public class JournalDetailBean extends BaseBean {
    private String journalDetailNo;//
    private String accountControlName;//
    private String accountControlType;//
    private String journalDescription;//
    private String accountControlDescription;
    private String journalNo;//
    private String accountControlCode;
}
