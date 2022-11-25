package kr.co.seoulit.account.posting.ledger.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import kr.co.seoulit.account.posting.ledger.service.LedgerService;
import kr.co.seoulit.account.posting.ledger.service.LedgerServiceImpl;
import kr.co.seoulit.account.posting.ledger.to.CashJournalBean;
import kr.co.seoulit.account.sys.common.exception.DataAccessException;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/posting")
public class CashJournalController {

    @Autowired
    private LedgerService ledgerService;
    
    ModelAndView mav = null;
    ModelMap map = new ModelMap();

    @PostMapping("/cashjournal")
    public ArrayList<CashJournalBean> handleRequestInternal(@RequestBody CashJournalBean cashJournalBean) {


        ArrayList<CashJournalBean> cashJournalList =
                ledgerService.findCashJournal(cashJournalBean);


/*        ArrayList<CashJournalBean> cashJournalList =
                ledgerService.findCashJournal(cashJournalBean.getFromDate(), cashJournalBean.getToDate(), cashJournalBean.getAccount());*/

        return cashJournalList;
    }
}
