<%-- <%@page import="net.plang.howooaccount.system.authority.to.AuthorityEmpBean"%> --%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%--    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>--%>
<%--    <script src="https://unpkg.com/@ag-grid-enterprise/all-modules@24.1.0/dist/ag-grid-enterprise.min.js"></script>--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>--%>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><sitemesh:write property='title'/> - 73th Accounting</title>

<%--    <!-- Custom fonts for this template-->--%>
<%--    <link--%>
<%--            href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css"--%>
<%--            rel="stylesheet" type="text/css">--%>
<%--    <link--%>
<%--            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"--%>
<%--            rel="stylesheet">--%>

<%--    <!-- Custom styles for this template-->--%>
<%--    <link--%>
<%--            href="${pageContext.request.contextPath}/assets/css/sb-admin-2.min.css"--%>
<%--            rel="stylesheet">--%>



    <%--  jQuery  --%>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <%--  BootStrap  --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <%--  SweetAlert  --%>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <%--  AG-Grid  --%>
<%--    <!-- Include the JS for AG Grid -->--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>--%>
<%--    <!-- Include the core CSS, this is needed by the grid -->--%>
<%--    <link rel="stylesheet"--%>
<%--          href="https://cdn.jsdelivr.net/npm/ag-grid-community/styles/ag-grid.css"/>--%>
<%--    <!-- Include the theme CSS, only need to import the theme you are going to use -->--%>
<%--    <link rel="stylesheet"--%>
<%--          href="https://cdn.jsdelivr.net/npm/ag-grid-community/styles/ag-theme-alpine.css"/>--%>
<%--        <script src="https://unpkg.com/@ag-grid-enterprise/all-modules@24.1.0/dist/ag-grid-enterprise.min.js"></script>--%>
    <!-- Include the JS for AG Grid -->
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <!-- Include the core CSS, this is needed by the grid -->
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/styles/ag-grid.css"/>
    <!-- Include the theme CSS, only need to import the theme you are going to use -->
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/styles/ag-theme-alpine.css"/>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <%--  Fontawsome  --%>
    <link href="${pageContext.request.contextPath}/assets/fontawesome-free-6.2.0-web/css/all.css" rel="stylesheet" type="text/css">
    <%--    <link href="${pageContext.request.contextPath}/assets/sb-admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">--%>
    <%--  download-template  --%>
    <link href="${pageContext.request.contextPath}/assets/sb-admin/css/sb-admin-2.min.css" rel="stylesheet">
    <%--  Google Fonts  --%>
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <sitemesh:write property='head' />
</head>

<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">

    <ul
            class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
            id="accordionSidebar">

        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/hello">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">
                73th Accounting<sup>3</sup>
            </div>
        </a>

        <!-- Divider -->
        <hr class="sidebar-divider my-0">


        <!-- Nav Item - Dashboard -->
        <li class="nav-item active"><a class="nav-link collapsed"
                                       href="#" data-toggle="collapse" data-target="#collapseDashboard"
                                       aria-expanded="true" aria-controls="collapseTwo"> <i
                class="fas fa-fw fa-folder"></i> <span class="confirmMenu">?????????</span>
        </a>
            <div id="collapseDashboard" class="collapse"
                 aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">?????????</h6>
                    <!--???????????? -->
                    <a id="ME009_1" class="collapse-item board" href="#">????????? ??????</a>
                    <!--http://localhost:8282/Account33/+html ??????????????? -->
                    <a id="ME009_2" class="collapse-item boardwrite" href="#">?????????
                        ??????</a>
                </div>
            </div></li>
        <!-- Nav Item - Dashboard -->
        <%--    <li class="nav-item active">
    <a class="nav-link Permission" href="${pageContext.request.contextPath}/base/board"><!-- ???????????????!! -->
      <i class="fas fa-fw fa-table"></i>
      <span>?????????</span></a>
  </li> --%>

        <!-- Divider -->
        <hr class="sidebar-divider">

        <!--  ???????????? ?????? -->

        <!-- Heading -->
        <div class="sidebar-heading">?????????</div>

        <!-- ???????????? -->
        <li class="nav-item slip"><a
                class="nav-link collapsed Permission" href="#"
                data-toggle="collapse" data-target="#collapseSilp"
                aria-expanded="true" aria-controls="collapseTwo"> <i
                class="fas fa-fw fa-folder"></i> <span class="confirmMenu">????????????</span>
        </a>
            <div id="collapseSilp" class="collapse" aria-labelledby="headingTwo"
                 data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">??????</h6>
                    <!--???????????? -->
                    <a id="ME001_1" class="collapse-item slip" href="#">????????????</a>
                    <!--http://localhost:8282/Account33/+html ??????????????? -->
                    <a id="ME001_2" class="collapse-item approveslip" href="#">????????????</a>
                </div>
            </div></li>

        <!--?????? ??????-->
        <li class="nav-item journal"><a
                class="nav-link collapsed Permission" href="#"
                data-toggle="collapse" data-target="#collapseJournal"
                aria-expanded="true" aria-controls="collapseUtilities"> <i
                class="fas fa-fw fa-folder"></i> <span class="confirmMenu">????????????</span>
        </a>
            <div id="collapseJournal" class="collapse"
                 aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">??????</h6>
                    <a id="ME003_1" class="collapse-item cashJournal" href="#">???????????????</a>
                    <a id="ME003_4" class="collapse-item assetManagement" href="#">??????????????????</a>
                    <a id="ME003_2" class="collapse-item journalForm" href="#">?????????</a>
                    <a id="ME003_3" class="collapse-item detailTrialBalance" href="#">???(???)??????</a>
                    <a id="ME003_11" class="collapse-item accountLedger" href="#">???????????????</a>
                    <a id="ME003_12" class="collapse-item totalAccountLedger" href="#">???????????????</a>
                </div>
            </div></li>

        <!--?????? -->
        <li class="nav-item statement">
            <a class="nav-link collapsed Permission" href="#" data-toggle="collapse" data-target="#collapseSettlement"
               aria-expanded="true" aria-controls="collapseUtilities">
                <i class="fas fa-fw fa-folder"></i>
                <span class="confirmMenu">?????? ??? ????????????</span>
            </a>
            <div id="collapseSettlement" class="collapse"
                 aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <a id="ME004_1" class="collapse-item totaltrial" href="#">?????????????????????</a>
                    <!-- <a class="collapse-item" href="${pageContext.request.contextPath}/statement/totalTrialBalance.html">?????????????????????</a>  -->
                    <a id="ME004_2" class="collapse-item income" href="#">???????????????</a>
                    <!--  <a class="collapse-item" href="${pageContext.request.contextPath}/statement/financialPosition.html">???????????????</a> -->
                    <a id="ME004_3" class="collapse-item finance" href="#">???????????????</a>
                </div>
            </div></li>


        <!--????????????????????? -->
        <li class="nav-item early"><a
                class="nav-link collapsed Permission" href="#"
                data-toggle="collapse" data-target="#collapseTemify"
                aria-expanded="true" aria-controls="collapseUtilities"> <i
                class="fas fa-fw fa-folder"></i> <span class="confirmMenu">?????????????????????</span>
        </a>
            <div id="collapseTemify" class="collapse"
                 aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">????????? ??????</h6>
                    <a id="ME005_1" class="collapse-item earlyCal" href="#">????????????????????????</a>
                    <a id="ME005_2" class="collapse-item earlyFinance" href="#">????????????????????????</a>
                </div>
            </div></li>

        <!--???????????? -->
        <li class="nav-item authority"><a
                class="nav-link collapsed Permission" href="#"
                data-toggle="collapse" data-target="#collapseAuthority"
                aria-expanded="true" aria-controls="collapseUtilities"> <i
                class="fas fa-fw fa-folder"></i> <span class="confirmMenu">????????????</span>
        </a>
            <div id="collapseAuthority" class="collapse"
                 aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">????????????</h6>
                    <a class="collapse-item authorityGroup" id="ME007_1" href="#">??????????????????</a>
                    <a class="collapse-item menuAuthority" id="ME007_2" href="#">??????????????????</a>
                </div>
            </div></li>

        <!--???????????? -->
        <li class="nav-item budget"><a
                class="nav-link collapsed Permission" href="#"
                data-toggle="collapse" data-target="#test" aria-expanded="true"
                aria-controls="collapseUtilities"> <i
                class="fas fa-fw fa-folder"></i> <span class="confirmMenu">????????????</span>
        </a>
            <div id="test" class="collapse" aria-labelledby="headingUtilities"
                 data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">??????</h6>
                    <a id="ME006_1" class="collapse-item ApplyBudget" href="#">????????????</a>
                    <a id="ME006_2" class="collapse-item PlanBudget" href="#">????????????</a>
                    <a id="ME006_3" class="collapse-item ManageBudget" href="#">????????????????????????</a>
                </div>
            </div></li>



        <!-- Divider -->
        <hr class="sidebar-divider">

        <!-- Nav Item - Pages Collapse Menu -->
        <c:if test="${sessionScope.empName!=null}">
            <li class="nav-item"><a class="nav-link collapsed" href="#"
                                    data-toggle="collapse" data-target="#collapsePages"
                                    aria-expanded="true" aria-controls="collapsePages"> <i
                    class="fas fa-fw fa-cog"></i> <span class="confirmMenu" id="btn">????????????</span>
            </a>
                <div id="collapsePages" class="collapse"
                     aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">??????</h6>
                        <a id="ME002_5" class="collapse-item profile" href="#">????????????</a> <a
                            id="ME002_1" class="collapse-item manageWorker" href="#">????????????</a>
                        <a id="ME002_2" class="collapse-item registerWorkplace" href="#">????????????</a>
                        <a id="ME002_3" class="collapse-item registerCustomer" href="#">?????????
                            ??????</a> <a id="ME002_4" class="collapse-item registerExport" href="#">????????????
                        ??? ??????</a>
                    </div>
                </div></li>
            <hr class="sidebar-divider d-none d-md-block">
        </c:if>
        <!-- Divider -->


        <!-- Sidebar Toggler (Sidebar) -->
        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <nav
                    class="navbar navbar-expand navbar-light bg-secondary topbar mb-4 static-top shadow">

                <!-- Sidebar Toggle (Topbar) -->
                <button id="sidebarToggleTop"
                        class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>

                <!-- Topbar Search -->
                <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                    <div class="input-group">
                        <input type="text" class="form-control bg-light border-0 small"
                               placeholder="Search for..." aria-label="Search"
                               aria-describedby="basic-addon2">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="button">
                                <i class="fas fa-search fa-sm"></i>
                            </button>
                        </div>
                    </div>
                </form>

                <!-- Topbar Navbar -->
<%--                <nav--%>
<%--                        class="navbar navbar-expand-sm navbar-dark d-flex justify-content-center align-items-center">--%>
<%--                    <ul class="navbar-nav navbar-dark style='cursor:pointer'; ">--%>

<%--                        <li class="nav-item dropdown"><a--%>
<%--                                class="nav-link dropdown-toggle text-white Permission"--%>
<%--                                data-toggle="dropdown" href="#">????????????</a>--%>
<%--                            <div class="dropdown-menu">--%>

<%--                                <a id="ME001_1" class="dropdown-item slip" href="#">????????????</a> <a--%>
<%--                                    id="ME001_2" class="dropdown-item approveslip" href="#">????????????</a>--%>
<%--                            </div></li>--%>

<%--                        <li class="nav-item dropdown"><a--%>
<%--                                class="nav-link dropdown-toggle text-white Permission"--%>
<%--                                data-toggle="dropdown" href="#">????????????</a>--%>
<%--                            <div class="dropdown-menu">--%>
<%--                                <a id="ME003_1" class="dropdown-item cashJournal" href="#">???????????????</a>--%>
<%--                                <a id="ME003_4" class="dropdown-item assetManagement" href="#">??????????????????</a>--%>
<%--                                <a id="ME003_2" class="dropdown-item journalForm" href="#">?????????</a>--%>
<%--                                <a id="ME003_3" class="dropdown-item detailTrialBalance"--%>
<%--                                   href="#">???(???)??????</a> <a id="ME003_11"--%>
<%--                                                          class="dropdown-item accountLedger" href="#">???????????????</a> <a--%>
<%--                                    id="ME003_12" class="dropdown-item totalAccountLedger"--%>
<%--                                    href="#">???????????????</a>--%>
<%--                            </div></li>--%>

<%--                        <li class="nav-item dropdown"><a--%>
<%--                                class="nav-link dropdown-toggle text-white Permission"--%>
<%--                                data-toggle="dropdown" href="#">?????? ??? ????????????</a>--%>
<%--                            <div class="dropdown-menu">--%>
<%--                                <a id="ME004_1" class="dropdown-item totaltrial" href="#">?????????????????????</a>--%>
<%--                                <a id="ME004_2" class="dropdown-item income" href="#">???????????????</a>--%>
<%--                                <a id="ME004_3" class="dropdown-item finance" href="#">???????????????</a>--%>
<%--                            </div></li>--%>

<%--                        <li class="nav-item dropdown"><a--%>
<%--                                class="nav-link dropdown-toggle text-white Permission"--%>
<%--                                data-toggle="dropdown" href="#">?????????????????????</a>--%>
<%--                            <div class="dropdown-menu">--%>
<%--                                <a id="ME005_1" class="dropdown-item earlyCal" href="#">????????????????????????</a>--%>
<%--                                <a id="ME005_2" class="dropdown-item earlyFinance" href="#">????????????????????????</a>--%>
<%--                            </div></li>--%>

<%--                        <li class="nav-item dropdown"><a--%>
<%--                                class="nav-link dropdown-toggle text-white Permission"--%>
<%--                                data-toggle="dropdown" href="#">????????????</a>--%>
<%--                            <div class="dropdown-menu">--%>
<%--                                <a id="ME007_1" class="dropdown-item authorityGroup" href="#">??????????????????</a>--%>
<%--                                <a id="ME007_2" class="dropdown-item menuAuthority" href="#">??????????????????</a>--%>
<%--                            </div></li>--%>

<%--                        <li class="nav-item dropdown"><a--%>
<%--                                class="nav-link dropdown-toggle text-white Permission"--%>
<%--                                data-toggle="dropdown" href="#">????????????</a>--%>
<%--                            <div class="dropdown-menu">--%>
<%--                                <a id="ME006_1" class="dropdown-item ApplyBudget" href="#">????????????</a>--%>
<%--                                <a id="ME006_2" class="dropdown-item PlanBudget" href="#">????????????</a>--%>
<%--                                <a id="ME006_3" class="dropdown-item ManageBudget" href="#">????????????????????????</a>--%>
<%--                            </div></li>--%>

<%--                        <li class="nav-item dropdown"><a--%>
<%--                                class="nav-link dropdown-toggle text-white"--%>
<%--                                data-toggle="dropdown" href="#">????????????</a>--%>
<%--                            <div class="dropdown-menu">--%>
<%--                                <a id="ME002_5" class="dropdown-item profile" href="#">??? ?????????</a>--%>
<%--                                <a id="ME002_1" class="dropdown-item manageWorker" href="#">????????????</a>--%>
<%--                                <a id="ME002_2" class="dropdown-item registerWorkplace" href="#">????????????</a>--%>
<%--                                <a id="ME002_3" class="dropdown-item registerCustomer" href="#">????????? ??????</a>--%>
<%--                                <a id="ME002_4" class="dropdown-item registerExport" href="#">???????????? ??? ??????</a>--%>

<%--                            </div></li>--%>
<%--                    </ul>--%>
<%--                </nav>--%>

                <ul class="navbar-nav ml-auto">
                    <c:if test="${sessionScope.empName!=null}">
                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none"><a
                                class="nav-link dropdown-toggle" href="#" id="searchDropdown"
                                role="button" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
                        </a> <!-- Dropdown - Messages -->
                            <div
                                    class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                    aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text"
                                               class="form-control bg-light border-0 small"
                                               placeholder="Search for..." aria-label="Search"
                                               aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div></li>

                        <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1"><a
                                class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
                                role="button" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
                            <span class="badge badge-danger badge-counter"></span> <!-- ?????? ????????? ??????????????? -->
                        </a> <!-- Dropdown - Alerts --> <!-- <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  Alerts Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-primary">
                      <i class="fas fa-file-alt text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 12, 2019</div>
                    <span class="font-weight-bold">A new monthly report is ready to download!</span>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-success">
                      <i class="fas fa-donate text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 7, 2019</div>
                    $290.29 has been deposited into your account!
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-warning">
                      <i class="fas fa-exclamation-triangle text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">December 2, 2019</div>
                    Spending Alert: We've noticed unusually high spending for your account.
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
              </div> --></li>

                        <!-- Nav Item - Messages -->
                        <li class="nav-item dropdown no-arrow mx-1"><a
                                class="nav-link dropdown-toggle"
                                href="${pageContext.request.contextPath}/base/email"
                                id="messagesDropdown" role="button" aria-haspopup="true"
                                aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i>
                            <!-- Counter - Messages --> <span
                                    class="badge badge-danger badge-counter"></span> <!-- ????????? ????????? ???????????????   -->
                        </a> <!-- Dropdown - Messages --> <!-- <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  Message Center
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div class="font-weight-bold">
                    <div class="text-truncate">Hi there! I am wondering if you can help me with a problem I've been having.</div>
                    <div class="small text-gray-500">Emily Fowler ?? 58m</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
                    <div class="status-indicator"></div>
                  </div>
                  <div>
                    <div class="text-truncate">I have the photos that you ordered last month, how would you like them sent to you?</div>
                    <div class="small text-gray-500">Jae Chun ?? 1d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
                    <div class="status-indicator bg-warning"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Last month's report looks great, I am very happy with the progress so far, keep up the good work!</div>
                    <div class="small text-gray-500">Morgan Alvarez ?? 2d</div>
                  </div>
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                    <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
                    <div class="status-indicator bg-success"></div>
                  </div>
                  <div>
                    <div class="text-truncate">Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</div>
                    <div class="small text-gray-500">Chicken the Dog ?? 2w</div>
                  </div>
                </a>
                <a class="dropdown-item text-center small text-gray-500" href="${pageContext.request.contextPath}/base/email">Read More Messages</a>
              </div> --></li>

                        <div class="topbar-divider d-none d-sm-block"></div>
                    </c:if>
                    <!-- Nav Item - User Information -->
                    <li class="nav-item dropdown no-arrow">
                        <c:choose>
                        <c:when test="${sessionScope.empName!=null}">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown"
                               role="button" data-toggle="dropdown" aria-haspopup="true"
                               aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-white small">${sessionScope.empName}</span>
                                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                <a class="dropdown-item" id="ME002_5" href="#"> <i
                                        class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> ?????????
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-itemsss" href="#" data-toggle="modal"
                                   data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    ????????????
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a class="nav-link dropdown-toggle"
                               href="${pageContext.request.contextPath}/loginform"> <span
                                    class="mr-2 d-none d-lg-inline text-gray-600 small">?????????</span>
                                <img class="img-profile rounded-circle"
                                     src="${pageContext.request.contextPath}/assets/img/profile.png">
                            </a>
                        </c:otherwise>
                    </c:choose></li>
                </ul>
            </nav>



            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <div class="container-fluid">
                <!--      <sitemesh:write property='body'/> hello.jsp??? body ?????? -->
                <sitemesh:write property='body' />
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

        <!-- Footer -->
        <footer class="sticky-footer bg-white">
            <div class="container my-auto">
                <div class="copyright text-center my-auto">
                    <span>Copyright &copy; </span>
                </div>
            </div>
        </footer>
        <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
        class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">???????????????????</h5>
                <button class="close" type="button" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">??</span>
                </button>
            </div>
            <div class="modal-body">
                ????????? ????????? ????????? ????????????????<br> ????????? ?????? ????????? ??? ???????????? ??????????????? ???????????????!
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button"
                        data-dismiss="modal">Cancel</button>
                <a class="btn btn-primary"
                   href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </div>
</div>
<%--<script--%>
<%--        src="https://unpkg.com/@ag-grid-enterprise/all-modules@24.1.0/dist/ag-grid-enterprise.min.js"></script>--%>
<%--<!-- Bootstrap core JavaScript-->--%>
<%--<script--%>
<%--        src="${pageContext.request.contextPath}/assets/vendor/jquery/jquery.min.js"></script>--%>
<%--<script--%>
<%--        src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>--%>

<%--<!-- Core plugin JavaScript-->--%>
<%--<script--%>
<%--        src="${pageContext.request.contextPath}/assets/vendor/jquery-easing/jquery.easing.min.js"></script>--%>

<%--<!-- Custom scripts for all pages-->--%>
<%--<script--%>
<%--        src="${pageContext.request.contextPath}/assets/js/sb-admin-2.min.js"></script>--%>

<%--<!-- Page level plugins--%>
<%--<script src="${pageContext.request.contextPath}/assets/vendor/chart.js/Chart.min.js"></script>--%>
<%---->--%>
<%--<!-- Page level custom scripts--%>
<%--  <script src="${pageContext.request.contextPath}/assets/js/demo/chart-area-demo.js"></script>--%>
<%--  <script src="${pageContext.request.contextPath}/assets/js/demo/chart-pie-demo.js"></script>--%>
<%-- -->--%>
<%--&lt;%&ndash; <% ArrayList<String> menuList = (ArrayList<String>) session.getAttribute("menuList");%> &ndash;%&gt;--%>

<script src="https://unpkg.com/@ag-grid-enterprise/all-modules@24.1.0/dist/ag-grid-enterprise.min.js"></script>

<%--  download-template  --%>
<%-- ??????????????? ?????? ????????? ?????? --%>
<script src="${pageContext.request.contextPath}/assets/sb-admin/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/sb-admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<%-- easing??? ????????? sb-admin ?????? ????????????. ?????? ????????? ????????? ?????????????????? ????????? ??????. --%>
<script src="${pageContext.request.contextPath}/assets/sb-admin/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/sb-admin/js/sb-admin-2.min.js"></script>



<script>
    var arr = "<%=(ArrayList<String>) session.getAttribute("menuList")%>";
    /* $('.confirmMenu').click(function(e){
       console.log(arr);
       var text = "";
       var isAuthority = "";
       text = $(this).text();
       isAuthority = arr.includes(text);
       console.log(isAuthority);
       if(isAuthority == false){
          alertFunc();
          e.preventDefault();
       }
    }) */

    $(document).on('click', '.Permission', function(e){
        console.log("??????");
        console.log(arr);
        var text = "";
        var isAuthority = "";
        text = $.trim($(this).text());
        console.log(text);
        console.log("@@@@@@@@@@@@@@@@@@@@@@@@@");
        isAuthority = arr.includes(text);
        console.log(isAuthority);
        if(isAuthority == false){
            //e.stopPropagation();
            alertFunc();
        }

    });

    function alertFunc(){
        Swal.fire({
            icon : 'error',
            title : '?????? ??????',
            text : '?????? ????????? ??????????????????',
            footer : '<a>??????????????? ???????????????</a>',
            buttons :{
                confirm:{
                    text:'??????',
                    value:true
                }
            }
        }).then((result)=>{
            if(result){
                $(location).attr("href","${pageContext.request.contextPath}/loginform");
            }
        })

    }

    /*?????????  */
    $(document).ready(function () {
        var deptCode=`${deptCode}`;
        console.log("deptCode :"+deptCode);

        if(deptCode != "")
            showAuthorityEmp(deptCode);

        $('.collapse-item, .dropdown-item').on('click', function(e){
            $(location).attr("href","${pageContext.request.contextPath}/url?menuCode="+$(this).attr("id"));
        });
    });
    function showAuthorityEmp(deptCode) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/operate/authorityemp",
            data: JSON.stringify({
                "deptCode": deptCode
            }),
            contentType: "application/json",
            dataType: "json",
            success: function (jsonObj) {
                console.log("      @showAuthorityEmp ?????? ??????");
                console.log("jsonObj.authorityEmp"+JSON.stringify(jsonObj));
                controlEmp(jsonObj);
            }
        });
    }
    function controlEmp(arrayEmp){
        var array = [];
        console.log(arrayEmp);
        arrayEmp.map(function(obj){
            array.push(obj);
        });

        var menuName=JSON.stringify(array[0].menuName);
        showAuthorityControlDetail(menuName);

    }
    function showAuthorityControlDetail(menuName) {


        menuName = menuName.replaceAll("\"","");

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/operate/authoritymenu",
            data: JSON.stringify({
                "menuName": menuName
            }),
            contentType: "application/json",
            dataType: "json",
            success: function (jsonObj) {
                console.log("      @showAuthorityDetail ??????");
                console.log("jsonObj@@@ : "+JSON.stringify(jsonObj));
                starUrlAddress(jsonObj);


            }
        });

    }
    /* URL IF ??? ?????? */

    function starUrlAddress(arrayUrl){
        console.log("arrayUrl :" + JSON.stringify(arrayUrl));
        arrayUrl.map(function(obj){
            var level =obj.authority;
            var url = obj.url;
            var menuCode = obj.menuCode;
            var gobacktoHello = "${pageContext.request.contextPath}/hello";

            if(menuCode =="ME001" && level=="0"){

                $(".slip, .approveslip").click(function(){
                    alertFunc();
                    event.preventDefault();

                });

            }

            else if(menuCode =="ME002" && level=="0"){

                $(".profile, .manageWorker, .registerWorkplace,.registerProject,.registerCustomer,.registerExport").click(function(){
                    alertFunc();
                    event.preventDefault();

                });

            }
            else if(menuCode =="ME003" && level=="0"){

                $(".cashJournal, .journalForm, .detailTrialBalance, .assetManagement, .accountLedger, .totalAccountLedger").click(function(){
                    alertFunc();
                    event.preventDefault();

                });

            }
            else if(menuCode =="ME004" && level=="0"){
                $(".totaltrial, .income, .finance").click(function(){
                    alertFunc();
                    event.preventDefault();

                });

            }
            else if(menuCode =="ME005" && level=="0"){
                $(".earlyCase, .earlyCal, .earlyFinance").click(function(){
                    alertFunc();
                    event.preventDefault();

                });

            }
            else if(menuCode =="ME006" && level=="0"){
                $(".ApplyBudget, .PlanBudget, .ManageBudget").click(function(){
                    alertFunc();
                    event.preventDefault();

                });

            }
            else if(menuCode =="ME007" && level=="0"){
                $(".authorityGroup, .menuAuthority").click(function(){
                    alertFunc();
                    event.preventDefault();

                });

            }
            else if(menuCode =="ME009" && level=="0"){
                $(".board, .boardwrite").click(function(){
                    alertFunc();
                    event.preventDefault();

                });

            }
        })
    }
</script>
</body>

</html>