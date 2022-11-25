package kr.co.seoulit.account.posting.ledger.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.seoulit.account.posting.business.to.JournalBean;
import kr.co.seoulit.account.posting.business.to.JournalDetailBean;
import kr.co.seoulit.account.posting.ledger.mapper.AssistantLedgerMapper;
import kr.co.seoulit.account.posting.ledger.mapper.AuxiliaryLedgerMapper;
import kr.co.seoulit.account.posting.ledger.mapper.JournalEntryMapper;
import kr.co.seoulit.account.posting.ledger.to.AssetBean;
import kr.co.seoulit.account.posting.ledger.to.AssetItemBean;
import kr.co.seoulit.account.posting.ledger.to.CashJournalBean;
import kr.co.seoulit.account.posting.ledger.to.DeptBean;

@Service
@Transactional
public class LedgerServiceImpl implements LedgerService {
    
	@Autowired
    private JournalEntryMapper journalEntryDAO;
	@Autowired
    private AuxiliaryLedgerMapper auxiliaryLedgerDAO;
	@Autowired
    private AssistantLedgerMapper assistantLedgerDAO;

    
    @Override
	public ArrayList<CashJournalBean> findTotalCashJournal(CashJournalBean cashJournalBean) {

        	ArrayList<CashJournalBean> cashJournalList = null;

        	cashJournalList = auxiliaryLedgerDAO.selectTotalCashJournalList(cashJournalBean);

        return cashJournalList;
	}
	
	@Override
	public ArrayList<CashJournalBean> findCashJournal(CashJournalBean cashJournalBean) {

		System.out.println(cashJournalBean.getFromDate());
		System.out.println(cashJournalBean.getToDate());
		System.out.println(cashJournalBean.getAccount());
			ArrayList<CashJournalBean> cashJournalList = null;
        	cashJournalList = auxiliaryLedgerDAO.selectCashJournalList(cashJournalBean);
		System.out.println(cashJournalList);

        return cashJournalList;
	}
	
	@Override
    public ArrayList<JournalBean> findRangedJournalList(String fromDate, String toDate) {

        	ArrayList<JournalBean> journalList = null;
        	journalList = journalEntryDAO.selectRangedJournalList(fromDate, toDate);
        	
        return journalList;
    }
	
	@Override
    public ArrayList<JournalDetailBean> findJournalDetailList(String journalNo) {

        	ArrayList<JournalDetailBean> journalDetailBeans = null;
        	journalDetailBeans = journalEntryDAO.selectJournalDetailList(journalNo);

        return journalDetailBeans;
    }
	
	@Override
	public ArrayList<AssetBean> findAssetList() {
		

        	ArrayList<AssetBean> assetBean = null;
        	assetBean = assistantLedgerDAO.selectAssetList();

        return assetBean;
	}
	
	@Override
	public ArrayList<AssetItemBean> findAssetItemList(String assetCode) {
		
        	ArrayList<AssetItemBean> assetBean = null;
        	assetBean = assistantLedgerDAO.selectAssetItemList(assetCode);

        return assetBean;
	}
	
	@Override
	public ArrayList<DeptBean> findDeptList(){

        	ArrayList<DeptBean> DeptBean = null;
        	DeptBean = assistantLedgerDAO.selectDeptList();

        return DeptBean;
	}
	
	@Override
	public void assetStorage(AssetItemBean assetItemBean) {

			if(assetItemBean.getPreviousAssetItemCode().equals("CREATE")) {
				assistantLedgerDAO.createAssetItem(assetItemBean);
			}
			else {
				assistantLedgerDAO.updateAssetItem(assetItemBean);
			}

	}

	@Override
	public void removeAssetItem(String assetItemCode) {

			assistantLedgerDAO.removeAssetItem(assetItemCode);
           
	}
}
