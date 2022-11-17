package kr.co.seoulit.account.sys.base.to;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CodeBean extends BaseBean {
    private String divisionCodeNo;
    private String codeType;
    private String divisionCodeName;


}
