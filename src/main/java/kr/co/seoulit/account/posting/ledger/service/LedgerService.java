package kr.co.seoulit.account.posting.ledger.service;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.seoulit.account.posting.business.to.JournalBean;
import kr.co.seoulit.account.posting.business.to.JournalDetailBean;
import kr.co.seoulit.account.posting.ledger.to.AssetBean;
import kr.co.seoulit.account.posting.ledger.to.AssetItemBean;
import kr.co.seoulit.account.posting.ledger.to.CashJournalBean;
import kr.co.seoulit.account.posting.ledger.to.DeptBean;

public interface LedgerService {

	ArrayList<CashJournalBean> findCashJournal(CashJournalBean cashJournalBean);
    
    ArrayList<CashJournalBean> findTotalCashJournal(CashJournalBean cashJournalBean);
    
    ArrayList<JournalBean> findRangedJournalList(String fromDate, String toDate);
    
    ArrayList<JournalDetailBean> findJournalDetailList(String journalNo);
    
    ArrayList<AssetBean> findAssetList();
    
    ArrayList<AssetItemBean> findAssetItemList(String assetCode);
    
    ArrayList<DeptBean> findDeptList();
    
    void assetStorage(AssetItemBean assetItemBean);
    
    void removeAssetItem(String assetItemCode);
}

