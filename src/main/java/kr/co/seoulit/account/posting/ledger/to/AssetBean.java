package kr.co.seoulit.account.posting.ledger.to;

import lombok.Data;

@Data
public class AssetBean {
	private long assetNumber;
	private String assetName, assetCode;
}