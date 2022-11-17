package kr.co.seoulit.account.posting.ledger.to;

import lombok.Data;

@Data
public class CashJournalBean {
	private String monthReportingDate;
	private String reportingDate;
	private String expenseReport;
	private String customerCode;
	private String customerName;
	private long deposit;
	private long withdrawal;
	private String balance;
}