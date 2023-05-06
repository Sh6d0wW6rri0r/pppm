
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

  <body bgcolor="#FFFFFF">

<%


String Userlogin = (String)session.getAttribute("LOGIN");


if (Userlogin==null) {
  out.print("<script language=\"JavaScript\">");
  out.print("top.location='index.jsp?TIMEOUT=TRUE';");
  out.print("</script>");
} else {
  String POOLNAME=(String)session.getAttribute("POOLNAME");
  Context initCtx = new InitialContext();
  DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
  Connection Conn = ds.getConnection();
  String act = request.getParameter("TODO");
  String ID = request.getParameter("ID");
  String VENDORID = request.getParameter("VENDORID");
  PPPMTools pt = new PPPMTools();

  if (act.equals("ADD")) {
    String REFERENCE = request.getParameter("REFERENCE");
    String DESCRIPTION = request.getParameter("DESCRIPTION");
    String PRICE = request.getParameter("PRICE");
    int EYEAR=0;
    int EMONTH=0;
    int EDAY=0;
    int DYEAR=0;
    int DMONTH=0;
    int DDAY=0;

    Statement sti2 = Conn.createStatement();
    
    Statement st10 = Conn.createStatement();
    String q10 = "SELECT * FROM INDX WHERE ID='CONTRACT'";
    ResultSet r10 = st10.executeQuery(q10);
    r10.next();
    int idnum=r10.getInt("SEQ");
    int newidnum=idnum+1;
    st10.close();
    Statement sti10 = Conn.createStatement();
    String i10 = "UPDATE INDX SET SEQ="+newidnum+" WHERE ID='CONTRACT'";
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
      date = (Date)formatter.parse(request.getParameter("FROM")); 
      GregorianCalendar dGC = new GregorianCalendar();
      dGC.setTime(date);
      dGC.setLenient(false); 
      DYEAR = dGC.get(GregorianCalendar.YEAR); 
      DMONTH  = dGC.get(GregorianCalendar.MONTH)+1; 
      DDAY = dGC.get(GregorianCalendar.DAY_OF_MONTH); 
    } catch (Exception e) { 
      are_date_valid = false; 
    } 
    try { 
      DateFormat formatter ; 
      Date date ; 
      formatter = new SimpleDateFormat("MM/dd/yyyy");
      date = (Date)formatter.parse(request.getParameter("TO")); 
      GregorianCalendar dGC = new GregorianCalendar();
      dGC.setTime(date);
      dGC.setLenient(false); 
      EYEAR = dGC.get(GregorianCalendar.YEAR); 
      EMONTH  = dGC.get(GregorianCalendar.MONTH)+1; 
      EDAY = dGC.get(GregorianCalendar.DAY_OF_MONTH); 
    } catch (Exception e) { 
      are_date_valid = false; 
    } 
    String i2 = "INSERT INTO CMDB_VENDOR_CONTRACT VALUES ('"+idfill+"','"+VENDORID+"','"+pt.checkStr(REFERENCE)+"','"+pt.checkStr(DESCRIPTION)+"',"+DDAY+","+DMONTH+","+DYEAR+","+EDAY+","+EMONTH+","+EYEAR+",'"+PRICE+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  
  if (act.equals("MOD")) {
    String REFERENCE = request.getParameter("REFERENCE");
    String DESCRIPTION = request.getParameter("DESCRIPTION");
    String PRICE = request.getParameter("PRICE");
    int EYEAR=0;
    int EMONTH=0;
    int EDAY=0;
    int DYEAR=0;
    int DMONTH=0;
    int DDAY=0;

    boolean are_date_valid = true;
    try { 
      DateFormat formatter ; 
      Date date ; 
      formatter = new SimpleDateFormat("MM/dd/yyyy");
      date = (Date)formatter.parse(request.getParameter("FROM")); 
      GregorianCalendar dGC = new GregorianCalendar();
      dGC.setTime(date);
      dGC.setLenient(false); 
      DYEAR = dGC.get(GregorianCalendar.YEAR); 
      DMONTH  = dGC.get(GregorianCalendar.MONTH)+1; 
      DDAY = dGC.get(GregorianCalendar.DAY_OF_MONTH); 
    } catch (Exception e) { 
      are_date_valid = false; 
    } 
    try { 
      DateFormat formatter ; 
      Date date ; 
      formatter = new SimpleDateFormat("MM/dd/yyyy");
      date = (Date)formatter.parse(request.getParameter("TO")); 
      GregorianCalendar dGC = new GregorianCalendar();
      dGC.setTime(date);
      dGC.setLenient(false); 
      EYEAR = dGC.get(GregorianCalendar.YEAR); 
      EMONTH  = dGC.get(GregorianCalendar.MONTH)+1; 
      EDAY = dGC.get(GregorianCalendar.DAY_OF_MONTH); 
    } catch (Exception e) { 
      are_date_valid = false; 
    } 
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_VENDOR_CONTRACT SET REFERENCE='"+pt.checkStr(REFERENCE)+"',DESCRIPTION='"+pt.checkStr(DESCRIPTION)+"',PRICE='"+PRICE+"',DDAY="+DDAY+",DMONTH="+DMONTH+",DYEAR="+DYEAR+",EDAY="+EDAY+",EMONTH="+EMONTH+",EYEAR="+EYEAR+" WHERE VENDORID='"+VENDORID+"' AND ID='"+ID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  if (act.equals("DELETE")) {
    Statement STU03 = Conn.createStatement();
    String QU03 = "DELETE FROM CMDB_VENDOR_CONTRACT WHERE VENDORID='"+VENDORID+"' AND ID="+ID;
    STU03.executeUpdate(QU03);
    STU03.close();
  }

    out.print("<center><strong><h1>Vendor Contract(s)</h1></strong></center><hr>");
    out.print("<table><tr><td><h2><strong>Vendor contract(s)</strong></h2></center></td><td><center><A HREF=\"vendorcontractit.jsp?TODO=ADD&VENDORID="+VENDORID+"\"><img border=0 src=\"icons/addsmall.png\"></center></A></td></tr></table></td>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\"><center>REFERENCE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>DESCRIPTION</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>FROM</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\"><center>TO</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\"><center>PRICE/YEAR</center></td>");  
    out.print("<td width=\"10%\" bgcolor=\"#FFFFFF\"><center>&nbsp;</center></td>");    
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_VENDOR_CONTRACT WHERE VENDORID='"+VENDORID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"vendorcontractit.jsp?TODO=MOD&ID="+r30.getString("ID")+"&VENDORID="+VENDORID+"\">"+r30.getString("REFERENCE")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DESCRIPTION")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getInt("DMONTH")+"/"+r30.getInt("DDAY")+"/"+r30.getInt("DYEAR")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getInt("EMONTH")+"/"+r30.getInt("EDAY")+"/"+r30.getInt("EYEAR")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" align=\"right\">"+r30.getString("PRICE")+"</td>");
      out.print("<td><center><A HREF=\"deletevendorcontract.jsp?TODO=DELETE&VENDORID="+VENDORID+"&ID="+r30.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
    Conn.close();
}
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>

