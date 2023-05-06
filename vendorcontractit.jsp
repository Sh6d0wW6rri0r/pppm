
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css"> 
body { color: black; font-family: arial; font-size: 12px}
h1 { color: black; font-family: arial; font-size: 18px}

 </style> 


<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/PopupWindow.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/date.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/AnchorPosition.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
var cal = new CalendarPopup();
</SCRIPT>

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

<body background="images/comp023.gif">

<%String Userlogin = (String)session.getAttribute("LOGIN");
  String POOLNAME=(String)session.getAttribute("POOLNAME");
  Context initCtx = new InitialContext();
  DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
  Connection Conn = ds.getConnection();  		
  String act = request.getParameter("TODO");
  String ID = request.getParameter("ID");
  String VENDORID = request.getParameter("VENDORID");

  out.print("<center><strong><h1>Contract</h1></strong></center><hr>");

  String REFERENCE = "";
  String DESCRIPTION = "";
  String PRICE = "";
  Calendar rn= Calendar.getInstance();
  int DDAY=rn.get(Calendar.DATE);
  int DMONTH=rn.get(Calendar.MONTH)+1;
  int DYEAR=rn.get(Calendar.YEAR);
  int EDAY=rn.get(Calendar.DATE);
  int EMONTH=rn.get(Calendar.MONTH)+1;
  int EYEAR=rn.get(Calendar.YEAR);

  if (act.equals("ADD")) {
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"vendorcontract.jsp?TODO=ADD&VENDORID="+VENDORID+"\" target=\"_top\">");
  } else {
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"vendorcontract.jsp?TODO=MOD&ID="+ID+"&VENDORID="+VENDORID+"\" target=\"_top\">");
  }

  if (!act.equals("ADD")) {
    Statement st10 = Conn.createStatement();
    String q10 = "SELECT * FROM CMDB_VENDOR_CONTRACT WHERE ID='"+ID+"' AND VENDORID='"+VENDORID+"'";
    ResultSet r10 = st10.executeQuery(q10);
    if (r10.next()) {
      REFERENCE=r10.getString("REFERENCE");
      DESCRIPTION=r10.getString("DESCRIPTION");
      PRICE=r10.getString("PRICE");
      DDAY=r10.getInt("DDAY");
      DMONTH=r10.getInt("DMONTH");
      DYEAR=r10.getInt("DYEAR");
      EDAY=r10.getInt("EDAY");
      EMONTH=r10.getInt("EMONTH");
      EYEAR=r10.getInt("EYEAR");
    }
    st10.close();
  }

  out.print("<table>");


  out.print("<tr><td>Reference : </td><td><input name=\"REFERENCE\" type=\"text\" size=\"50\" value=\""+REFERENCE+"\"></td></tr>");

  out.print("<tr><td>Description : </td><td><textarea name=\"DESCRIPTION\" cols=\"80\" rows=\"10\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");

    out.print("<tr><td>From : </td><td><INPUT TYPE=\"text\" NAME=\"FROM\" VALUE=\""+DMONTH+"/"+DDAY+"/"+DYEAR+"\" SIZE=25>");
    out.print("</td><td><A HREF=\"#\" onClick=\"cal.select(document.forms['formFILTER'].FROM,'anchor1','MM/dd/yyyy'); return false;\" NAME=\"anchor1\" ID=\"anchor1\">Calendar</A></td></tr>");  
    out.print("<tr><td>To : </td><td><INPUT TYPE=\"text\" NAME=\"TO\" VALUE=\""+EMONTH+"/"+EDAY+"/"+EYEAR+"\" SIZE=25>");
    out.print("</td><td><A HREF=\"#\" onClick=\"cal.select(document.forms['formFILTER'].TO,'anchor1','MM/dd/yyyy'); return false;\" NAME=\"anchor1\" ID=\"anchor1\">Calendar</A></td></tr>");  
 
  out.print("<tr><td>Price per Year </td><td><input name=\"PRICE\" type=\"text\" size=\"50\" value=\""+PRICE+"\"></td></tr>");

  out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Assign\"></td></tr></center>");

  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
