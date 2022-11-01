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
    
	@GetMapping("/assetitemlist")
    public ArrayList<AssetItemBean> assetItemList(@RequestParam String assetCode) {
    	
        	ArrayList<AssetItemBean> AssetItemList = ledgerService.findAssetItemList(assetCode);

        	return AssetItemList;
    }
    
	@GetMapping("/deptlist")
    public ArrayList<DeptBean> deptList() {
    	
        	ArrayList<DeptBean> DeptList = ledgerService.findDeptList();

        	return DeptList;
    }
    
    @PostMapping("/assetstorage")
    public void assetStorage(/*@RequestParam(value="previousAssetItemCode", required=false) String previousAssetItemCode,
    								 @RequestParam(value="assetItemCode", required=false) String assetItemCode,
    								 @RequestParam(value="assetItemName", required=false) String assetItemName,
    								 @RequestParam(value="parentsCode", required=false) String parentsCode,
    								 @RequestParam(value="parentsName", required=false) String parentsName,
    								 @RequestParam(value="acquisitionDate", required=false) String acquisitionDate,
    								 @RequestParam(value="acquisitionAmount", required=false) String acquisitionAmount,
    								 @RequestParam(value="manageMentDept", required=false) String manageMentDept,
    								 @RequestParam(value="usefulLift", required=false) String usefulLift*/
	@RequestBody HashMap<String,Object> map) {
    		
    	//System.out.println(assetItemCode+"@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//        	HashMap<String, Object> map = new HashMap<>();
//        	map.put("assetItemCode", assetItemCode);
//        	map.put("assetItemName", assetItemName);
//        	map.put("parentsCode", parentsCode);
//        	map.put("parentsName", parentsName);
//        	map.put("acquisitionDate", acquisitionDate);
//        	map.put("acquisitionAmount", Integer.parseInt((acquisitionAmount).replaceAll(",","")));
//        	map.put("manageMentDept", manageMentDept);
//        	map.put("usefulLift", usefulLift);
//        	map.put("previousAssetItemCode", previousAssetItemCode);

        	
        	ledgerService.assetStorage(map);

    }
    
    @GetMapping("/assetremoval")
    public void assetRemove(@RequestParam String assetItemCode) {
    	
        	ledgerService.removeAssetItem(assetItemCode);

    }
}
