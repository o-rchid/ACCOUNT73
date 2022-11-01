<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>계정과목</title>

    <script
            src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet"
          href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet"
          href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">

    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <style>
        .ag-header-cell-label {
            justify-content: center;
        }

        /*글자 밑에 있는거 중앙으로  */
        .ag-row .ag-cell {
            display: flex;
            justify-content: center !important; /* align horizontal */
            align-items: center !important;
        }

        .ag-theme-balham .ag-cell, .ag-icon .ag-icon-tree-closed::before {
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
        let data = []
        $(document).ready(function () {
            createAccount();
            showAccount();

        });
        var selectedRow;

        /* 게시글 ag-grid에 뿌리는 로직임다 */
        function createAccount() {
            rowData = [];
            var columnDefs = [{
                headerName: "글 번호",
                field: "id",
                sort: "asc",
                width: 100
            }, {
                headerName: "제목",
                field: "title",
                width: 500,
                onCellClicked: function open() {
                    $("#codeModal").modal('show');
                }
            },

                {
                    headerName: "작성자",
                    field: "writtenBy",
                    width: 250
                }, {
                    headerName: "작성 날짜",
                    field: "writeDate",
                    width: 250
                }, {
                    headerName: "조회수",
                    field: "lookup",
                    width: 75
                }];
            gridOptions = {
                columnDefs: columnDefs,
                rowSelection: 'single', //row는 하나만 선택 가능
                defaultColDef: {
                    editable: false
                }, // 정의하지 않은 컬럼은 자동으로 설정
                onGridReady: function (event) {// onload 이벤트와 유사 ready 이후 필요한 이벤트 삽입한다.
                    event.api.sizeColumnsToFit();
                },
                onGridSizeChanged: function (event) { // 그리드의 사이즈가 변하면 자동으로 컬럼의 사이즈 정리
                    event.api.sizeColumnsToFit();
                },
                onRowClicked: function (event) {
                    console.log("Row선택");
                    console.log(event.data);
                    selectedRow = event.data;

                    const id = event.data.id;
                    showDetailBoard(id);
                    showreply(id);
                    console.log(event.data.id);

                }
            }
            accountGrid = document.querySelector('#accountGrid');
            new agGrid.Grid(accountGrid, gridOptions);
        }

        /* 게시판 select 함수임다 */
        function showAccount() {
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/base/boardlist",
                dataType: "json",
                data: [],
                success: function (jsonObj) {
                    console.log(jsonObj);
                    gridOptions.api.setRowData(jsonObj);
                }
            });
        }



        /* 게시물 select detail임다~ */
        function showDetailBoard(id) {
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/base/boardDetailList",
                dataType: "json",
                data: {"id": id},
                success: function (jsonObj) {
                    console.log(jsonObj);
                    $("#title").attr("value", jsonObj[0].title);
                    $("#id").attr("value", jsonObj[0].id);
                    $("#lookup").attr("value", jsonObj[0].lookup);
                    $("#writer").attr("value", jsonObj[0].writtenBy);
                    $("#writtenday").text(jsonObj[0].writeDate);
                    const textarea = document.querySelector("#textarea");
                    textarea.value = jsonObj[0].contents;
                    if(jsonObj[0].fileOriName!=null){
                        showDetailBoard1(id);
                    }
                    $("#fOname").attr("value", jsonObj[0].fileOriName);
                    document.querySelector("#fOname").innerHTML="";
                }
            });
        }

        let oriname = [];
        function showDetailBoard1(id) {
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/base/boardDetailList1",
                dataType: "json",
                data: {"id": id},
                success: function (jsonObj) {
                    console.log(jsonObj);
                    $("#title").attr("value", jsonObj[0].title);
                    $("#id").attr("value", jsonObj[0].id);
                    $("#lookup").attr("value", jsonObj[0].lookup);
                    $("#writer").attr("value", jsonObj[0].writtenBy);
                    $("#writtenday").text(jsonObj[0].writeDate);
                    const textarea = document.querySelector("#textarea");
                    textarea.value = jsonObj[0].contents;
                    $("#fOname").attr("value", jsonObj[0].fileOriName);
                    document.querySelector("#fOname").innerHTML=jsonObj[0].fileOriName;
                    $("#fOname").attr("href", "/assets/uploadFiles/"+jsonObj[0].fileName)
                    $("#fOname").attr("download", jsonObj[0].fileOriName)

                }
            });
        }
        /* 게시글 update */
        function fn_edit() {
            var form = document.getElementById("writeForm");
            form.action = "${pageContext.request.contextPath}/base/boardModify";
            form.submit();
        }

        function fn_addtoBoard() {
            $("#textarea").attr("disabled", false);
            $("#title").attr("disabled", false);
            $("#id").attr("disabled", false);
            $("#textarea").focus();
            $("#edit").hide();
            $("#editdiv").html("<a href='#' id='edit' class='btn btn-primary  btn-lg' onClick='fn_edit()'>수정완료</a> ")
        }

        /* 게시물 delete */
        function deleteBoard(id) {
            var ans = confirm("삭제하시겠습니까?");
            var id = $('#id').val();
            console.log(" 삭제할 id 값@@@@@ :" + id);
            if (ans == true) {
                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/base/boardDelete",
                    dataType: "text",
                    data: {"id": id},
                    success: function (data) {
                        alert("삭제가 완료되었습니다!");
                        $("#codeModal").modal("hide");
                        location.href = "${pageContext.request.contextPath}/base/board";
                    }
                });
            }
        }

        /* 댓글select */
        function showreply(id) {
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/base/boardreplyList",
                dataType: "json",
                data: {"id": id},
                success: function (data) {
                    var a = '';
                    console.log(data);
                    console.log("댓글!@@@");
                    $.each(data, function (key, value) {
                        const rid = value.rid;
                        a += '<tr><td colspan="2">';
                        a += "<form id='re_form'><div>";
                        a += "<input type= 'hidden' id= 'rid' value= " + rid + ">";
                        a += "<span id='reUpdatedate'><strong>" + value.reWritter + "</strong></span>" + "&nbsp &nbsp &nbsp";
                        a += "<span>" + value.reWrittedate + "</span>";
                        a += "</div> <div>";
                        a += "<input type= 'text' size=30 maxlength=30 disabled='disabled' value=" + value.reContents + " id='" + rid + "'>";
                        a += "<input type= 'button' class='btn btn-primary  btn-sm' value='수정' id='re_btn'onClick='re_modify(" + rid + ")'>";
                        a += "<input type= 'button' class='btn btn-primary  btn-sm' value='삭제' id='re_del'onClick='re_remove()'>";
                        a += "</div></form> </td> </tr>";

                        console.log(value.rid + "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

                    });

                    $("#re_content").html(a);


                }
            });
        }

        /* 댓글update기능 */
        function re_modify(rid) {
            console.log(rid);
            $("#" + rid).attr("disabled", false);
            $("#re_del").hide();
            $("#re_btn").attr("value", "수정완료");
            $("#re_btn").attr("onClick", "modify(" + rid + ")")
        }

        function modify(rid) {
            console.log(rid);
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/base/board_re_modify",
                dataType: "text",
                data: {
                    "rid": rid,
                    "recontents": $("#" + rid).val()
                },
                success: function (data) {
                    alert("수정이 완료되었습니다!");
                    showreply($('#id').val());
                },
                error: function (data) {
                    console.log(data + "@!#@!#@!#@!#!@#!@#$@!%!@$!@");
                }
            });
        }

        function downFile(data){
            console.log("파일 다운로드");
            console.log(data);
            $.ajax({
                type: "Get",
                url: "${pageContext.request.contextPath}/base/downloadFile",
                dataType: "json",
                data: {
                    "fileName": data
                    // "FileOriName" : data.fileOriName
                },
                success: function (data) {

                }
            });
        }

        /* 댓글insert 기능 */
        function addBoard_re() {

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/base/board_re_insert",
                dataType: "json",
                data: {
                    "id": $('#id').val(),
                    "reply": $('#reply').val(),
                    "writer": '${sessionScope.empCode}'
                },
                success: function (data) {
                    showreply($('#id').val());
                    $("#reply").val('');
                },
                error: function (data) {
                    console.log(data + "@!#@!#@!#@!#!@#!@#$@!%!@$!@");
                }
            });
        }

        /* 댓글delete */
        function re_remove(id) {
            var ans = confirm("삭제하시겠습니까?");
            var rid = $('#rid').val();
            console.log(" 삭제할 id 값@@@@@ :" + id);
            if (ans == true) {
                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/base/replyDelete",
                    dataType: "text",
                    data: {"rid": rid},
                    success: function (data) {
                        alert("삭제가 완료되었습니다!");
                        showreply($('#id').val());
                    }
                });
            }
        }


    </script>
    <style>
        #header_board2 {
            display: inline;
        }

        #header_board3 #header_board3 {
            display: inline;
            margin-left: 500px;
        }

        table {
            border-collapse: separate;
        }

        th {
            padding: 5px;
        }

    </style>
</head>
<body class="bg-gradient-primary">
<!-- 게시판 위 버튼 -->
<h4 id="header_board2">게시판</h4>
<div style="float: right;"><a href='${pageContext.request.contextPath}/base/boardwriteform'
                              class="btn btn-primary">글쓰기</a></div>
<hr>
<div style="float: left; width: 100%; padding: 10px;">
    <div align="center">
        <div id="accountGrid" class=
                "ag-theme-balham"
             style="height: 500px; width: 100%;"></div>
    </div>
</div>

<!--  게시판 상세보기 모달창이요-->
<form id="writeForm" method="post">
    <div align="center" class="modal fade" id="codeModal" tabindex="-1" role="dialog"
         aria-labelledby="customerCodeModalGrid">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width:700px;">
                <div class="modal-header">
                    <h5 class="modal-title" id="customerCodeModalLabel">게시판</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>


                <div class="modal-body">

                    <table>

                        <tr>
                            <th>제목</th>
                            <td colspan="2"><input style="width: 500px" type="text" id="title" name="title"
                                                   disabled="disabled"/></td>
                        </tr>
                        <tr>
                            <th>글번호</th>
                            <td>
                                <input style="width: 100px;" type="text" id="id" name="id"
                                       readonly disabled="disabled"/>
                            </td>
                            <td> 조회수:
                                <input style="width: 100px" type="text" id="lookup"
                                       disabled="disabled"/>
                            </td>
                        </tr>
                        <tr>
                            <th>작성자</th>
                            <td><input style="width: 300px" type="text" id="writer"
                                       disabled="disabled"/></td>
                            <td>
                                <div id="writtenday"></div>
                            </td>


                        </tr>
                        <tr>
                            <th>내용</th>
                            <td colspan="2">
                        <textarea style="width: 500px" rows="20" cols="20" name="contents"
                                  id="textarea" disabled="disabled">
                        </textarea>

                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td><a id="fOname" href="#" download></a></td>
                            <td><a disabled="disabled" id="fName"/> </td>
                        </tr>

                        <tr>
                            <th></th>
                            <td colspan="2">
                                <div id="editdiv" style="text-align:center">
                                    <a href='#' id="edit" class="btn btn-primary  btn-lg"
                                       onClick='fn_addtoBoard()'>수정</a>
                                    <a href='#' class="btn btn-primary  btn-lg" onClick='deleteBoard()'>삭제</a>
                                </div>
                            </td>
                        </tr>
                        <!--  댓글뿌리는곳이다~~ -->
                        <tr>
                            <th>댓글</th>
                            <td colspan="2">
                                <input type="text" id="reply" size=50 maxlength=50>
                                <!-- <textarea rows="1" id="reply" cols="50"></textarea>  -->
                                <a href='#' id="edit_re" class="btn btn-primary" onClick='addBoard_re()'>댓글 등록</a>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="re_content"></div>
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>
    </div>
</form>


</body>
</html>