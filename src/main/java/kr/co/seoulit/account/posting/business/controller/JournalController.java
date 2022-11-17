package kr.co.seoulit.account.posting.business.controller;

import kr.co.seoulit.account.posting.business.service.BusinessService;
import kr.co.seoulit.account.posting.business.to.JournalBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/posting")
public class JournalController {

    @Autowired
    private BusinessService businessService;

    @PostMapping("/singlejournallist")
    public ArrayList<JournalBean> findSingleJournalList(@RequestBody JournalBean journalBean) {

        return businessService.findSingleJournalList(journalBean.getSlipNo());
    }

    @GetMapping("/rangedjournallist")
    public ArrayList<JournalBean> findRangedJournalList(@RequestParam String fromDate,
                                                        @RequestParam String toDate) {
        ArrayList<JournalBean> journalList = businessService.findRangedJournalList(fromDate, toDate);

        return journalList;
    }

    @PostMapping("/journalremoval")
    public void removeJournal(@RequestBody JournalBean journalBean) {


        businessService.removeJournal(journalBean.getJournalNo());

    }

    @PostMapping("/modifyJournal")
    public void modifyJournal(@RequestParam String slipNo,
                              /*@RequestParam JSONArray journalObj*/@RequestBody ArrayList<JournalBean> journalBeanList) {

//        JSONArray journalObjs = JSONArray.fromObject(journalObj);
//
//        ArrayList<JournalBean> journalBeanList = new ArrayList<>();

//        for (Object journalObjt : journalObjs) {
//            JournalBean journalBean = BeanCreator.getInstance().create(JSONObject.fromObject(journalObjt), JournalBean.class);
//            journalBean.setStatus(((JSONObject) journalObjt).getString("status"));
//            journalBeanList.add(journalBean);
//        }
        businessService.modifyJournal(slipNo, journalBeanList);

    }

}
