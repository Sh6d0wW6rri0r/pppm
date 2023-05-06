
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css"> 
body { color: black; font-family: arial; font-size: 12px}
h1 { color: black; font-family: arial; font-size: 18px}

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

<%String Userlogin = (String)session.getAttribute("LOGIN");
  String POOLNAME=(String)session.getAttribute("POOLNAME");
  Context initCtx = new InitialContext();
  DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
  Connection Conn = ds.getConnection();
  String act = request.getParameter("TODO");
  String ID = request.getParameter("ID");
  String OSID = request.getParameter("OSID");
  PPPMTools pt = new PPPMTools();

  if (act.equals("ADD")) {
    String NAME = request.getParameter("NAME");
    String ALLOWED = request.getParameter("ALLOWED");
    int RYEAR=0;
    int RMONTH=0;
    int RDAY=0;

    Statement sti2 = Conn.createStatement();
    
    Statement st10 = Conn.createStatement();
    String q10 = "SELECT * FROM INDX WHERE ID='SP'";
    ResultSet r10 = st10.executeQuery(q10);
    r10.next();
    int idnum=r10.getInt("SEQ");
    int newidnum=idnum+1;
    st10.close();
    Statement sti10 = Conn.createStatement();
    String i10 = "UPDATE INDX SET SEQ="+newidnum+" WHERE ID='SP'";
    sti10.executeUpdate(i10);
    sti10.close();
    
    String idfill="";
    String idtmp = ""+idnum;
    for (int j =0; j<7-idtmp.length();j++) {
      idfill=idfill+"0";
    }
    idfill=idfill+idtmp;
    boolean are_date_valid = true;
    try { 
      DateFormat formatter ; 
      Date date ; 
      formatter = new SimpleDateFormat("MM/dd/yyyy");
      date = (Date)formatter.parse(request.getParameter("RDATE")); 
      GregorianCalendar dGC = new GregorianCalendar();
      dGC.setTime(date);
      dGC.setLenient(false); 
      RYEAR = dGC.get(GregorianCalendar.YEAR); 
      RMONTH  = dGC.get(GregorianCalendar.MONTH)+1; 
      RDAY = dGC.get(GregorianCalendar.DAY_OF_MONTH); 
    } catch (Exception e) { 
      are_date_valid = false; 
    } 
    String i2 = "INSERT INTO CMDB_SP VALUES ('"+idfill+"','"+OSID+"','"+pt.checkStr(NAME)+"',"+RDAY+","+RMONTH+","+RYEAR+",'"+ALLOWED+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  
  if (act.equals("MOD")) {
    String NAME = request.getParameter("NAME");
    String ALLOWED = request.getParameter("ALLOWED");
    int RYEAR=0;
    int RMONTH=0;
    int RDAY=0;

    boolean are_date_valid = true;
    try { 
      DateFormat formatter ; 
      Date date ; 
      formatter = new SimpleDateFormat("MM/dd/yyyy");
      date = (Date)formatter.parse(request.getParameter("RDATE")); 
      GregorianCalendar dGC = new GregorianCalendar();
      dGC.setTime(date);
      dGC.setLenient(false); 
      RYEAR = dGC.get(GregorianCalendar.YEAR); 
      RMONTH  = dGC.get(GregorianCalendar.MONTH)+1; 
      RDAY = dGC.get(GregorianCalendar.DAY_OF_MONTH); 
    } catch (Exception e) { 
      are_date_valid = false; 
    } 
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SP SET NAME='"+pt.checkStr(NAME)+"',RDAY="+RDAY+",RMONTH="+RMONTH+",RYEAR="+RYEAR+",ALLOWED='"+ALLOWED+"' WHERE OSID='"+OSID+"' AND ID='"+ID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }

    Statement st31 = Conn.createStatement();
    String q31 = "SELECT * FROM CMDB_OS WHERE ID='"+OSID+"'";
    ResultSet r31 = st31.executeQuery(q31);
    if (r31.next()) {
      out.print("<center><strong><h1>Service Packs for "+r31.getString("NAME")+" </h1></strong></center><hr>");
    }
    st31.close();
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>RELEASE DATE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>ALLOWED TO DEPLOY</center></td>");  
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SP WHERE OSID='"+OSID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"spit.jsp?TODO=MOD&ID="+r30.getString("ID")+"&OSID="+OSID+"\">"+r30.getString("NAME")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getInt("RMONTH")+"/"+r30.getInt("RDAY")+"/"+r30.getInt("RYEAR")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("ALLOWED")+"</center></td>");
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"spit.jsp?TODO=ADD&OSID="+OSID+"\" target=\"appliFrame\">");
      out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>

