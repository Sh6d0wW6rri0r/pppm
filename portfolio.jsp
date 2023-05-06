
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
  body { color: black; font-family: arial; font-size: 11px}
  h1 { color: black; font-family: arial; font-size: 16px}
</style> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.navbar {
    overflow: hidden;
    background-color: #333;
    font-family: Arial;
}

.navbar a {
    float: left;
    font-size: 16px;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

.dropdown {
    float: left;
    overflow: hidden;
}

.dropdown .dropbtn {
    cursor: pointer;
    font-size: 16px;    
    border: none;
    outline: none;
    color: white;
    padding: 14px 16px;
    background-color: inherit;
}

.navbar a:hover, .dropdown:hover .dropbtn {
    background-color: red;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    float: none;
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left;
}

.dropdown-content a:hover {
    background-color: #ddd;
}

.show {
    display: block;
}
</style>

  </head>

    <%-- PPPM.ORG, the OpenSource PPM (Portfolio, Project and Program management) system --%>
    <%-- Copyright (C) 2012  Olivier Moulin --%>

    <%-- This program is free software: you can redistribute it and/or modify --%>
    <%-- it under the terms of the GNU General Public License as published by --%>
    <%-- the Free Software Foundation, version 3 of the License. --%>

    <%-- This program is distributed in the hope that it will be useful, --%>
    <%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
    <%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
    <%-- GNU General Public License for more details. --%>

    <%-- You should have received a copy of the GNU General Public License --%>
    <%-- along with this program.  If not, see http://www.gnu.org/licenses/. --%>


  <%@ page import = "java.sql.*" %>
  <%@ page import = "java.util.*" %>
  <%@ page import = "java.util.Date" %>
  <%@ page import = "java.util.Calendar" %>
  <%@ page import = "java.text.SimpleDateFormat" %>
  <%@ page import = "java.text.DateFormat" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>
  <%@ page import = "fr.pppm.*" %>

  <body>
      <script language="JavaScript" src="javascript/showmodaldialog.js"></script>
    <script>
    function showModalPROJECTDETAILS(reqstr)
    {
    	window.showModalDialog('projectdetails.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='portfolio.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROJECTSTATUS(reqstr)
    {
    	window.showModalDialog('projectstatus.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='portfolio.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROJECTBUDGET(reqstr)
    {
    	window.showModalDialog('projectbudget.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='portfolio.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROJECTPLANNING(reqstr)
    {
    	window.showModalDialog('projectplanning.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='portfolio.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROJECTRISK(reqstr)
    {
    	window.showModalDialog('projectrisk.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='portfolio.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROJECTHEALTH(reqstr)
    {
    	window.showModalDialog('projecthealth.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='portfolio.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROJECTRESOURCES(reqstr)
    {
    	window.showModalDialog('projectresources.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='portfolio.jsp?TODO=NONE';
    }
    </script>


<jsp:include page="mainmenu.jsp" />

<%

    	// session attributes
              String Userlogin = (String)session.getAttribute("LOGIN");


              if (Userlogin==null) {
                out.print("<script language=\"JavaScript\">");
                out.print("top.location='index.jsp?TIMEOUT=TRUE';");
                out.print("</script>");
              } else {
                String POOLNAME=(String)session.getAttribute("POOLNAME");

                // database connection
                Context initCtx = new InitialContext();
                DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
                Connection Conn = ds.getConnection();

                // JSP parameters
                String act = request.getParameter("TODO");
                PPPMTools pt = new PPPMTools(); 
                Portfolio pf = new Portfolio(Conn);
                User us = new User(Conn);


              	if (act.equals("ADD")) {
                  int DDAY=0;
                  int DMONTH=0;
                  int DYEAR=0;
                  boolean are_date_valid = true;
                  try { 
                    DateFormat formatter ; 
                    Date date ; 
                    formatter = new SimpleDateFormat("yyyy-MM-dd");
                    date = (Date)formatter.parse(request.getParameter("DATE_START")); 
                    date = (Date)formatter.parse(request.getParameter("DATE_END")); 
                  } catch (Exception e) { 
                    are_date_valid = false; 
                  }
                  if (!are_date_valid) {
                    out.print("<HR>ERROR - DATE INVALID, PLEASE RE-ENTER THE DATA ! <HR>");
                  } else {

                    Project p = new Project(Conn);
                    String fowneridtmp = request.getParameter("FOWNERID");
                    String FOWNERID = fowneridtmp.substring(0,fowneridtmp.indexOf("-")-1);
                    p.setName(request.getParameter("NAME"));
                    p.setDescription(request.getParameter("DESCRIPTION"));
                    p.setFownerid(FOWNERID);
                    p.setDatestart(request.getParameter("DATE_START"));
                    p.setDateend(request.getParameter("DATE_END"));
                    p.setStatus("REQUEST");
                  }
                }
                out.print("<center><strong><h1>Project portfolio</h1></strong></center><br>");
                String COLTOSORT = "ID";
                String DIRSORT = "ASC";
                if (act.equals("SORT")) {
                  if (request.getParameter("FIELD").equals(request.getParameter("OLDFIELD"))) {
                    COLTOSORT=request.getParameter("FIELD");
                    if (request.getParameter("OLDDIR").equals("ASC")) {
                       DIRSORT="DESC";
                    } else {
                       DIRSORT="ASC";
                    }
                  } else {
                    COLTOSORT=request.getParameter("FIELD");
                    DIRSORT="ASC";
                  }
                }
                out.print("<form name=\"formFILTER\" method=\"post\" action=\"portfolio.jsp?TODO=FILTER&FILTER=FILTER\" target=\"appliFrame\">");
                PPMFilter filterengine = new PPMFilter(Conn);
                String LASTFILTERLOCATION=filterengine.getFilterValue("LASTFILTERLOCATIONPORTFOLIO",Userlogin);
                String LASTFILTERDIVISION=filterengine.getFilterValue("LASTFILTERDIVISIONPORTFOLIO",Userlogin);
                String LASTFILTERBPO=filterengine.getFilterValue("LASTFILTERBPOPORTFOLIO",Userlogin);
                String LASTFILTERPM=filterengine.getFilterValue("LASTFILTERPMPORTFOLIO",Userlogin);
                String LASTFILTERSI=filterengine.getFilterValue("LASTFILTERSIPORTFOLIO",Userlogin);
                String LASTFILTERAT=filterengine.getFilterValue("LASTFILTERATPORTFOLIO",Userlogin);
                String LASTFILTERIT=filterengine.getFilterValue("LASTFILTERITPORTFOLIO",Userlogin);
                String LASTFILTERPORT=filterengine.getFilterValue("LASTFILTERPORTPORTFOLIO",Userlogin);
                String filter = request.getParameter("FILTER");
                String filterstatement ="";
                String filstrlocation=request.getParameter("SELECTFILTERLOCATION");
                String filstrdivision=request.getParameter("SELECTFILTERDIVISION");
                String filstrBPO=request.getParameter("SELECTFILTERBPO");
                String filstrPM=request.getParameter("SELECTFILTERPM");
                String filstrSI=request.getParameter("SELECTFILTERSI");
                String filstrAT=request.getParameter("SELECTFILTERAT");
                String filstrIT=request.getParameter("SELECTFILTERIT");
                String filstrPORT=request.getParameter("SELECTFILTERPORT");
                if (filstrlocation==null) {
                  if (LASTFILTERLOCATION!=null) {
                    filter="FILTER";
                    filstrlocation=LASTFILTERLOCATION;
                  } else {
                    filter=null;
                    filstrlocation="*** - ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERLOCATIONPORTFOLIO",Userlogin,filstrlocation);
                }
                if (filstrdivision==null) {
                  if (LASTFILTERDIVISION!=null) {
                    filter="FILTER";
                    filstrdivision=LASTFILTERDIVISION;
                  } else {
                    filter=null;
                    filstrdivision="*** - ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERDIVISIONPORTFOLIO",Userlogin,filstrdivision);
                }
                if (filstrBPO==null) {
                  if (LASTFILTERBPO!=null) {
                    filter="FILTER";
                    filstrBPO=LASTFILTERBPO;
                  } else {
                    filter=null;
                    filstrBPO="*** - ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERBPOPORTFOLIO",Userlogin,filstrBPO);
                }
                if (filstrPM==null) {
                  if (LASTFILTERPM!=null) {
                    filter="FILTER";
                    filstrPM=LASTFILTERPM;
                  } else {
                    filter=null;
                    filstrPM="ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERPMPORTFOLIO",Userlogin,filstrPM);
                }
                if (filstrSI==null) {
                  if (LASTFILTERSI!=null) {
                    filter="FILTER";
                    filstrSI=LASTFILTERSI;
                  } else {
                    filter=null;
                    filstrSI="ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERSIPORTFOLIO",Userlogin,filstrSI);
                }
                if (filstrAT==null) {
                  if (LASTFILTERAT!=null) {
                    filter="FILTER";
                    filstrAT=LASTFILTERAT;
                  } else {
                    filter=null;
                    filstrAT="ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERATPORTFOLIO",Userlogin,filstrAT);
                }
                if (filstrIT==null) {
                  if (LASTFILTERIT!=null) {
                    filter="FILTER";
                    filstrIT=LASTFILTERIT;
                  } else {
                    filter=null;
                    filstrIT="ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERITPORTFOLIO",Userlogin,filstrIT);
                }
                if (filstrPORT==null) {
                  if (LASTFILTERPORT!=null) {
                    filter="FILTER";
                    filstrPORT=LASTFILTERPORT;
                  } else {
                    filter=null;
                    filstrPORT="ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERPORTPORTFOLIO",Userlogin,filstrPORT);
                }
                out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
                out.print("<tr>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("<table border=\"0\" CELLSPACING=\"0\" BORDERCOLOR=\"#FFFFFF\" width=\"100%\">");
                out.print("<tr>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Filter by Location : </td><td bgcolor=#FFFFFF><select name=\"SELECTFILTERLOCATION\">");
                out.print("<option>*** - ALL</option>");
                Statement STR09 = Conn.createStatement();
                String QR09 = "SELECT ID,NAME FROM LOCATION ORDER BY NAME";
                ResultSet R09 = STR09.executeQuery(QR09);
                while(R09.next()) {
                  out.print("<option");
                  if (filstrlocation.equals(R09.getString("ID")+" - "+R09.getString("NAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+R09.getString("ID")+" - "+R09.getString("NAME")+"</option>");
                }
                STR09.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Division : </td><td bgcolor=#FFFFFF><select name=\"SELECTFILTERDIVISION\">");
                out.print("<option>*** - ALL</option>");
                Statement STR10 = Conn.createStatement();
                String QR10 = "SELECT ID,NAME FROM DIVISION ORDER BY NAME";
                ResultSet R10 = STR10.executeQuery(QR10);
                while(R10.next()) {
                  out.print("<option");
                  if (filstrdivision.equals(R10.getString("ID")+" - "+R10.getString("NAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+R10.getString("ID")+" - "+R10.getString("NAME")+"</option>");
                }
                STR10.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("BPO :</td><td bgcolor=#FFFFFF> <select name=\"SELECTFILTERBPO\">");
                out.print("<option>*** - ALL</option>");
                Statement STR11 = Conn.createStatement();
                String QR11 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (select EMPLOYEEID FROM PRJBPO)  ORDER BY NAME,FORNAME";
                ResultSet R11 = STR11.executeQuery(QR11);
                while(R11.next()) {
                  out.print("<option");
                  if (filstrBPO.equals(R11.getString("ID")+" - "+R11.getString("NAME")+" "+R11.getString("FORNAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+R11.getString("ID")+" - "+R11.getString("NAME")+" "+R11.getString("FORNAME")+"</option>");
                }
                STR11.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Project Manager :</td><td bgcolor=#FFFFFF> <select name=\"SELECTFILTERPM\">");
                out.print("<option>*** - ALL</option>");
                Statement STR12 = Conn.createStatement();
                String QR12 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (select EMPLOYEEID FROM PRJPM) ORDER BY NAME,FORNAME";
                ResultSet R12 = STR12.executeQuery(QR12);
                while(R12.next()) {
                  out.print("<option");
                  if (filstrPM.equals(R12.getString("ID")+" - "+R12.getString("NAME")+" "+R12.getString("FORNAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+R12.getString("ID")+" - "+R12.getString("NAME")+" "+R12.getString("FORNAME")+"</option>");
                }
                STR12.close();
                out.print("</select>");
                out.print("</td><td bgcolor=#FFFFFF>&nbsp</td></tr>");
                out.print("<tr height=15>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Strategic initiative :</td><td bgcolor=#FFFFFF> <select name=\"SELECTFILTERSI\">");
                out.print("<option>*** - ALL</option>");
                Statement STR13 = Conn.createStatement();
                String QR13 = "SELECT ID,NAME FROM STRATEGICINITIATIVE ORDER BY NAME";
                ResultSet R13 = STR13.executeQuery(QR13);
                while(R13.next()) {
                  out.print("<option");
                  if (filstrSI.equals(R13.getString("ID")+" - "+R13.getString("NAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+R13.getString("ID")+" - "+R13.getString("NAME")+"</option>");
                }
                STR13.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Application type :</td><td bgcolor=#FFFFFF> <select name=\"SELECTFILTERAT\">");
                out.print("<option>*** - ALL</option>");
                Statement STR14 = Conn.createStatement();
                String QR14 = "SELECT ID,NAME FROM APPLICATIONTYPE ORDER BY NAME";
                ResultSet R14 = STR14.executeQuery(QR14);
                while(R14.next()) {
                  out.print("<option");
                  if (filstrAT.equals(R14.getString("ID")+" - "+R14.getString("NAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+R14.getString("ID")+" - "+R14.getString("NAME")+"</option>");
                }
                STR14.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Infrastructure type :</td><td bgcolor=#FFFFFF> <select name=\"SELECTFILTERIT\">");
                out.print("<option>*** - ALL</option>");
                Statement STR15 = Conn.createStatement();
                String QR15 = "SELECT ID,NAME FROM INFRASTRUCTURETYPE ORDER BY NAME";
                ResultSet R15 = STR15.executeQuery(QR15);
                while(R15.next()) {
                  out.print("<option");
                  if (filstrIT.equals(R15.getString("ID")+" - "+R15.getString("NAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+R15.getString("ID")+" - "+R15.getString("NAME")+"</option>");
                }
                STR15.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Portfolio : </td><td bgcolor=#FFFFFF><select name=\"SELECTFILTERPORT\">");
                out.print("<option>*** - ALL</option>");
                Statement STR15b = Conn.createStatement();
                String QR15b = "SELECT ID,NAME FROM PORTFOLIO ORDER BY NAME";
                ResultSet R15b = STR15b.executeQuery(QR15b);
                while(R15b.next()) {
                  if (us.hasPortfolioAccess(Userlogin,R15b.getString("ID"))) { 
                    out.print("<option");
                    if (filstrPORT.equals(R15b.getString("ID")+" - "+R15b.getString("NAME"))) {
                      out.print(" selected ");
                    }
                    out.print(">"+R15b.getString("ID")+" - "+R15b.getString("NAME")+"</option>");
                  }
                }
                STR15b.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF width=\"40\">");
                out.print("<input type=\"image\" border=0 src=\"icons/search.png\" name=\"filter\" value=\"submit\"></center>");
                out.print("</td>");
                out.print("</tr></table>");
                out.print("</td></tr></table>");
                out.print("<br>");
                out.print("</form>");
                boolean first=true;
                if (filter!= null) {
                  String idfillocation = filstrlocation.substring(0,filstrlocation.indexOf("-")-1);
                  if (!idfillocation.equals("***")) {
                    filterstatement = " AND " ;
                    filterstatement = filterstatement + " ID in (SELECT PROJECTID FROM PRJLOC WHERE LOCATIONID='"+idfillocation+"')";
                    first = false;
                  }
                  String idfildivision = filstrdivision.substring(0,filstrdivision.indexOf("-")-1);
                  if (!idfildivision.equals("***")) {
                    filterstatement = filterstatement + " AND ";
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJDIV WHERE DIVISIONID='"+idfildivision+"')";
                    first = false;
                  }
                  String idfilBPO = filstrBPO.substring(0,filstrBPO.indexOf("-")-1);
                  if (!idfilBPO.equals("***")) {
                    filterstatement = filterstatement + " AND ";
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJBPO WHERE EMPLOYEEID='"+idfilBPO+"')";
                    first = false;
                  }
                  String idfilPM = filstrPM.substring(0,filstrPM.indexOf("-")-1);
                  if (!idfilPM.equals("***")) {
                    filterstatement = filterstatement + " AND ";
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJPM WHERE EMPLOYEEID='"+idfilPM+"')";
                    first = false;
                  }
                  String idfilSI = filstrSI.substring(0,filstrSI.indexOf("-")-1);
                  if (!idfilSI.equals("***")) {
                    filterstatement = filterstatement + " AND ";
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJSI WHERE SIID='"+idfilSI+"')";
                    first = false;
                  }
                  String idfilAT = filstrAT.substring(0,filstrAT.indexOf("-")-1);
                  if (!idfilAT.equals("***")) {
                    filterstatement = filterstatement + " AND ";
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJAT WHERE ATID='"+idfilAT+"')";
                    first = false;
                  }
                  String idfilIT = filstrIT.substring(0,filstrIT.indexOf("-")-1);
                  if (!idfilIT.equals("***")) {
                    filterstatement = filterstatement + " AND ";
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJIT WHERE ITID='"+idfilIT+"')";
                    first = false;
                  }
                  String idfilPORT = filstrPORT.substring(0,filstrPORT.indexOf("-")-1);
                  if (!idfilPORT.equals("***")) {
                    filterstatement = filterstatement + " AND ";
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJPOR WHERE PORTFOLIOID='"+idfilPORT+"')";
                    first = false;
                  }
                }
                User us2 = new User(Conn);
                out.print("<table><tr><td><h2><strong>Project(s)</strong></h2></center></td></tr></table>");
                out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
                out.print("<tr height=\"20\">");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"16%\"><center><A HREF=\"portfolio.jsp?TODO=SORT&FIELD=NAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Name</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Attributes</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center><A HREF=\"portfolio.jsp?TODO=SORT&FIELD=SCORE&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Score</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Status</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Financials</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Planning</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Risks</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Health check</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Resources</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>START</td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>END</center></td>");
                out.print("</tr>");
                ProjectList prjl = new ProjectList(Conn,"SELECT * FROM PROJECT WHERE ONHOLD='N' "+filterstatement+" ORDER BY "+COLTOSORT+" "+DIRSORT);
                prjl.refresh();
                for (int j=0; j<prjl.length();j++) {
                  if (us2.hasProjectAccess(Userlogin,prjl.getProjectItem(j).getId())) {
                    out.print("<tr height=\"15\">");     
                    if (prjl.getProjectItem(j).getName().equals("")) {
                      out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
                    } else {
                      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+prjl.getProjectItem(j).getName()+"</center></td>");
                    }   
                    String RO="NO";
                    if (prjl.getProjectItem(j).getClosed().equals("Y")) {
                      RO="YES";
                    }    
                    out.print("<td bgcolor=\"#FFFFFF\"><center><center><A HREF=\"#\" onclick=\"showModalPROJECTDETAILS('PROJECTID="+prjl.getProjectItem(j).getId()+"');\"><img border=0 src=\"icons/attributes.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center>"+prjl.getProjectItem(j).getScore()+"</center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROJECTSTATUS('PROJECTID="+prjl.getProjectItem(j).getId()+"');\"><img border=0 src=\"icons/status.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROJECTBUDGET('PROJECTID="+prjl.getProjectItem(j).getId()+"');\"><img border=0 src=\"icons/financials.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROJECTPLANNING('PROJECTID="+prjl.getProjectItem(j).getId()+"');\"><img border=0 src=\"icons/planning.png\" height=15 ></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROJECTRISK('PROJECTID="+prjl.getProjectItem(j).getId()+"');\"><img border=0 src=\"icons/risks.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROJECTHEALTH('PROJECTID="+prjl.getProjectItem(j).getId()+"');\"><img border=0 src=\"icons/health.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROJECTRESOURCES('PROJECTID="+prjl.getProjectItem(j).getId()+"');\"><img border=0 src=\"icons/resources.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+prjl.getProjectItem(j).getDatestart()+"</center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+prjl.getProjectItem(j).getDateend()+"</center></td>");
                    out.print("</tr>");
                  }
                }
                out.print("</table>");
                out.print("<br><br><table><tr><td><h2><strong>On-hold project(s)</strong></h2></center></td></tr></table>");
                out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
                out.print("<tr height=\"20\">");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"16%\"><center><A HREF=\"portfolio.jsp?TODO=SORT&FIELD=NAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Name</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Attributes</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center><A HREF=\"portfolio.jsp?TODO=SORT&FIELD=SCORE&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Score</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Status</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Financials</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Planning</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Risks</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Health check</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Resources</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>START</td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>END</center></td>");
                out.print("</tr>");
                prjl=new ProjectList(Conn,"SELECT * FROM PROJECT WHERE ONHOLD='Y' "+filterstatement+" ORDER BY "+COLTOSORT+" "+DIRSORT);
                for (int j=0;j<prjl.length();j++)  {
                  out.print("<tr height=\"15\">"); 
                  if (prjl.getProjectItem(j).getName().equals("")) {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
                  } else {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+prjl.getProjectItem(j).getName()+"</center></td>");
                  }       
                  String RO="NO";
                  if (prjl.getProjectItem(j).getClosed().equals("Y")) {
                    RO="YES";
                  }
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectdetails.jsp?TODO=MOD&PROJECTID="+prjl.getProjectItem(j).getId()+"\"><img border=0 src=\"icons/attributes.png\"></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>"+prjl.getProjectItem(j).getScore()+"</center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectstatus.jsp?TODO=NONE&PROJECTID="+prjl.getProjectItem(j).getId()+"\"><img border=0 src=\"icons/status.png\"></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectbudget.jsp?TODO=NONE&PROJECTID="+prjl.getProjectItem(j).getId()+"\"><img border=0 src=\"icons/financials.png\"></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectplanning.jsp?TODO=NONE&PROJECTID="+prjl.getProjectItem(j).getId()+"\"><img border=0 src=\"icons/planning.png\"></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectrisk.jsp?TODO=NONE&PROJECTID="+prjl.getProjectItem(j).getId()+"\"><img border=0 src=\"icons/risks.png\"></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projecthealth.jsp?TODO=NONE&PROJECTID="+prjl.getProjectItem(j).getId()+"\"><img border=0 src=\"icons/health.png\"></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectresources.jsp?TODO=NONE&PROJECTID="+prjl.getProjectItem(j).getId()+"\"><img border=0 src=\"icons/resources.png\"></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+prjl.getProjectItem(j).getDatestart()+"</center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+prjl.getProjectItem(j).getDateend()+"</center></td>");
                  out.print("</tr>");
                }
                out.print("</table>"); 
                Conn.close();
              } 

    %>
  </body>
</html>
