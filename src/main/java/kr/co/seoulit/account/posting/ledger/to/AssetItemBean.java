package kr.co.seoulit.account.posting.ledger.to;

import lombok.Data;

@Data
public class AssetItemBean {
	String assetItemCode;
	String assetItemName;
	String acquisitionDate; //취득일자
	int acquisitionAmount; //취득금액
	int usefulLift; //내용연수
	String manageMentDeptName; // 관리부서이름
	String parentsCode;
	String parentsName;
	String previousAssetItemCode;
}
