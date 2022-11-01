<%--
  Created by IntelliJ IDEA.
  User: qkek8
  Date: 2022-08-05
  Time: 오후 7:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">

    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

    <!-- validate -->

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/assets/plugins/jquery.validate.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/assets/plugins/functionValidate.js"></script>
    <style type="text/css">
        input.error, text.error {
            border: 2px solid #FD7D86;
        }

        label.error {
            color: #FD7D86;
            font-weight: 400;
            font-size: 0.75em;
            margin-top: 7px;
            margin-left: 6px;
            margin-right: 6px;
        }

        .btnsize{
            width: 80px;
            height:30px;
            font-size:0.8em;
            font-align:center;
            color:black;
        }
        .btnsize2{
            width: 60px;
            height:30px;
            font-size:0.9em;
            color:black;
        }
        .modal-dialog.workplce{
            width: 100%; height: 100%; margin: 0; padding: 0;
        }

    </style>
    <script>
        $(document).ready(function () {
            $('input:button').hover(function() {
                $(this).css("background-color","#D8D8D8");//버튼 hover이벤트 색상변경
            }, function(){
                $(this).css("background-color","");
            });

            createAccountPeriod();
            $("#searchPeriod").click(showAccountPeriod);//버튼 누를시

            createWorkplace();
            $("#searchWorkplace").click(showWorkplace);//버튼 누를시

            createDepartment();//그리드생성 사업장,부서

            createParentBudget();//그리드생성 계정과목코드,계정과목
            createBudgetComparison();

        });

        var dataSet={
            "deptCode":"",
            "workplaceCode":"",
            "accountInnerCode":"",
            "accountPeriodNo":"",
            "fiscalYear":"",
            "budgetingCode":"1",
            "m1Budget":"",
            "m2Budget":"",
            "m3Budget":"",
            "m4Budget":"",
            "m5Budget":"",
            "m6Budget":"",
            "m7Budget":"",
            "m8Budget":"",
            "m9Budget":"",
            "m10Budget":"",
            "m11Budget":"",
            "m12Budget":""
        };

        function createAccountPeriod(){//회계연도
            rowData=[];
            var columnDefs = [
                {headerName: "회계기수", hide:"true" ,field: "accountPeriodNo",sort:"asc", width:100
                },
                {headerName: "회계연도", field: "fiscalYear",sort:"asc", width:100
                },
                {headerName: "회계시작일", field: "periodStartDate",width:250},
                {headerName: "회계종료일", field: "periodEndDate",width:250},
            ];
            gridOptions3 = {
                columnDefs: columnDefs,
                rowSelection:'single', //row는 하나만 선택 가능
                defaultColDef: {editable: false }, // 정의하지 않은 컬럼은 자동으로 설정
                onGridReady: function (event){// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
                    event.api.sizeColumnsToFit();//사이즈 맞춰줌
                },
                onGridSizeChanged:function (event){ // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
                    event.api.sizeColumnsToFit(); //사이즈 맞춰줌
                },
                onRowClicked:function (event){//클릭시
                    console.log("Row선택");
                    console.log(event.data);
                    selectedRow=event.data;//이벤트가 일어난 행의 정보
                    $("#fiscalYear").val(selectedRow["fiscalYear"]);//선택한 행의 연도
                    $("#accountYearModal").modal("hide");//모달창을 하이드시킴
                    dataSet["fiscalYear"]=selectedRow["fiscalYear"];
                    checkElement();//호출
                    console.log("dataSet"+dataSet["accountPeriodNo"]);
                    console.log("selectedRow"+selectedRow["accountPeriodNo"]);
                    dataSet["accountPeriodNo"]=selectedRow["accountPeriodNo"];//내가 선택한 연도

                }
            }
            accountGrid = document.querySelector('#accountYearGrid');
            new agGrid.Grid(accountGrid,gridOptions3);//ag그리드 생성
        }

        function showAccountPeriod(){//show로 이름이 정의되어있지만 값을 넣는것임

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/operate/accountperiodlist",
                data: {
                },
                dataType: "json",
                async:false,
                success: function (jsonObj) {
                    console.log(jsonObj);
                    gridOptions3.api.setRowData(jsonObj);//회계 연도에 값 넣음
                }
            });

        }

        function createWorkplace(){
            rowData=[];
            var columnDefs = [
                {headerName: "사업장코드", field: "workplaceCode",sort:"asc", width:200
                },
                {headerName: "사업장명", field: "workplaceName",width:250},
            ];
            gridOptions4 = {
                columnDefs: columnDefs,
                rowSelection:'single', //row는 하나만 선택 가능
                defaultColDef: {editable: false }, // 정의하지 않은 컬럼은 자동으로 설정
                onGridReady: function (event){// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
                    event.api.sizeColumnsToFit();
                },
                onGridSizeChanged:function (event){ // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
                    event.api.sizeColumnsToFit();
                },
                onRowClicked:function (event){
                    console.log("Row선택");
                    console.log(event.data);
                    selectedRow=event.data;
                    showDepartment(selectedRow["workplaceCode"]);//내가 선택한 사업장 번호
                    console.log(selectedRow["workplaceName"]);

                }
            }
            workplaceGrid = document.querySelector('#workplaceGrid');
            new agGrid.Grid(workplaceGrid,gridOptions4);
        }

        /* ag-Grid 선택된 열의 레코드 반환하는 함수
        function getSelectedRows() {
               var selectedNodes = gridOptions4.api.getSelectedNodes()
               var selectedData = selectedNodes.map( function(node) { return node.data })
               var selectedDataStringPresentation = selectedData.map( function(node) { return node.workplaceName })
               alert('Selected nodes: ' + selectedDataStringPresentation);
           }
        */
        function createDepartment(){//사업장,부서그리드
            rowData=[];
            var columnDefs = [
                {headerName: "사업장코드", hide:"true",field: "workplaceCode",sort:"asc", width:100
                },
                {headerName: "사업장명", hide:"true", field: "workplaceName",width:250},
                {headerName: "부서코드", field: "deptCode",sort:"asc", width:200
                },
                {headerName: "부서명", field: "deptName",width:250},
            ];
            gridOptions5 = {
                columnDefs: columnDefs,
                rowSelection:'single', //row는 하나만 선택 가능
                defaultColDef: {editable: false }, // 정의하지 않은 컬럼은 자동으로 설정
                onGridReady: function (event){// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
                    event.api.sizeColumnsToFit();
                },
                onGridSizeChanged:function (event){ // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
                    event.api.sizeColumnsToFit();
                },
                onRowClicked:function (event){//행을 클릭시
                    console.log("여기");
                    console.log("Row선택");
                    console.log(event.data);
                    selectedRow=event.data;//선택한행 정보
                    $("#workplace").val(selectedRow["workplaceName"]);//선택한 사업장명
                    $("#dept").val(selectedRow["deptName"]);//선택한 부서명
                    $("#workplaceModal").modal("hide");//모달창 닫힘
                    console.log(selectedRow["deptName"])
                    dataSet["workplaceCode"]=selectedRow["workplaceCode"];//dataSet에 내가선택한 사업장이 담김
                    dataSet["deptCode"]=selectedRow["deptCode"];//dataset에 내가 선택한 부서번호가 담김
                    console.log(dataSet["workplaceCode"]);
                    console.log(dataSet["deptCode"]);
                    checkElement();//회계연도,사업장,부서 모두 클릭 했는지 여부
                }
            }
            deptGrid = document.querySelector('#deptGrid');
            new agGrid.Grid(deptGrid,gridOptions5);//사업장그리드 생성
        }

        function showWorkplace(){
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/operate/deptlist",
                data: {
                },
                dataType: "json",
                async:false,
                success: function (jsonObj) {//brc-02-삼성중앙연구소,brc-01-삼성월스토리
                    console.log(jsonObj);
                    gridOptions4.api.setRowData(jsonObj);//결과값을 행에 추가
                }
            });
        }

        function showDepartment(workplaceCode){//내가 선택한 사업장 코드
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/operate/detaildeptlist",
                data: {
                    "method": "findDetailDeptList",
                    "workplaceCode":workplaceCode,
                },
                dataType: "json",
                async:false,
                success: function (jsonObj) {//사업자코드에 맞는 사업소명,부서코드,부서명가져옴
                    console.log(jsonObj);
                    gridOptions5.api.setRowData(jsonObj);//데이터를 행에추가
                }
            });
        }

        function createParentBudget(){

            rowData=[];
            var columnDefs = [
                {headerName: "계정코드", field: "accountInnerCode",sort:"asc", width:150
                },
                {headerName: "계정과목명", field: "accountName",width:250},
            ];
            gridOptions = {
                columnDefs: columnDefs,
                rowSelection:'single', //row는 하나만 선택 가능
                defaultColDef: {editable: false }, // 정의하지 않은 컬럼은 자동으로 설정
                onGridReady: function (event){// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
                    event.api.sizeColumnsToFit();
                },
                onGridSizeChanged:function (event){ // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
                    event.api.sizeColumnsToFit();
                },
                onRowClicked:function (event){
                    console.log("Row선택");
                    console.log(event.data);
                    selectedRow=event.data;
                    showDetailBudget(selectedRow["budgetInnerCode"]);

                }
            }
            accountGrid = document.querySelector('#parentBudgetGrid');
            new agGrid.Grid(accountGrid,gridOptions);
        }

        function showParentBudget(){

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/operate/parentbudgetlist2",
                    data: {
                        "workplaceCode":dataSet["workplaceCode"],
                        "deptCode":dataSet["deptCode"],
                        "accountPeriodNo":dataSet["accountPeriodNo"]
                    },
                dataType: "json",
                async:false,
                success: function (jsonObj) {
                    console.log(jsonObj);
                    gridOptions.api.setRowData(jsonObj);
                }
            });

        }

        function checkElement(){//회계연도,사업장,부서가 다입력되어있을시 왼쪽 그리드를 호출하는 로직
            if($("#fiscalYear").val()&&$("#workplace").val()&&$("#dept").val()){
                console.log("dataSet"+JSON.stringify(dataSet));
                console.log("dataSet1"+dataSet["workplaceCode"]);
                console.log("dataSet2"+dataSet["deptCode"]);
                showParentBudget();}//왼쪽 그리드
        }

        function createBudgetComparison(){
            rowData=[];
            var columnDefs = [
                {headerName: "구분", field: "budgetDate",sort:"asc", width:100},
                {headerName: "신청예산", field: "insertBudgetAccount",width:100},
                {headerName: "편성예산", field: "compilationBudget",width:100},
                {headerName: "실행예산", field: "executionBudget",width:100},
                {headerName: "집행실정", field: "executionConditions",width:100},
                {headerName: "예실대비", field: "budgetAccountComparison",width:100},
            ];
            gridOptions2 = {
                columnDefs: columnDefs,
                rowSelection:'single', //row는 하나만 선택 가능
                defaultColDef: {editable: false }, // 정의하지 않은 컬럼은 자동으로 설정
                onGridReady: function (event){// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
                    event.api.sizeColumnsToFit();
                },
                onGridSizeChanged:function (event){ // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
                    event.api.sizeColumnsToFit();
                },
                onRowClicked:function (event){
                    console.log("Row선택");
                    console.log(event.data);
                    selectedRow=event.data;
                    showDetailBudget(selectedRow["budgetInnerCode"]);

                }
            }
            ComparisonGrid = document.querySelector('#comparisonBudgetGrid');
            new agGrid.Grid(ComparisonGrid,gridOptions2);
        };



    </script>
</head>
<title>예실대비현황</title>
<body>
<h4>예실대비현황</h4>
<hr>
<div class="row">
    <div  class="col-sm-4 mb-3 mb-sm-0 input-group">
        <label for="example-text-input" class="col-form-label">회계연도</label>
        <input   style="margin-left: 5px" type="text" class="border-0 small form-control form-control-user" id="fiscalYear" placeholder="fiscalYear" disabled="disabled">

        <div class="input-group-append">
            <button class="btn btn-primary" type="button" data-toggle="modal"
                    data-target="#accountYearModal" id="searchPeriod">
                <i class="fas fa-search fa-sm"></i>
            </button>
        </div>
    </div>

    <div class="col-sm-4 mb-3 mb-sm-0 input-group">
        <label for="example-text-input" class="col-form-label">사업장</label>
        <input style="margin-left: 5px" type="text" class="border-0 small form-control form-control-user" id="workplace" placeholder="workplace" disabled="disabled">

        <div class="input-group-append">
            <button title="사업장, 부서 검색" class="btn btn-primary" type="button" data-toggle="modal"
                    data-target="#workplaceModal" id="searchWorkplace">
                <i class="fas fa-search fa-sm"></i>
            </button>
        </div>
    </div>
    <div class="col-sm-3 mb-3 mb-sm-0 input-group">
        <label for="example-text-input" class="col-form-label">부서</label>
        <input style="margin-left: 5px" type="text" class="border-0 small form-control form-control-user" id="dept" placeholder="부서명" disabled="disabled">

        <!--  부서 검색 버튼
                          <div class="input-group-append">
                              <button class="btn btn-primary" type="button" data-toggle="modal"
                                  data-target="#deptModal" id="searchDept">
                                  <i class="fas fa-search fa-sm"></i>
                              </button>
                          </div>
                        </div>

        -->
    </div>
    <hr>
    <!--
<table style="width:100%;">
<tr>
<td>
<div align="left" style="padding:10px;">
<div align="center">
<div id="parentBudgetGrid" class="ag-theme-balham"  style="height:250px;width:auto;" ></div>
</div>
</div>
</td>
<td>
<div align="right" style="padding:10px;">
<div align="center">
<div id="detailBudgetGrid" class="ag-theme-balham" style="height:250px;width:auto;"></div>
</div>
</div>
</td>
</tr>
</table>
-->
    <div style="width:100%;"><hr></div>
    <hr><br>
    <div align="center" style="float:left; width:40%; display:inline">
            <div id="parentBudgetGrid" class="ag-theme-balham"  style="margin-right:10px;height:250px;width:auto;" ></div>
            <div id="comparisonBudgetGrid" class="ag-theme-balham" style="margin-right:10px;height:400px;width:1000px;"></div>
    </div>
    <br>



    <div align="center" class="modal fade" id="accountYearModal" tabindex="-1"
         role="dialog" aria-labelledby="accountLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="accountYearModal">회계연도</h5>
                    <button class="close" type="button" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <hr>
                <div class="modal-body" >
                    <div style="float: center; width: 100%;">
                        <div align="center">
                            <div id="accountYearGrid" class="ag-theme-balham"
                                 style="height: 400px; width: auto;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div align="left" class="modal fade" id="workplaceModal" tabindex="-1"
         role="dialog" aria-labelledby="workplaceLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" align="left" style="width:600px; height:100%;"> <!-- 모달 크기 조절 -->
                <div class="modal-header">
                    <h5 class="modal-title" id="workplaceModal">사업장, 부서</h5>
                    <button class="close" type="button" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <hr>
                <div class="modal-body" >
                    <div style="float: left; width: 50%;">
                        <div align="center">
                            <div id="workplaceGrid" class="ag-theme-balham"
                                 style="height: 400px; width: auto;"></div>
                        </div>
                    </div>
                    <div style="float: left; width: 50%;">
                        <div align="center">
                            <div id="deptGrid" class="ag-theme-balham"
                                 style="height: 400px; width: auto;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div align="center" class="modal fade" id="deptModal" tabindex="-1"
         role="dialog" aria-labelledby="deptLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deptModal">부서</h5>
                    <button class="close" type="button" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <hr>
                <div class="modal-body" >
                    <div style="float: left; width: 50%;">
                        <div align="center">
                            <div id="parentDeptGrid" class="ag-theme-balham"
                                 style="height: 400px; width: auto;"></div>
                        </div>
                    </div>
                    <div style="float: left; width: 50%;">
                        <div align="center">
                            <div id="detailDeptGrid" class="ag-theme-balham"
                                 style="height: 400px; width: auto;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
