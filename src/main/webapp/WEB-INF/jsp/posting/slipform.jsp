<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %> <%@ taglib prefix="c"
                                            uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>일반전표</title>
  <style>
    .date {
      width: 140px;
      height: 30px;
      font-size: 0.9em;
    }

    .btnsize {
      width: 100px;
      height: 30px;
      font-size: 0.8em;
      /* font-align: center; */
      color: black;
    }

    .btnsize2 {
      width: 60px;
      height: 30px;
      font-size: 0.9em;
      color: black;
    }

    .ag-header-cell-label {
      /* 이것도 셀 정렬 기능인데 클래스를 부르지 않아서 안쓰는듯 */
      justify-content: center;
    }

    /*글자 밑에 있는거 중앙으로  */
    .ag-row .ag-cell {
      display: flex;
      justify-content: center !important; /* align horizontal */
      align-items: center !important;
    }

    .ag-theme-balham .ag-cell,
    .ag-icon .ag-icon-tree-closed::before {
      line-height: 15px !important;
    }

    .ag-group-contracted {
      height: 15px !important;
    }

    .ag-theme-balham .ag-icon-previous:before {
      content: "\f125" !important;
    }

    .ag-theme-balham .ag-icon-next:before {
      content: "\f11f" !important;
    }

    .ag-theme-balham .ag-icon-first:before {
      content: "\f115" !important;
    }

    .ag-theme-balham .ag-icon-last:before {
      content: "\f118" !important;
    }
  </style>
  <script>
    /* 날짜 */
    const date = new Date();
    const year = date.getFullYear().toString();
    //let month = (date.getMonth() + 1 > 9 ? date.getMonth() + 1 : '0' + (date.getMonth() + 1)).toString(); // getMonth()는 0~9까지
    const month = ("0" + (date.getMonth() + 1)).slice(-2);

    //let day = date.getDate() > 9 ? date.getDate() : '0' + date.getDate(); // getDate()는 1~31 까지
    const day = ("00" + date.getDate()).slice(-2);
    const today = year + "-" + month + "-" + day;

    $(document).ready(function () {
      //버튼 이벤트
      $("input:button").hover(
              function () {
                // hover가 2개의 인자값이 있으면 첫번째 인자값은 마우스올렸을때 ,두번째는 땟을때 실행
                $(this).css("background-color", "pink");
              },
              function () {
                $(this).css("background-color", "");
              }
      );

      $("#search").click(searchSlip); // (전표)검색
      $("#addSlip").click(addslipRow); // 전표추가
      $("#deleteSlip").click(deleteSlip); // 전표삭제 - 전표, 분개, 분개상세

      $("#addJournal").click(addJournalRow); // 분개추가
      $("#deleteJournal").click(deleteJournal); // 분개삭제, 화영이가 구현
      $("#showPDF").click(createPdf); // pdf보기
      $("#confirm").click(confirmSlip); // 결재 버튼
      $("#Accountbtn").click(searchAccount); // 모달에서의 계정 검색 버튼
      $("#saveSlip").click(saveSlip); // 전표저장
      $("#accountCode").keydown(function (key) {
        if (key.code == "Enter") {
          searchAccount();
        }
      });
      $("#searchCodebtn").click(searchCode); // 모달에서의 부서 검색 버튼
      $("#searchCode").keydown(function (key) {
        //  #3
        if (key.code == "Enter") {
          searchCode();
        }
      });

      // #8
      $(".close").on("click", function (e) {
        $("#accountGridModal").modal("hide");
        $("#customerCodeModalGrid").modal("hide");
        $("#codeModal").modal("hide");
      });

      // 이번달 첫일부터 오늘까지의 날짜를 초기값으로 설정
      /* DatePicker  */
      $("#from").val(today.substring(0, 8) + "01");
      // 오늘이 포함된 해당 달의 첫번째 날, 1월달이면 1월 1일로 세팅.    2020-xx 총 7자리
      $("#to").val(today.substring(0, 10)); // 오늘 날짜의 년-월-일.

      createSlip();
      // createSlip() 함수 안에서 실행되도록 함
      // showSlipGrid(); //시작하자마자 이번달 전표정보 보이게 해놓음 -> SlipController.findRangedSlipList 실행됨
      createJournal();
      // createjournalDetailGrid();
      createCodeGrid();
      createAccountGrid();
      // showAccount();
      createCustomerCodeGrid();
      createAccountDetailGrid();
      showAccountDetail("0101-0145"); //처음 보이는 값이 당좌자산 첫번째껄로 보이게 해놓음, 두 사람에게 설명해줘야 야 함
    });

    window.addEventListener("keydown", (key) => {
      if (key.code == "F2") {
        addslipRow();
      } else if (key.code == "F3") {
        saveSlip();
      } else if (key.code == "F4") {
        confirmSlip();
      }
    });

    // Utils ---------------------------------------------------------------------------------------------------------
    //화폐 단위 원으로 설정 \100,000,000
    function currencyFormatter(params) {
      return "￦" + formatNumber(params.value);
    }

    function formatNumber(number) {
      return Math.floor(number)
              .toString()
              .replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
    }

    // Map 내의 객체들 Disabled/Enabled
    // 일반전표 페이지의 버튼들을 활성, 비활성화하는 함수
    function enableElement(obj) {
      console.log("enableElement(obj) 실행");

      for (let key in obj) $(key).prop("disabled", !obj[key]); //obj[key]부분은 true false밖에 올수없다.
    }

    // PDF로 보기
    function createPdf() {
      console.log("createPdf() 실행");
      window.open(
              "${pageContext.request.contextPath}/base/financialposition?slipNo=" +
              JSON.parse($("#selectedSlip").val()).slipNo
      );
    }
    // End of Utils ---------------------------------------------------------------------------------------------------------

    let logInfo = {
      deptCode: "${sessionScope.deptCode}",
      accountPeriodNo: "${sessionScope.periodNo}",
      empName: "${sessionScope.empName}",
      empCode: "${sessionScope.empCode}",
    };

    // Slip -----------------------------------------------------------------------------------------------------------------
    let slipGrid;
    // let slipGridOptions;

    function createSlip() {
      console.log("createSlip() 실행");

      const slipColumnDefs = [
        {
          headerName: "전표번호",
          field: "slipNo",
          sort: "desc",
          resizable: true,
          width: 100,
        },
        {
          headerName: "기수",
          field: "accountPeriodNo",
          resizable: true,
          width: 70,
        },
        {
          headerName: "부서코드",
          field: "deptCode",
          resizable: true,
          width: 80,
        },
        {
          headerName: "부서",
          field: "deptName",
          resizable: true,
          hide: true,
        },
        {
          headerName: "구분",
          field: "slipType",
          editable: true,
          cellEditor: "agSelectCellEditor",
          cellEditorParams: { values: ["결산", "대체"] },
          width: 70,
        },
        {
          headerName: "적요",
          field: "expenseReport",
          editable: true,
          resizable: true,
        },
        {
          headerName: "승인상태",
          field: "slipStatus",
          resizable: true,
          width: 100,
        },
        { headerName: "상태", field: "status", resizable: true, hide: true },
        {
          headerName: "작성자코드",
          field: "reportingEmpCode",
          resizable: true,
          width: 100,
        },
        {
          headerName: "작성자",
          field: "reportingEmpName",
          resizable: true,
          hide: true,
        },
        {
          headerName: "작성일",
          field: "reportingDate",
          resizable: true,
          width: 100,
        },
        {
          headerName: "직급",
          field: "positionCode",
          resizable: true,
          hide: true,
        },
      ];

      const slipGridOptions = {
        columnDefs: slipColumnDefs,
        rowSelection: "single", //row는 하나만 선택 가능
        defaultColDef: { editable: false }, // 정의하지 않은 컬럼은 자동으로 설정
        pagination: true, // 페이저
        paginationPageSize: 10, // 페이저에 보여줄 row의 수
        stopEditingWhenGridLosesFocus: true, // 그리드가 포커스를 잃으면 편집 중지
        onGridReady: function (event) {
          // onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
          event.api.sizeColumnsToFit(); // 그리드의 사이즈를 자동으로정리 (처음 틀었을때 양쪽 폭맞춰주는거같음)
        },
        onGridSizeChanged: function (event) {
          // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리  (화면 비율바꿧을때 양쪽폭 맞춰주는거같음)
          event.api.sizeColumnsToFit();
        },
        onRowClicked: function (event) {
          console.log("전표그리드 onRowClicked 실행");
          // selectedSlipRow = event.data;
          let selectedSlipRow = $("#selectedSlip");
          selectedSlipRow.val("");
          selectedSlipRow.val(JSON.stringify(event.data));
          showJournalGrid(event.data["slipNo"]);

          // 페이지가 로딩된 후 전표를 선택하면 볼수있어야 하는데 비활성화 되어있어서 활성화 시킴
          enableElement({ "#showPDF": true });

          if (event.data["slipStatus"] !== "승인완료") {
            enableElement({
              "#deleteSlip": true,
              "#addJournal": true,
              "#deleteJournal": true,
              "#confirm": true,
            });
          } else {
            enableElement({
              "#deleteSlip": false,
              "#addJournal": false,
              "#deleteJournal": false,
              "#confirm": false,
            });
          }
        },
        onCellValueChanged: function (event) {
          console.log("sliprow변경");
          let selectedSlipRow = $("#selectedSlip");
          selectedSlipRow.val("");
          selectedSlipRow.val(JSON.stringify(event.data));
          console.log(event.data);
        },
      };

      slipGrid = new agGrid.Grid(
              document.querySelector("#slipGrid"),
              slipGridOptions
      );
      enableElement({
        "#addSlip": true,
        "#deleteSlip": false,
        "#addJournal": false,
        "#deleteJournal": false,
        "#showPDF": false, //수정
      });

      showSlipGrid(); //시작하자마자 이번달 전표정보 보이게 해놓음 -> SlipController.findRangedSlipList 실행됨
    }

    function showSlipGrid() {
      // 먼저 날짜 데이트를 받고 / 전표추가시 오늘날짜를 actual argument로 넘긴다.
      console.log("showSlipGrid()");
      // console.log(slipGridOptions);
      console.log(slipGrid.gridOptions);

      $.ajax({
        url: "${pageContext.request.contextPath}/posting/rangedsliplist",
        data: {
          fromDate: $("#from").val(),
          toDate: $("#to").val(),
          slipStatus: $("#selTag").val(),
        },
        dataType: "json",
        success: function (jsonObj) {
          if (slipGrid.gridOptions !== null) {
            // slipGridOptions.api.setRowData(jsonObj);
            // 다시 검색할때 기존 열을 지우고 새로 표시하기 위함
            slipGrid.gridOptions.api.setRowData([]);
            slipGrid.gridOptions.api.applyTransaction({ add: jsonObj });
          } else {
            console.log("slipGridOptions is null");
          }
        },
        async: false, //비동기방식설정 - 순서대로 처리
      });
    }

    function searchSlip() {
      console.log("searchSlip() 실행");
      enableElement({
        "#addSlip": true,
        "#deleteSlip": false, //비활성화
        "#addJournal": false,
        "#deleteJournal": false,
        "#showPDF": true,
      });
      showSlipGrid();
    }

    function addslipRow() {
      console.log("addslipRow() 실행");
      $.ajax({
        type: "GET",
        url: "${pageContext.request.contextPath}/posting/accountingsettlementstatus",
        data: {
          accountPeriodNo: logInfo["accountPeriodNo"],
          callResult: "SEARCH", /////// 회계결산현황 조회(SEARCH) 및 호출
        },
        dataType: "json",
        success: function (jsonObj) {
          console.log(logInfo["accountPeriodNo"]);
          // comfirm = false; //comfirm --> 확인창 안뜨게
          let rowData = [];
          // 전표추가시 빈전표 정보를 만들어서 넣음
          let slipObj = {
            slipNo: "NEW",
            accountPeriodNo: logInfo["accountPeriodNo"],
            slipType: "결산", // 결산, 미결산 알아봐서 수정해야함.
            slipStatus: "작성중",
            deptCode: logInfo["deptCode"],
            reportingEmpCode: logInfo["empCode"],
            reportingEmpName: logInfo["empName"],
            reportingDate: today,
          };
          enableElement({ "#addSlip": false }); // 버튼 비활성화 - 전표추가버튼 비활성화

          let newObject = $.extend(true, {}, slipObj); //slipObj에 값이 전부 입력되면 newObject에 담긴다
          rowData.push(newObject); //rowData 집어넣는다
          console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
          console.log(rowData);
          slipGrid.gridOptions.api.applyTransaction({ add: rowData }); // 행데이터를 업데이트, add/remove에 대한 목록이 있는 트랜잭션 객체를 전달

          console.log(jsonObj);
          // 애초에 이런 값이 안들어가 있음
          // console.log(jsonObj.accountingSettlementStatus);
        },
      });
    }

    function deleteSlip() {
      console.log("deleteSlip() 실행");
      let selectedSlipRow = JSON.parse($("#selectedSlip").val());
      console.log("selectedSlipRow.slipNo :" + selectedSlipRow.slipNo);

      //var selectedRows = gridOptions.api.getSelectedRows(); //내가 선택한 값을 selectRows에 담는다 (수정)
      if (
              selectedSlipRow["slipStatus"] == "승인요청" || selectedSlipRow["slipStatus"] == "승인완료"
      ) {
        alert(
                "전표 작성중이 아닙니다.\n현재상태 : " + selectedSlipRow["slipStatus"]
        );
      } else {
        if (confirmDelete()) {
          $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/posting/slipremoval",
            data: JSON.stringify({ slipNo: selectedSlipRow.slipNo }),
            contentType: "application/json",
            success: function () {
              console.log("data 전달 성공");
              // let isNewSlip = (selectedSlipRow.slipNo == "NEW"); // 삭제한다음에 전표추가가 안되서 수정함 (dong)
              enableElement({
                "#addSlip": true,
                "#deleteSlip": false,
                "#addJournal": false,
                "#deleteJournal": false,
                "#showPDF": false,
              });
              // 그리드에서 선택된 전표 오브젝트를 못찾았다고 에러가 났는데 작동은 함.. DB의 값은 바뀌니까 새로고침하면 작동하는거처럼 보임
              console.log("[selectedSlipRow]@@@@@@@@@@@@@@@@@2");
              console.log([selectedSlipRow]);
              // console.log(slipGrid.gridOptions.api.getSelectedNodes());
              console.log(slipGrid.gridOptions.api.getRenderedNodes());
              slipGrid.gridOptions.api.applyTransaction({remove: [slipGrid.gridOptions.api.getSelectedNodes()[0].data]}); //선택된 전표 삭제 (choi)
              // slipGrid.gridOptions.api.applyTransaction({remove: [slipGrid.gridOptions.api.getSelectedNodes().map((row)=>{return {entityId: row.data.entityId}})]}); //선택된 전표 삭제 (choi)
            },
          });
        }
      }
    }

    function confirmDelete() {
      //삭제 메세지
      msg = "삭제하시겠습니까?";
      if (confirm(msg) != 0) {
        return true;
      } else {
        return false;
      }
    }

    function saveSlip(confirm) {
      console.log(
              "saveSlip()================================================="
      );

      let JournalTotalObj = [];
      let slipStatus = confirm == "승인요청" ? confirm : null; //기본은 null이고 confirm할때만 "승인요청"으로 바뀐다

      let selectedSlipRow = JSON.parse($("#selectedSlip").val()); // 전표를 선택하지 않으면 들고오지 못함

      if (selectedSlipRow["slipStatus"] == "승인요청" || selectedSlipRow["slipStatus"] == "승인완료") {
        alert(
                "전표 작성중이 아닙니다.\n현재상태 : " + selectedSlipRow["slipStatus"]
        ); //먼저 한번 걸러줌
      } else {
        // 저널 그리도도 같이 변경함.
        journalGrid.gridOptions.api.forEachNode(function (node, index) {
          // 노드 데이터에 어카운트네임이 없다면 저장되지 않게함
          if (node.data.journalNo !== "Total" && node.data.accountName != undefined) {
            JournalTotalObj.push(node.data); //분개노드 마지막 total 빼고 JournalTotalObj에 담음
            console.log("JournalTotalObj.push(node.data)");
            console.log(JournalTotalObj);
          }
        });

        if (selectedSlipRow["slipNo"] == "NEW") {
          //선택된 로우가 new면
          console.log("NEW 전표========================================");
          console.log(selectedSlipRow);

          $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/posting/registerslip",
            data: {
              "slipObj": JSON.stringify(selectedSlipRow),
              "journalObj": JSON.stringify(JournalTotalObj),
              "slipStatus": slipStatus,
            },
            async: false, // 동기식   // 비동기식으로할경우 아래 showslipgrid에서 값을 못불러올수있다.
            dataType: "json",
            success: function (data) {
              console.log("NEW 전표 success=================================");
              console.log(data);
              enableElement({ "#addSlip": true });
              location.reload();
            },
          });
          // } else if (selectedSlipRow['slipNo'] != NEW_SLIP_NO) { //기존 저장 후 수정 및 반려 후 저장
        } else {
          //기존 저장 후 수정 및 반려 후 저장
          console.log("--------else---------");
          let JournalTotalObj2 = [];
          journalGrid.gridOptions.api.forEachNode(function (node, index) {
            node.data["status"] = "update";
            journalGrid.gridOptions.api.applyTransaction({update: [node.data]});
            JournalTotalObj2.push(node.data);
            console.log(node.data);
            console.log("slipStatus:" + slipStatus);
            console.log(
                    " JournalTotalObj2.push(node.data)!!!! :" +
                    JSON.stringify(JournalTotalObj2)
            );
          });

          //  saveJournal(selectedSlipRow["slipNo"], JournalTotalObj2); 삭제(dong)
          $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/posting/slipmodification",
            data: {
              "slipObj": JSON.stringify(selectedSlipRow),
              "journalObj": JSON.stringify(JournalTotalObj2),
              "slipStatus": slipStatus,
            },
            async: false,
            dataType: "json",
            success: function (jsonObj) {
              enableElement({ "#addSlip": true });
              console.log("slipNo:" + jsonObj.slipNo);
            },
          });
        }

        if (confirm == "승인요청") alert("결제 신청이 완료되었습니다.");
        else alert("저장 되었습니다.");
        console.log(slipGrid);
        console.log(slipGrid.gridOptions.api.getSelectedRows());
        showSlipGrid();
        showJournalGrid(selectedSlipRow.slipNo);
      }
    }

    function confirmSlip() {
      console.log("comfirmSlip() 실행");
      let selectedSlipRow = JSON.parse($("#selectedSlip").val());
      let result = true;
      let compare = compareDebtorCredits(); // for문 안에서 계속 실행되서 밖으로 꺼냄, 한번만 실행되도됨(dong)
      let approvalStatus = compare.isEqualSum; //isEqualSum=true
      journalGrid.gridOptions.api.forEachNode(function (rowNode, index) {
        //forEachNode=forEach
        if (rowNode.data["journalNo"] !== "Total") {
          //토탈이 아니면 == 차변과 대변이면
          if (rowNode.data["balanceDivision"] == null) {
            alert("구분(분개필수 항목)을 확인해주세요");
            result = false;
            return;
          }
          if (rowNode.data["accountCode"] == null) {
            alert("계정코드(분개필수 항목)을 확인해주세요");
            result = false;
            return;
          }
          if (rowNode.data["accountName"] == null) {
            alert("계정과목(분개필수 항목)을 확인해주세요");
            result = false;
            return;
          }
          if (!approvalStatus) {
            //대변의 합과 차변의 합이 같지 않으면
            alert(
                    "전표의 차변/대변 총계가 일치하지않습니다.\n 차변/대변 총계를 확인해주세요."
            );
            result = false;
            return;
          }
        }
      });
      if (
              selectedSlipRow["slipStatus"] == "승인요청" ||
              selectedSlipRow["slipStatus"] == "승인완료"
      ) {
        alert(
                "전표 작성중이 아닙니다.\n현재상태 : " +
                selectedSlipRow["slipStatus"]
        );
      } else if (result) {
        saveSlip("승인요청");
      }
    }

    function compareDebtorCredits() {
      // 대변차변 합계 일치 여부 확인
      console.log("compareDebtorCredits() 실행");
      // let isEqualSum;
      let debtorPriceSum = 0;
      let creditsPriceSum = 0;

      journalGrid.gridOptions.api.forEachNode(function (node) {
        debtorPriceSum += parseInt(node.data.leftDebtorPrice);
        creditsPriceSum += parseInt(node.data.rightCreditsPrice);
      });
      return { isEqualSum: debtorPriceSum == creditsPriceSum };
    }
    // End of Slip -----------------------------------------------------------------------------------------------------------------

    // Journal -----------------------------------------------------------------------------------------------------------------

    let journalGrid;
    // let journalDetailGrid;
    // let selectedJournal;

    function createJournal() {
      console.log("createJournal() 실행");
      // let rowData = [];
      let selectedJournalRow;
      // let selectedJournalDetail;
      const journalGridOptions = {
        columnDefs: [
          {
            headerName: "분개번호",
            field: "journalNo",
            cellRenderer: "agGroupCellRenderer", // Style & Drop Down
            sort: "asc",
            resizable: true,
            onCellDoubleClicked: cellDouble,
          },
          {
            headerName: "구분",
            field: "balanceDivision",
            editable: true,
            cellEditor: "agSelectCellEditor",
            cellEditorParams: { values: ["차변", "대변"] },
          },
          {
            headerName: "계정코드",
            field: "accountCode",
            editable: false
          },
          {
            headerName: "계정과목",
            field: "accountName",
            onCellClicked: function open() {
              $("#accountGridModal").modal("show");
              searchAccount();
            },
          },
          {
            headerName: "차변",
            field: "leftDebtorPrice",
            editable: (params) => {
              if (params.data.balanceDivision == "대변") return false;
              else return true;
            },
            valueFormatter: currencyFormatter, // 통화 값에 대한 로캘별 서식 지정 및 파싱을 제공
          },
          {
            headerName: "대변",
            field: "rightCreditsPrice",
            editable: (params) => {
              if (params.data.balanceDivision == "차변") return false;
              else return true;
            },
            valueFormatter: currencyFormatter,
          },
          //수정중
          {
            headerName: "거래처",
            field: "customerName",
            onCellClicked: function open() {
              $("#customerCodeModalGrid").modal("show");
              searchCustomerCodeList();
            },
          },
          { headerName: "거래처코드", field: "customerCode", hide: true },
          { headerName: "상태", field: "status" },
        ],
        masterDetail: true,
        enableCellChangeFlash: true,
        detailCellRendererParams: {
          detailGridOptions: {
            rowSelection: "single",
            enableRangeSelection: true, // 끌어서 선택옵션
            pagination: true,
            paginationAutoPageSize: true, //지정된 사이즈내에서 최대한 많은 행을 표시
            columnDefs: [
              { headerName: "분개번호", field: "journalNo", hide: true },
              {
                headerName: "계정 설정 속성",
                field: "accountControlType",
                width: 150,
                sortable: true,
              },
              {
                headerName: "분개 상세 번호",
                field: "journalDetailNo",
                width: 150,
                sortable: true,
              },
              { headerName: "-", field: "status", width: 100, hide: true },
              {
                headerName: "-",
                field: "journalDescriptionCode",
                width: 100,
                hide: true,
              },
              {
                headerName: "분개 상세 항목",
                field: "accountControlName",
                width: 150,
              },
              {
                headerName: "분개 상세 내용",
                field: "journalDescription",
                width: 250,
                cellRenderer: cellRenderer,
              },
            ],
            defaultColDef: {
              sortable: true,
              flex: 1, //  flex로 열 크기를 조정하면 해당 열에 대해 flex가 자동으로 비활성화
            },
            getRowNodeId: function (data) {
              console.log("getRowId 실행");
              // use 'account' as the row ID
              console.log("getRowId: " + data.journalDetailNo);
              return data.journalDetailNo;
            },
            onRowClicked: function (event) {
              // 상위 테이블에 있는 상세보기버튼으로도 실행됨.(dong)
              console.log("분개상세그리드 onRowClicked 실행");
              $("#selectedJournalDetail").val("");
              $("#selectedJournalDetail").val(JSON.stringify(event.data));
              // selectedJournalDetail = event.data;
              selectedJournalRow = event.data;
            },
            onCellDoubleClicked: function (event) {
              console.log("onCellDoubleClicked 실행");
              // let journalNo = event.data["journalNo"];
              let detailGridApi =
                      journalGrid.gridOptions.api.getDetailGridInfo(
                              "detail_" + event.data["journalNo"]
                      );
              console.log(detailGridApi);

              if (event.data["accountControlType"] == "SEARCH") {

                $("#codeModal").modal("show");
                // detailGridApi.api.applyTransaction([
                //   (selectedJournalRow["journalDescription"] = searchCode()),
                // ]);
                selectedJournalRow["journalDescription"] = searchCode();
                detailGridApi.api.applyTransaction({update: [selectedJournalRow]});
                return;
              } else if (event.data["accountControlType"] == "SELECT") {
                // var detailGrid=gridOptions.api.getDetailGridInfo('detail_'+event.data.journalDetailNo);
                selectedJournalRow["journalDescription"] = selectBank();
                detailGridApi.api.applyTransaction({update: [selectedJournalRow]});
                return;
              } else if (event.data["accountControlType"] == "TEXT") {
                let str = prompt("상세내용을 입력해주세요", "");
                // console.log("detail_" + event.data.journalDetailNo);
                //var detailGrid=gridOptions2.api.getDetailGridInfo('detail_'+event.data.journalDetailNo);
                // detailGridApi.api.applyTransaction([
                //   (selectedJournalRow["journalDescription"] = str),
                // ]);
                event.data["journalDescription"] = str;
                detailGridApi.api.applyTransaction({update: [event.data]});
                $("#selectedJournalDetail").val(JSON.stringify(event.data));
                saveJournalDetailRow();
                return;
              } else {
                //var detailGrid=gridOptions2.api.getDetailGridInfo('detail_'+event.data.journalDetailNo);
                detailGridApi.api.applyTransaction([
                  (selectedJournalRow["journalDescription"] = selectCal()),
                ]);
                return;
              }
            },
          },
          getDetailRowData: function (params) {
            console.log("getDetailRowData 실행");
            console.log(params);
            console.log(params.data.journalDetailList);
            // JSON.parse($("#selectedJournal").val());
            params.successCallback(params.data.journalDetailList); // detail table 에 값 할당
          },
          template: function (params) {
            return (
                    '<div style="height: 100%; background-color: #EDF6FF; padding: 20px; box-sizing: border-box;">' +
                    '  <div style="height: 10%; padding: 2px; font-weight: bold;">분개상세</div>' +
                    '  <div ref="eDetailGrid" style="height: 90%;"></div>' +
                    "</div>"
            );
          },
        },
        getRowNodeId: function (data) {
          console.log("분개그리드 getRowId 실행 :" + data.journalNo);
          // console.log("========================================================================");
          // console.log(data.data.journalNo);
          // use 'account' as the row ID
          return data.journalNo;
        },
        enterMovesDownAfterEdit: true,
        rowSelection: "single",
        stopEditingWhenGridLosesFocus: true,
        onGridReady: function (event) {
          event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function (event) {
          // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
          event.api.sizeColumnsToFit();
        },
        onCellEditingStopped: function (event) {
          //gridOptions2.api.tabToNextCell();
          console.log("onCellEditingStopped 실행");
          console.log(event);
          if (
                  event.colDef.field == "leftDebtorPrice" ||
                  event.colDef.field == "rightCreditsPrice"
          ) {
            computeJournalTotal(); // 바뀐행이 이 차변,대변이면 실행하도록 수정(dong)
          }
          if (event.colDef.field == "accountCode") {
            // 항상 실행되던거 accouncode 수정될때만 실행되도록 수정(dong)
            $.ajax({
              type: "POST",
              url: "${pageContext.request.contextPath}/operate/accountcontrollist",
              data: JSON.stringify({ accountCode: event.data["accountCode"] }), // 계정코드,
              dataType: "json",
              contentType: "application/json",
              async: false,
              success: function (jsonObj) {
                //jsonObj에는 account_control_code , account_control_name , account_control_type , account_control_description 만 가지고옴
                jsonObj.forEach(function (element, index) {
                  //accountControl은 map의 key 이름, accountControlList가 들어있음
                  element["journalNo"] = selectedJournalRow["journalNo"]; // accountControlList에는 journalNo가 없어서 셋팅 후 아래 그리드옵션에 할당
                });
                journalGrid.gridOptions.api.applyTransaction(
                        (selectedJournalRow["journalDetailList"] = jsonObj)
                );
              },
            });
            price(event);
          }
        },
        onCellValueChanged: function (event) {
          // onCellEditingStopped에 있으면 금액수정할때도 계속 실행되서 수정함(dong)
          // selectedJournalRow = event.data;
          // selectedJournalRow = JSON.parse($("#selectedJournal").val());
          if (event.colDef.field == "accountCode") {
            getAccountName(event.data["accountCode"]);
          }
        },
        onRowClicked: function (event) {
          console.log("분개 그리드 onRowClicked 실행");
          $("#selectedJournal").val("");
          $("#selectedJournal").val(JSON.stringify(event.data));
          selectedJournalRow = event.data;
        },
      };
      journalGrid = new agGrid.Grid(
              document.querySelector("#journalGrid"),
              journalGridOptions
      );
      console.log(journalGrid);
    }

    function cellRenderer(params) {
      // 중복되는일이라 불필요(dong)
      console.log("cellRenderer(params) 실행");
      let result;
      if (params.value != null) result = params.value;
      else result = "";

      return result;
    }

    function selectBank() {
      console.log("selectBank() 실행");
      let selectedJournalDetail = JSON.parse($("#selectedJournalDetail").val());

      console.log(selectedJournalDetail["accountControlDescription"]);

      let ele = document.createElement("select");
      ele.id = "selectId";
      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/base/detailcodelist",
        data: JSON.stringify({
          "divisionCodeNo": selectedJournalDetail["accountControlDescription"],
        }),
        contentType: "application/json",
        dataType: "json",
        async: false,
        success: function (jsonObj) {
          console.log("selectBank의 jsonObj" + jsonObj);
          console.log(jsonObj);
          $("<option></option>").appendTo(ele).html(""); //옵션 값 초기화
          $.each(jsonObj, function (index, obj) {$("<option></option>").appendTo(ele).html(obj.detailCodeName);});
        }
      });

      $(ele).change(function () {
        console.log("$(ele).change 실행");
        selectedJournalDetail["journalDescription"] = $(this).children("option:selected").text();
        // console.log($(this));
        console.log(journalGrid);
        console.log(journalGrid.gridOptions);
        console.log(journalGrid.gridOptions.api.getSelectedRows());
        console.log(journalGrid.gridOptions.api.detailGridInfoMap);
        // journalGrid.gridOptions.detailCellRendererParams.detailGridOptions.api.applyTransaction({update: [selectedJournalDetail]});
        // journalGrid.gridOptions.api.detailGridInfoMap.applyTransaction({update: [selectedJournalDetail]});
        selectedJournalDetail["journalDescriptionCode"] = $(this).val()
        // journalDetailGrid.gridOptions.api.applyTransaction({update: [selectedJournalDetail]});
        console.log(selectedJournalDetail);
        $("#selectedJournalDetail").val(JSON.stringify(selectedJournalDetail));
        saveJournalDetailRow();
      });

      return ele;
    }

    function selectCal() {
      console.log("selectCal 실행");
      let selectedJournalDetail = JSON.parse($("#selectedJournalDetail").val());

      let ele = document.createElement("input");
      ele.type = "date";
      $(ele).change(function () {
        // journalDetailGrid.gridOptions.api.applyTransaction([(selectedJournalDetail["journalDescription"] = $(ele).val()),]);
        selectedJournalDetail["journalDescription"] = $(ele).val();
        $("#selectedJournalDetail").val(JSON.stringify(selectedJournalDetail));
        saveJournalDetailRow();
      });
      return ele;
    }

    function saveJournalDetailRow() {
      console.log("saveJournalDetailRow() 실행");
      let selectedJournalDetail = JSON.parse($("#selectedJournalDetail").val());
      let selectedJournalRow = JSON.parse($("#selectedJournal").val());
      console.log(selectedJournalRow);
      console.log(selectedJournalDetail);
      // console.log(selectedJournalDetail["accountControlType"]);
      // console.log(selectedJournalDetail["journalDetailNo"]);
      // console.log(selectedJournalDetail["journalDescriptionCode"]);
      // console.log(selectedJournalDetail["journalDescription"]);
      let rjournalDescription;
      if (selectedJournalDetail["accountControlType"] == "SELECT" || selectedJournalDetail["accountControlType"] == "SEARCH")
        rjournalDescription = selectedJournalDetail["journalDescriptionCode"];
      //- 숨겨진 곳에 저장한 값
      else rjournalDescription = selectedJournalDetail["journalDescription"];
      console.log(rjournalDescription);
      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/posting/journaldetailmodification",
        data: JSON.stringify({
          journalNo: selectedJournalRow["journalNo"],
          accountControlType: selectedJournalDetail["accountControlType"],
          journalDetailNo: selectedJournalDetail["journalDetailNo"],
          journalDescription: rjournalDescription,
        }),
        contentType: "application/json",
        dataType: "json",
        async: false,
        success: function (jsonObj) {
          console.log("분개 상세  저장 성공");
        },
      });
    }

    function cellDouble(event) {
      console.log("cellDouble(event) 실행");
      let selectedSlipRow = JSON.parse($("#selectedSlip").val());

      if (selectedSlipRow["slipNo"] !== "NEW") {
        let selectedJournalRow = JSON.parse($("#selectedJournal").val());
        console.log(selectedJournalRow);
        // $("#journalDetailGridModal").modal('show');
        //분개상세 보기
        $.ajax({
          type: "POST",
          // JournalDetailDAO- ArrayList<JournalDetailBean> selectJournalDetailList(String journalNo)- return journalDetailBeans
          url: "${pageContext.request.contextPath}/posting/journaldetaillist",
          data: JSON.stringify({
            journalNo: selectedJournalRow["journalNo"], //rowid 분개번호임
          }),
          contentType: "application/json",
          dataType: "json",
          success: function (jsonObj) {
            console.log("성공");
            console.log(jsonObj);
            // journalDetailGrid.gridOptions.api.setRowData(jsonObj);
            // gridOptions4.api.applyTransaction({update: [jsonObj]});

            console.log(
                    "======================================================"
            );
            console.log(JSON.stringify(jsonObj)); //데이터 잘 들고오는지 확인
            console.log(jsonObj);
            console.log(journalGrid);
            // console.log(detailGridApi);
            console.log(
                    journalGrid.gridOptions.detailCellRendererParams
                            .detailGridOptions
            );
            console.log(
                    "======================================================"
            );
            let detailGrid = journalGrid.gridOptions.api.getDetailGridInfo("detail_" + event.value);
            // undefined
            console.log(detailGrid);
            console.log(event.value);
            // detailGridApi.api.setRowData(jsonObj); //가져온 데이터를 gridOption4의 칼럼명에 맞게 하나하나 세팅해주기
            // gridOptions2.detailCellRendererParams.detailGridOptions.api.setRowData(jsonObj); //가져온 데이터를 gridOption4의 칼럼명에 맞게 하나하나 세팅해주기
          },
        });
      }
    }

    function price(event) {
      console.log("price(event) 실행");
      // let lastIndex = journalGrid.gridOptions.api.getFirstDisplayedRow();  //0
      // let lastRow = journalGrid.gridOptions.api.getRowNode(lastIndex);  // undifine  (dong)

      // let sum = 0;
      if (event.data["journalNo"] != "Total") {
        if (event.data["balanceDivision"] == "차변") {
          let price = prompt("차변의 금액을 입력해주세요", "");
          price = price == null ? 0 : price;
          if (!isNaN(price)) {
            journalGrid.gridOptions.api.applyTransaction([
              (event.data["rightCreditsPrice"] = 0),
            ]);
            journalGrid.gridOptions.api.applyTransaction([
              (event.data["leftDebtorPrice"] = price),
            ]);

            computeJournalTotal();
          } else {
            alert("숫자만 입력해주세요");
          }
        }
        if (event.data["balanceDivision"] == "대변") {
          let price = prompt("대변의 금액을 입력해주세요", "");
          price = price == null ? 0 : price;
          if (!isNaN(price)) {
            journalGrid.gridOptions.api.applyTransaction([
              (event.data["leftDebtorPrice"] = 0),
            ]);
            journalGrid.gridOptions.api.applyTransaction([
              (event.data["rightCreditsPrice"] = price),
            ]);

            computeJournalTotal();
          } else {
            alert("숫자만 입력해주세요");
          }
        }
      }
      let totalIndex = journalGrid.gridOptions.api.getDisplayedRowCount() - 1;
      let totalRow =
              journalGrid.gridOptions.api.getDisplayedRowAtIndex(totalIndex); // lastRow.data 이게 먹통이라 소스 수정(dong)

      if (
              totalRow.data["leftDebtorPrice"] != 0 && totalRow.data["rightCreditsPrice"] != 0
      ) {
        if (
                totalRow.data["leftDebtorPrice"] != totalRow.data["rightCreditsPrice"]
        ) {
          alert("차변과 대변이 일치하지 않으면 승인이 거부될 수 있습니다.");
        }
      }
    }

    // 계정코드 입력시 계정과목 검색
    function getAccountName(accountCode) {
      console.log("findAccountName(accountCode) 실행");
      let selectedJournalRow = JSON.parse($("#selectedJournal").val());
      console.log("getAcc@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      console.log(selectedJournalRow);

      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/operate/account",
        data: JSON.stringify({
          accountCode: accountCode,
        }),
        contentType: "application/json",
        dataType: "json",
        success: function (jsonObj) {
          journalGrid.gridOptions.api.applyTransaction([
            (selectedJournalRow["accountName"] = jsonObj.accountName),
          ]);
        },
        async: false,
      });
    }

    function showJournalGrid(slipNo) {
      //slip rowid 선택한 전표행이다
      // show loading message
      console.log("showJournalGrid(" + slipNo + ") 실행");
      let rowData2 = [];

      let journalObj = {
        journalNo: "Total", //이부분이 분개번호
        leftDebtorPrice: 0, //차변 금액
        rightCreditsPrice: 0, //대변 금액
        status: "",
      };

      let totalObject = $.extend(true, {}, journalObj);
      rowData2.push(totalObject);

      if (slipNo !== "NEW") {
        $.ajax({
          type: "POST",
          // type: "GET",
          async: false,
          url: "${pageContext.request.contextPath}/posting/singlejournallist",
          data: JSON.stringify({ slipNo: slipNo }),
          // data: { "slipNo": slipNo },
          contentType: "application/json",
          dataType: "json",
          success: function (jsonObj) {
            //선택한 전표에 등록된 분개정보
            // 계정코드가 들어가 있지 않은 데이터를 왜 안들고 올까?
            jsonObj.forEach(function (element) {
              rowData2.push(element);
            });
            jsonObj.forEach(function (element, index) {
              $.ajax({
                type: "POST",
                async: false,
                url: "${pageContext.request.contextPath}/posting/journaldetaillist",
                data: JSON.stringify({
                  journalNo: element["journalNo"], //rowid 분개번호임
                }),
                contentType: "application/json",
                dataType: "json",
                success: function (jsonObj) {
                  element.journalDetailList = jsonObj;
                },
              });
            });
          },
        });
      } else {
        let journalObj1 = {
          //분개1 생성
          journalNo: "NEWJOURNAL" + 1, //이부분이 분개번호 NEW_JOURNAL_PREFIX = NEW_SLIP_NO + "JOURNAL"
          balanceDivision: "차변",
          leftDebtorPrice: 0, //차변 금액
          rightCreditsPrice: 0, //대변 금액
          status: "insert",
        };
        let journalObj2 = {
          //분개 2 생성
          journalNo: "NEWJOURNAL" + 2, //이부분이 분개번호
          balanceDivision: "대변",
          leftDebtorPrice: 0, //차변 금액
          rightCreditsPrice: 0, //대변 금액
          status: "insert",
        };
        let newJournal1 = $.extend(true, {}, journalObj1); // 굳이 이렇게 변수에 담은다음에 배열에 넣을필요있나 ?바로넣지..? 수정하쟈(dong)
        let newJournal2 = $.extend(true, {}, journalObj2);
        rowData2.push(newJournal1);
        rowData2.push(newJournal2);
      }
      journalGrid.gridOptions.api.setRowData(rowData2);
      // add는 같은 분개정보가 계속 들어감
      // journalGrid.gridOptions.api.applyTransaction({add: rowData2});
      computeJournalTotal();
    }

    /*분개 합계 계산*/
    function computeJournalTotal() {
      console.log("computeJournalTotal 실행");
      let totalIndex = journalGrid.gridOptions.api.getDisplayedRowCount() - 1;

      //표시된 행의 총 수를 반환합니다.
      let totalRow =
              journalGrid.gridOptions.api.getDisplayedRowAtIndex(totalIndex);
      console.log("totalRow :" + JSON.stringify(totalRow.data));
      //지정된 인덱스에 표시된 RowNode를 반환합니다. 즉 마지막 total의 정보를 담고있음
      let leftDebtorTotal = 0;
      let rightCreditsTotal = 0;

      journalGrid.gridOptions.api.forEachNode(function (node, index) {
        if (node !== totalRow) {
          if (node.journalNO !== "Total") {
            leftDebtorTotal += parseInt(node.data.leftDebtorPrice);
            rightCreditsTotal += parseInt(node.data.rightCreditsPrice);
          }
        }
      });
      totalRow.setDataValue("leftDebtorPrice", leftDebtorTotal);
      totalRow.setDataValue("rightCreditsPrice", rightCreditsTotal);
    }

    function addJournalRow() {
      console.log("addJournalRow 실행");
      console.log(JSON.parse($("#selectedSlip").val()));
      console.log(JSON.parse($("#selectedSlip").val()).expenseReport);

      // 그리드에 값을 넣지 않으면 빈값이 들어가지않고 undefined 가 뜬다
      // if (JSON.parse($("#selectedSlip").val())["expenseReport"] == "") {
      if (
              JSON.parse($("#selectedSlip").val())["expenseReport"] == undefined
      ) {
        // 전표 셀의 값을 변경하면 다시 선택해서 선택된 전표정보를 다시 저장해야함
        // 전표 그리드 옵션에 셀의 값이 변경되면 다시 저장하게끔 코드를 넣어야함
        alert("적요란을 기입하셔야 합니다.");
        return;
      }
      let journal =
              journalGrid.gridOptions.api.getDisplayedRowCount() == 0
                      ? 1
                      : journalGrid.gridOptions.api.getDisplayedRowCount(); // 현재 보여지는 로우의 수를 반환
      let journalObj = {
        journalNo: "NEWJOURNAL" + journal, //이부분이 분개번호
        leftDebtorPrice: 0, //차변 금액
        rightCreditsPrice: 0, //대변 금액
        status: "insert",
      };
      let newObject2 = $.extend(true, {}, journalObj);
      journalGrid.gridOptions.api.applyTransaction({ add: [newObject2] });

      enableElement({
        "#addSlip": false,
        "#deleteSlip": true,
        "#addJournal": true,
        "#deleteJournal": true,
        "#showPDF": true,
      });
    }

    function deleteJournal() {
      let selectedSlipRow = JSON.parse($("#selectedSlip").val());
      let selectedJournalRow = JSON.parse($("#selectedJournal").val());

      if (selectedJournalRow == null || selectedSlipRow.slipNo == "NEW") {
        if (selectedJournalRow == null) {
          alert("삭제할 분개를 선택해주세요.");
          console.log("selectedJournalRow", selectedJournalRow);
        } else {
          alert("NEW 차변,대변은 삭제할 수 없습니다");
        }
      } else {
        $.ajax({
          type: "POST",
          url: "${pageContext.request.contextPath}/posting/journalremoval",
          data: JSON.stringify({
            journalNo: selectedJournalRow["journalNo"],
          }),
          contentType: "application/json",
          success: function () {
            console.log("deleteJournal성공");

            enableElement({
              "#addSlip": true,
              "#deleteSlip": true,
              "#addJournal": true,
              "#deleteJournal": true,
              "#showPDF": false,
            });
            //selectedRows.forEach(function (selectedRow, index) { //forEach 배열의 반복문
            journalGrid.gridOptions.api.applyTransaction({
              remove: [selectedJournalRow],
            }); // db에 저장된 분개 삭제  (choi)
            //});
          },
        });
        //showJournalGrid(selectedSlipRow.slipNo);  // 호출안해도 될것같은데ㅔ; ? (dong)
      }
    }
    // End of Journal -----------------------------------------------------------------------------------------------------------------

    let accountGrid;

    function createAccountGrid() {
      //분개의 계정과목 왼쪽 부모그리드 생성
      // let rowData = [];
      const columnDefs = [
        {
          headerName: "계정과목 코드",
          field: "accountInnerCode",
          sort: "asc",
          width: 120,
          resizable: true,
          cellClass: "grid-cell-centered",
        }, //셀의 내용을 중심에 맞춤
        {
          headerName: "계정과목",
          field: "accountName",
          resizable: true,
          cellClass: "grid-cell-centered",
        },
      ];
      const gridOptionsAccount = {
        columnDefs: columnDefs,
        rowSelection: "single", //row는 하나만 선택 가능
        defaultColDef: { editable: false }, // 정의하지 않은 컬럼은 자동으로 설정
        onGridReady: function (event) {
          // onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
          event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function (event) {
          // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
          event.api.sizeColumnsToFit();
        },
        onRowClicked: function (event) {
          console.log("계정과목그리드 onRowClicked 실행");
          showAccountDetail(event.data["accountInnerCode"]);
        },
      };
      accountGrid = new agGrid.Grid(
              document.querySelector("#accountGrid"),
              gridOptionsAccount
      );
      showAccount();
    }

    function showAccount() {
      //부모코드 조회함
      $.ajax({
        type: "GET",
        url: "${pageContext.request.contextPath}/operate/parentaccountlist",
        data: {},
        dataType: "json",
        success: function (jsonObj) {
          accountGrid.gridOptions.api.setRowData(jsonObj); //gridOptionsAccount에 값 붙임
        },
      });
    }

    let accountDetailGrid;

    function createAccountDetailGrid() {
      console.log("createAccountDetailGrid() 실행");

      const columnDefs = [
        {
          headerName: "계정과목 코드",
          field: "accountInnerCode",
          width: 120,
          sortable: true,
          resizable: true,
        },
        {
          headerName: "계정과목",
          field: "accountName",
          sortable: true,
          resizable: true,
        },
      ];

      const gridOptionsAccountDetail = {
        columnDefs: columnDefs,
        rowSelection: "single", //row는 하나만 선택 가능
        defaultColDef: { editable: false }, // 정의하지 않은 컬럼은 자동으로 설정
        /*                             pagination: true, // 페이저
                                                paginationPageSize: 15, // 페이저에 보여줄 row의 수 */
        onGridReady: function (event) {
          // onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
          event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function (event) {
          // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
          event.api.sizeColumnsToFit();
        },
        onCellDoubleClicked: function (event) {
          $("#accountGridModal").modal("hide");
          let selectedJournalRow = JSON.parse($("#selectedJournal").val());

          console.log("onCellDoubleClicked=========================");
          console.log(event);
          console.log(event.data);
          console.log(event.data["accountInnerCode"]);
          console.log(event.data["accountName"]);
          console.log(selectedJournalRow);
          console.log(selectedJournalRow.accountCode);
          console.log(selectedJournalRow["accountName"]);
          console.log(journalGrid);
          console.log(journalGrid.gridOptions);

          selectedJournalRow["accountCode"] = event.data["accountInnerCode"];
          selectedJournalRow["accountName"] = event.data["accountName"];
          console.log(selectedJournalRow);

          journalGrid.gridOptions.api.applyTransaction({update: [(selectedJournalRow)]});
          journalGrid.gridOptions.api.applyTransaction({update: [(selectedJournalRow)]});

          // journalGrid.gridOptions.api.applyTransaction([
          //   (selectedJournalRow["accountCode"] = event.data["accountInnerCode"]),
          // ]);
          // journalGrid.gridOptions.api.applyTransaction([
          //   (selectedJournalRow["accountName"] = event.data["accountName"]),
          // ]);
          console.log(selectedJournalRow);
          console.log("event.data[accountInnerCode] :" + event.data["accountInnerCode"]);
          $.ajax({
            //여기서부터는 분개상세
            type: "POST",
            url: "${pageContext.request.contextPath}/operate/accountcontrollist",
            data: JSON.stringify({
              accountCode: event.data["accountInnerCode"], //이값이 겁색한 값이다. ex)매출
            }),
            dataType: "json",
            contentType: "application/json",
            success: function (jsonObj) {
              // AccountDTO 를 가져옴
              console.log(jsonObj);
              // console.log(jsonObj[0]["accountControlCode"]);
              // console.log(jsonObj[1].accountControlCode);
              // gridOptions2.api.applyTransaction([selectedJournalRow['journalDetail']=jsonObj['accountControl']]);
              console.log(selectedJournalRow["journalNo"]);

              // jsonObj['accountControl'].forEach(function (element, index) { //분개상세 key값
              jsonObj.forEach(function (element, index) {
                //분개상세 key값
                console.log(element);
                element["journalNo"] = selectedJournalRow["journalNo"]; //요소추가?
              });
              selectedJournalRow["journalDetailList"] = jsonObj;
              // AccountDTO 에는 accountControl 가 없다
              // console.log(jsonObj['accountControl']);
              journalGrid.gridOptions.api.applyTransaction({update: [selectedJournalRow]});

              $("#selectedJournal").val(JSON.stringify(selectedJournalRow));
              console.log($("#selectedJournal").val());

              console.log(
                      "selectedJournalRow :" + selectedJournalRow.journalNo
              );
              journalGrid.gridOptions.api.redrawRows(); //행 다시 그리기
            },
          });
        },
      };
      accountDetailGrid = new agGrid.Grid(document.querySelector("#accountDetailGrid"), gridOptionsAccountDetail); //div 태그에 붙임
    }

    function showAccountDetail(accountCode) {
      //code 에 selectedRow["accountInnerCode"] 값 들어감
      $.ajax({
        type: "GET",
        url: "${pageContext.request.contextPath}/operate/detailaccountlist",
        data: {
          code: accountCode,
        },
        dataType: "json",
        success: function (jsonObj) {
          accountDetailGrid.gridOptions.api.setRowData(jsonObj);
        },
      });
    }

    ///  모달 내부에서 검색
    function searchAccount() {
      console.log("searchAccount() 실행");
      // show loading message
      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/operate/accountlistbyname",
        data: JSON.stringify({
          accountName: $("#accountCode").val(), //이값이 겁색한 값이다. ex)매출
        }),
        dataType: "json",
        contentType: "application/json",
        success: function (jsonObj) {
          console.log(jsonObj);
          accountDetailGrid.gridOptions.api.setRowData(jsonObj); //내부 상세 그리드
          $("#accountCode").val(""); // 검색한다음에 지우기 셋팅(dong)
        },
      });
    }

    let codeGrid;
    function createCodeGrid() {
      console.log("createCodeGrid() 실행");
      // let rowData = [];
      const columnDefs = [
        {
          headerName: "코드",
          field: "detailCode",
          width: 100,
          sortable: true,
        },
        {
          headerName: "부서이름",
          field: "detailCodeName",
          width: 100,
          sortable: true,
        },
      ];
      const gridOptions = {
        columnDefs: columnDefs,
        rowSelection: "single", //row는 하나만 선택 가능
        defaultColDef: {
          editable: false,
        }, // 정의하지 않은 컬럼은 자동으로 설정
        onGridReady: function (event) {
          // onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
          event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function (event) {
          // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
          event.api.sizeColumnsToFit();
        },
        onRowClicked: function (event) {
          console.log("onRowClicked 실행");
          let detailCodeName = event.data["detailCodeName"];
          let detailCode = event.data["detailCode"];
          let selectedJournalDetail = JSON.parse($("#selectedJournalDetail").val());
          console.log(detailCodeName);
          console.log(selectedJournalDetail);

          selectedJournalDetail["journalDescription"] = detailCodeName;
          selectedJournalDetail["journalDescriptionCode"] = detailCode;
          let detailGrid = journalGrid.gridOptions.api.getDetailGridInfo("detail_" + selectedJournalDetail.journalNo);
          console.log(detailGrid);
          detailGrid.api.applyTransaction({update: [selectedJournalDetail]});

          $("#selectedJournalDetail").val(JSON.stringify(selectedJournalDetail));

          // journalDetailGrid.gridOptions.api.applyTransaction([
          //   (selectedJournalDetail["journalDescription"] = detailCodeName),
          // ]); //journalDescription 분개상세내용
          // journalDetailGrid.gridOptions.api.applyTransaction([
          //   (selectedJournalDetail["journalDescriptionCode"] = detailCode),
          // ]);
          saveJournalDetailRow();
          // journalGrid.gridOptions.api.getDetailGridInfo("detail_" + selectedJournalRow);
          $("#codeModal").modal("hide");
        },
      };
      codeGrid = new agGrid.Grid(document.querySelector("#codeGrid"), gridOptions);
    }

    let customerCodeGrid;
    function createCustomerCodeGrid() {
      // let rowDataCode = [];

      const columnDefs = [
        {
          headerName: "사업장 코드",
          field: "workplaceCode",
          width: 100,
          hide: true,
        },
        { headerName: "거래처 코드", field: "companyCode", width: 100 },
        { headerName: "사업장명", field: "workplaceName", width: 100 },
        {
          headerName: "대표자명",
          field: "workplaceCeoName",
          width: 100,
          hide: true,
        },
        {
          headerName: "업태",
          field: "businessConditions",
          width: 100,
          hide: true,
        },
        {
          headerName: "사업자등록번호",
          field: "businessLicense",
          width: 100,
        },
        {
          headerName: "법인등록번호",
          field: "corporationLicence",
          width: 100,
          hide: true,
        },
        {
          headerName: "사업장전화번호",
          field: "workplaceTelNumber",
          hide: true,
        },
        {
          headerName: "승인상태",
          field: "approvalStatus",
          width: 100,
          hide: true,
        },
      ];
      const gridOptions = {
        columnDefs: columnDefs,
        rowSelection: "single", //row는 하나만 선택 가능
        defaultColDef: { editable: false }, // 정의하지 않은 컬럼은 자동으로 설정
        pagination: true, // 페이저
        paginationPageSize: 10, // 페이저에 보여줄 row의 수
        onGridReady: function (event) {
          // onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
          event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function (event) {
          // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
          event.api.sizeColumnsToFit();
        },
        //cell double click
        onCellDoubleClicked: function (event) {
          $("#customerCodeModalGrid").modal("hide");
          let selectedJournalRow = JSON.parse($("#selectedJournal").val());
          selectedJournalRow["customerName"] = event.data["workplaceName"];
          selectedJournalRow["customerCode"] = event.data["companyCode"]; // 2
          journalGrid.gridOptions.api.applyTransaction({update: [selectedJournalRow]}); // 1
        },
      };
      customerCodeGrid = new agGrid.Grid(
              document.querySelector("#customerCodeGrid"),
              gridOptions
      );
    }

    //분개 상세 부서조회에서의 코드조회
    function searchCode() {
      console.log("searchCode 실행");
      let selectedJournalDetail = JSON.parse($("#selectedJournalDetail").val());
      console.log(selectedJournalDetail);
      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/base/detailcodelist",
        data: JSON.stringify({
          divisionCodeNo: selectedJournalDetail["accountControlDescription"], //accountControlDescription = ACCOUNT_CONTROL_DETAIL의 Description
          detailCodeName: $("#searchCode").val(), //부서 입력한 값
        }),
        contentType: "application/json",
        dataType: "json",
        success: function (jsonObj) {
          // gridOptions5.api.setRowData(jsonObj.detailCodeList); #1
          // createCodeGrid();
          console.log(codeGrid);
          codeGrid.gridOptions.api.setRowData(jsonObj);
          $("#searchCode").val("");
        },
        async: false,
      });
    }

    //거래처코드
    function searchCustomerCodeList() { // 거래처리스트 불러오기

      $.ajax({
        type    : "GET",
        url     : "${pageContext.request.contextPath}/operate/allworkplacelist",
        data    : {},
        dataType: "json",
        success : function (jsonObj) {
          //console.log("거래처코드 : " +JSON.stringify(jsonObj.allWorkplaceList));
          customerCodeGrid.gridOptions.api.setRowData(jsonObj);

        }
      });
    }
  </script>
</head>

<body class="bg-gradient-primary">
<h4>전표</h4>
<hr />
<div class="row">
  <input
          id="from"
          type="date"
          class="date"
          required
          style="margin-left: 12px"
  />
  <input id="to" type="date" class="date" required />
  <select id="selTag" class="date" id="selTag">
    <option>승인여부</option>
    <option>작성중</option>
    <option>승인요청</option>
    <option>승인완료</option>
    <option>작성중(반려)</option>
  </select>
  <input
          type="button"
          id="search"
          value="검색"
          class="btn btn-Light shadow-sm btnsize2"
          style="margin-left: 5px"
  />
</div>
<div>
  <div style="text-align: right">
    <input
            type="button"
            id="addSlip"
            value="전표 추가(F2)"
            class="btn btn-Light shadow-sm btnsize"
    />
    <input
            type="button"
            id="deleteSlip"
            value="전표 삭제"
            class="btn btn-Light shadow-sm btnsize"
    />

    <input
            type="button"
            id="showPDF"
            value="PDF보기"
            class="btn btn-Light shadow-sm btnsize"
    />
    <input
            type="button"
            id="saveSlip"
            value="전표 저장(F3)"
            class="btn btn-Light shadow-sm btnsize"
    />
    <input
            type="button"
            id="confirm"
            value="결재 신청(F4)"
            class="btn btn-Light shadow-sm btnsize"
    />
  </div>
</div>
<div>
  <!-- 셀정렬 -->
  <div
          id="slipGrid"
          class="ag-theme-balham"
          style="height: 250px; width: auto"
  ></div>
  <%-- 선택된 전표의 정보를 저장하는데 쓰임--%>
  <input type="text" id="selectedSlip" style="display: none" />
</div>
<hr />
<h3>분개</h3>
<div>
  <input
          type="button"
          id="addJournal"
          value="분개 추가"
          class="btn btn-Light shadow-sm btnsize"
  />
  <input
          type="button"
          id="deleteJournal"
          value="분개 삭제"
          class="btn btn-Light shadow-sm btnsize"
  />
  <div
          id="journalGrid"
          class="ag-theme-balham"
          style="height: 450px; width: auto"
  ></div>
  <%-- 선택된 분개의 정보를 저장하는데 쓰임--%>
  <input type="text" id="selectedJournal" style="display: none" />
  <%-- 선택된 분개상세의 정보를 저장하는데 쓰임--%>
  <input type="text" id="selectedJournalDetail" style="display: none" />
</div>

<div
        class="modal fade"
        id="accountGridModal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="accountGridLabel"
        style="padding-right: 210px"
>
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="width: 645px; margin-top: 130px">
      <div class="modal-header">
        <h5 class="modal-title" id="accountGridLabel">계정 코드 조회</h5>
        <button
                class="close"
                type="button"
                data-dismiss="modal"
                aria-label="Close"
        >
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-header">
        <input
                type="text"
                class="form-control bg-light border-0 small"
                placeholder="계정과목을 입력해주세요"
                id="accountCode"
                aria-label="AccountSearch"
                aria-describedby="basic-addon2"
        />
        <div class="input-group-append">
          <button class="btn btn-primary" type="button" id="Accountbtn">
            <i class="fas fa-search fa-sm"></i>
          </button>
        </div>
      </div>
      <div class="modal-body">
        <div style="float: left; width: 50%">
          <div>
            <!-- 셀 정렬 -->
            <div
                    id="accountGrid"
                    class="ag-theme-balham"
                    style="height: 500px; width: 100%; margin-left: -10px"
            ></div>
          </div>
        </div>

        <div style="float: left; width: 50%">
          <div>
            <!-- 셀 정렬 -->
            <div
                    id="accountDetailGrid"
                    class="ag-theme-balham"
                    style="height: 500px; width: 100%; margin-left: 5px"
            ></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div
        class="modal fade"
        id="codeModal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="codeLabel"
>
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="codeLabel">부서 코드 조회</h5>
        <button
                class="close"
                type="button"
                data-dismiss="modal"
                aria-label="Close"
        >
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-header">
        <input
                type="text"
                class="form-control bg-light border-0 small"
                placeholder="부서를 입력해주세요"
                id="searchCode"
                aria-label="deptSearch"
                aria-describedby="basic-addon2"
        />
        <div class="input-group-append">
          <button class="btn btn-primary" type="button" id="searchCodebtn">
            <i class="fas fa-search fa-sm"></i>
          </button>
        </div>
      </div>
      <div class="modal-body">
        <div
                id="codeGrid"
                class="ag-theme-balham"
                style="width: auto; height: 150px"
        ></div>
      </div>
    </div>
  </div>
</div>
<!-- 거래처 코드 -->
<div
        class="modal fade"
        id="customerCodeModalGrid"
        tabindex="-1"
        role="dialog"
        aria-labelledby="customerCodeModalGrid"
>
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="width: 700px">
      <div class="modal-header">
        <h5 class="modal-title" id="customerCodeModalLabel">거래처 코드</h5>
        <button
                class="close"
                type="button"
                data-dismiss="modal"
                aria-label="Close"
        >
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div>
          <!-- 셀 정렬 -->
          <div
                  id="customerCodeGrid"
                  class="ag-theme-balham"
                  style="height: 500px; width: 100%; margin-left: -10px"
          ></div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
