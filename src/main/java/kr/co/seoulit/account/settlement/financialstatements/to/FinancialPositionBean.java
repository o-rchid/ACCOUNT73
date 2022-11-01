package kr.co.seoulit.account.settlement.financialstatements.to;

import kr.co.seoulit.account.sys.base.to.BaseBean;

public class FinancialPositionBean extends BaseBean {
    private long lev;
    private String category;
    private String accountName;
    private String accountCode;
    private long balanceDetail;
    private long balanceSummary;
    private long preBalanceDetail;
    private long preBalanceSummary;
    private long isThisYear;

    public long getLev() {
        return lev;
    }

    public void setLev(long lev) {
        this.lev = lev;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getAccountCode() {
        return accountCode;
    }

    public void setAccountCode(String accountCode) {
        this.accountCode = accountCode;
    }

    public long getBalanceDetail() {
        return balanceDetail;
    }

    public void setBalanceDetail(long balanceDetail) {
        this.balanceDetail = balanceDetail;
    }

    public long getBalanceSummary() {
        return balanceSummary;
    }

    public void setBalanceSummary(long balanceSummary) {
        this.balanceSummary = balanceSummary;
    }

    public long getPreBalanceDetail() {
        return preBalanceDetail;
    }

    public void setPreBalanceDetail(long preBalanceDetail) {
        this.preBalanceDetail = preBalanceDetail;
    }

    public long getPreBalanceSummary() {
        return preBalanceSummary;
    }

    public void setPreBalanceSummary(long preBalanceSummary) {
        this.preBalanceSummary = preBalanceSummary;
    }

    public long getIsThisYear() {
        return isThisYear;
    }

    public void setIsThisYear(long isThisYear) {
        this.isThisYear = isThisYear;
    }
}
