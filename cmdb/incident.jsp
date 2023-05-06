
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
<script language="JavaScript" src="javascript/tigra_hints.js"></script>
<style>
    .hintsClass {
	font-family: tahoma, verdana, arial;
	font-size: 12px;
	background-color: #f0f0f0;
	color: #000000;
	border: 1px solid #808080;
	padding: 5px;
    }
    .hintSource {
	color: green;
	text-decoration: underline;
	cursor: pointer;
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



  <%@ page import = "java.sql.*" %>
  <%@ page import = "java.util.*" %>
  <%@ page import = "java.util.Date" %>
  <%@ page import = "java.util.Calendar" %>
  <%@ page import = "java.text.SimpleDateFormat" %>
  <%@ page import = "java.util.GregorianCalendar" %>
  <%@ page import = "java.text.DateFormat" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>
<%@ page import="fr.pppm.*" %>

<body background="images/comp023.gif">

  <jsp:include page="../mainmenu.jsp" />

<%String Userlogin = (String)session.getAttribute("LOGIN");
  String POOLNAME=(String)session.getAttribute("POOLNAME");
  Context initCtx = new InitialContext();
  DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
  Connection Conn = ds.getConnection();  
  String act = request.getParameter("TODO");
  PPPMTools pt = new PPPMTools();



  if (act.equals("DEF")) {
      int newid=0;
      Statement st10 = Conn.createStatement();
      String q10 = "SELECT * FROM INDX WHERE ID='INCIDENT'";
      ResultSet r10 = st10.executeQuery(q10);
      r10.next();
      int idnum=r10.getInt("SEQ");
      int newidnum=idnum+1;
      st10.close();
      Statement sti10 = Conn.createStatement();
      String i10 = "UPDATE INDX SET SEQ="+newidnum+" WHERE ID='INCIDENT'";
      sti10.executeUpdate(i10);
      sti10.close();
    
      String idfill="";
      String idtmp = ""+idnum;
      for (int j =0; j<7-idtmp.length();j++) {
        idfill=idfill+"0";
      }
      idfill=idfill+idtmp;
      String VERSIONID = request.getParameter("VERSIONID");
      String TITLE = pt.checkStr(request.getParameter("TITLE"));
      String DESCRIPTION = pt.checkStr(request.getParameter("DESCRIPTION"));
      String ACTION = pt.checkStr(request.getParameter("ACTION"));
      String RESULT = pt.checkStr(request.getParameter("RESULT"));
      String CHECKED = pt.checkStr(request.getParameter("CHECKED"));
      Statement sti2 = Conn.createStatement();
      String i2 = "INSERT INTO CMDB_SOFTWARE_INCIDENT VALUES('"+idfill+"','"+VERSIONID+"','"+TITLE+"','"+DESCRIPTION+"','"+ACTION+"','"+RESULT+"','"+CHECKED+"')";
      sti2.executeUpdate(i2);
      sti2.close();
    }
 
  if (act.equals("MOD")) {
      String ID = request.getParameter("ID"); 
      String VERSIONID = request.getParameter("VERSIONID");
      String TITLE = pt.checkStr(request.getParameter("TITLE"));
      String DESCRIPTION = pt.checkStr(request.getParameter("DESCRIPTION"));
      String ACTION = pt.checkStr(request.getParameter("ACTION"));
      String RESULT = pt.checkStr(request.getParameter("RESULT"));
      String CHECKED = pt.checkStr(request.getParameter("CHECKED"));

      Statement sti2 = Conn.createStatement();
      String i2 = "UPDATE CMDB_SOFTWARE_INCIDENT SET TITLE='"+TITLE+"',DESCRIPTION='"+DESCRIPTION+"',ACTION='"+ACTION+"',RESULT='"+RESULT+"',CHECKED='"+CHECKED+"' WHERE ID='"+ID+"'";
      sti2.executeUpdate(i2);
      sti2.close();

  }

  out.print("<center><strong><h1>Issues Knowledge Base per software</h1></strong></center><hr>");
  


  out.print("<form name=\"formFILTER\" method=\"post\" action=\"incident.jsp?TODO=FILTER\" target=\"appliFrame\">");
  out.print("<br>Filter by application : <select name=\"SELECTFILTER\">");
  Statement st20 = Conn.createStatement();
  String q20 = "SELECT ID,NAME FROM CMDB_SOFTWARE ORDER BY NAME";
  ResultSet r20 = st20.executeQuery(q20);
  while(r20.next()) {
    Statement st21 = Conn.createStatement();
    String q21 = "SELECT * FROM CMDB_SOFTWARE_VERSION WHERE SOFTWAREID='"+r20.getString("ID")+"' ";
    ResultSet r21 = st21.executeQuery(q21);
    String SOFTWARE = "";
    while (r21.next()) {
      out.print("<option>"+r21.getString("ID")+" - "+r20.getString("NAME")+" - "+r21.getString("VERSION")+"</option>");     
    }
    st21.close();
  }
  st20.close();
  out.print("</select>");
  out.print("<input type=\"submit\" name=\"filter\" value=\"Filter\"></center>");
  out.print("</form>");


  if (act.equals("FILTER") ||act.equals("SORT")) {
    out.print("<br><br><H1>Existing issues for the software : "+request.getParameter("SELECTFILTER")+"</H1><br><br>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\"><center>TITLE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>DESCRIPTION</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>ACTION</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>RESULT</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>CHECKED</center></td>");
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String filstr = request.getParameter("SELECTFILTER");
    String idfil = filstr.substring(0,filstr.indexOf("-")-1);
    String q30 = "SELECT * FROM CMDB_SOFTWARE_INCIDENT WHERE VERSIONID='"+idfil+"'";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp<A HREF=\"incidentof.jsp?TODO=MOD&ID="+r30.getString("ID")+"\" target=\"appliFrame\">"+r30.getString("TITLE")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("DESCRIPTION")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("ACTION")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("RESULT")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("CHECKED")+"</center></td>");
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"incidentof.jsp?TODO=NEW&VERSIONID="+idfil+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");
  }
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
