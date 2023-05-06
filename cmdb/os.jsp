
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
  String ID = request.getParameter("ID");
  String RO = request.getParameter("RO");
  PPPMTools pt = new PPPMTools();

  if (act.equals("ADD")) {
    String NAME = request.getParameter("NAME");
    String VERSION = request.getParameter("VERSION");
    String VENDORIDtmp = pt.checkStr(request.getParameter("VENDORID"));
    String VENDORID="NONE";
    if (!VENDORIDtmp.equals("NONE")) {
      VENDORID = VENDORIDtmp.substring(0,VENDORIDtmp.indexOf("-")-1);
    }
    int ESDAY=0;
    int ESMONTH=0;
    int ESYEAR=0;
        
    boolean are_date_valid = true;
    try { 
      DateFormat formatter ; 
      Date date ; 
      formatter = new SimpleDateFormat("MM/dd/yyyy");
      date = (Date)formatter.parse(request.getParameter("ESDATE")); 
      GregorianCalendar dGC = new GregorianCalendar();
      dGC.setTime(date);
      dGC.setLenient(false); 
      ESYEAR = dGC.get(GregorianCalendar.YEAR); 
      ESMONTH  = dGC.get(GregorianCalendar.MONTH)+1; 
      ESDAY = dGC.get(GregorianCalendar.DAY_OF_MONTH); 
    } catch (Exception e) { 
      are_date_valid = false; 
    } 
    Statement sti2 = Conn.createStatement();
    Statement st10 = Conn.createStatement();
    String q10 = "SELECT * FROM INDX WHERE ID='OS'";
    ResultSet r10 = st10.executeQuery(q10);
    r10.next();
    int idnum=r10.getInt("SEQ");
    int newidnum=idnum+1;
    st10.close();
    Statement sti10 = Conn.createStatement();
    String i10 = "UPDATE INDX SET SEQ="+newidnum+" WHERE ID='OS'";
    sti10.executeUpdate(i10);
    sti10.close();
    
    String idfill="";
    String idtmp = ""+idnum;
    for (int j =0; j<7-idtmp.length();j++) {
      idfill=idfill+"0";
    }
    idfill=idfill+idtmp;

    String i2 = "INSERT INTO CMDB_OS VALUES ('"+idfill+"','"+pt.checkStr(NAME)+"','"+VENDORID+"',"+ESDAY+","+ESMONTH+","+ESYEAR+",'"+pt.checkStr(VERSION)+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  
  if (act.equals("MOD")) {
    String NAME = request.getParameter("NAME");
    String VERSION = request.getParameter("VERSION");
    String VENDORIDtmp = pt.checkStr(request.getParameter("VENDORID"));
    String VENDORID="NONE";
    if (!VENDORIDtmp.equals("NONE")) {
      VENDORID = VENDORIDtmp.substring(0,VENDORIDtmp.indexOf("-")-1);
    }
    int ESDAY=0;
    int ESMONTH=0;
    int ESYEAR=0;
        
    boolean are_date_valid = true;
    try { 
      DateFormat formatter ; 
      Date date ; 
      formatter = new SimpleDateFormat("MM/dd/yyyy");
      date = (Date)formatter.parse(request.getParameter("ESDATE")); 
      GregorianCalendar dGC = new GregorianCalendar();
      dGC.setTime(date);
      dGC.setLenient(false); 
      ESYEAR = dGC.get(GregorianCalendar.YEAR); 
      ESMONTH  = dGC.get(GregorianCalendar.MONTH)+1; 
      ESDAY = dGC.get(GregorianCalendar.DAY_OF_MONTH); 
    } catch (Exception e) { 
      are_date_valid = false; 
    } 

    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_OS SET NAME='"+pt.checkStr(NAME)+"',VENDORID='"+VENDORID+"',ESDAY="+ESDAY+",ESMONTH="+ESMONTH+",ESYEAR="+ESYEAR+",VERSION='"+pt.checkStr(VERSION)+"' WHERE ID='"+ID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }


    out.print("<center><strong><h1>Operating Systems</h1></strong></center><hr>");


    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\"><center><strong>NAME</strong></center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center><strong>VERSION</strong></center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center><strong>END SUPPORT</strong></center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\"><center><strong>VENDOR</strong></center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\"><center><strong>SERVICE PACK</strong></center></td>");  
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_OS";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"osit.jsp?TODO=MOD&ID="+r30.getString("ID")+"\">"+r30.getString("NAME")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("VERSION")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("ESMONTH")+"/"+r30.getString("ESDAY")+"/"+r30.getString("ESYEAR")+"</center></td>");
      Statement st32 = Conn.createStatement();
      String q32 = "SELECT * FROM VENDOR WHERE ID='"+r30.getString("VENDORID")+"'";
      ResultSet r32 = st32.executeQuery(q32);
      if(r32.next()) {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r32.getString("NAME")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></td>");
      }
      st32.close();
      int nbcontract=0;
      Statement st31 = Conn.createStatement();
      String q31 = "SELECT * FROM CMDB_SP WHERE OSID='"+r30.getString("ID")+"'";
      ResultSet r31 = st31.executeQuery(q31);
      while(r31.next()) {
        nbcontract++;
      }
      st31.close();
      out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"sp.jsp?TODO=NONE&OSID="+r30.getString("ID")+"\">"+nbcontract+"</center></A></td>");      
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"osit.jsp?TODO=ADD\" target=\"appliFrame\">");
      out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
