package kr.co.seoulit.account.posting.ledger.controller;

import kr.co.seoulit.account.posting.ledger.service.LedgerService;
import kr.co.seoulit.account.posting.ledger.to.AssetBean;
import kr.co.seoulit.account.posting.ledger.to.AssetItemBean;
import kr.co.seoulit.account.posting.ledger.to.DeptBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;

@RestController
@RequestMapping("/posting")
public class AssetManagementController{

	@Autowired
    private LedgerService ledgerService;
    
	@GetMapping("/assetlist")
	public ArrayList<AssetBean> assetList() {
    	
        	ArrayList<AssetBean> AssetList = ledgerService.findAssetList();

        	return AssetList;
    }

	@PostMapping("/assetitemlist")
    public ArrayList<AssetItemBean> assetItemList(@RequestBody AssetBean assetBean) {

        	ArrayList<AssetItemBean> AssetItemList = ledgerService.findAssetItemList(assetBean.getAssetCode());

        	return AssetItemList;
    }
    
	@GetMapping("/deptlist")
    public ArrayList<DeptBean> deptList() {
    	
        	ArrayList<DeptBean> DeptList = ledgerService.findDeptList();

        	return DeptList;
    }
    
    @PostMapping("/assetstorage")
    public void assetStorage(@RequestBody AssetItemBean assetItemBean){

        	ledgerService.assetStorage(assetItemBean);

    }
    
    @PostMapping("/assetremoval")
    public void assetRemove(@RequestBody AssetItemBean assetItemBean) {
    	
        	ledgerService.removeAssetItem(assetItemBean.getAssetItemCode());

    }
}
