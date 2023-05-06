
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
  <%@ page import = "java.util.GregorianCalendar" %>
  <%@ page import = "java.text.DateFormat" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>
  <%@ page import = "fr.pppm.*" %>


  <body>

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
      	PPPMTools pmt = new PPPMTools();
        if (act.equals("DIVADD")) {
          String DIVISIONID = request.getParameter("DIVISIONID");
          String NAME = request.getParameter("NAME");
          Statement STU01 = Conn.createStatement();
          String QU01 = "INSERT INTO DIVISION VALUES ('"+pmt.checkStr(DIVISIONID)+"','"+pmt.checkStr(NAME)+"')";
          STU01.executeUpdate(QU01);
          STU01.close();
        }
        if (act.equals("DIVMOD")) {
          String DIVISIONID = request.getParameter("DIVISIONID");
          String NAME = request.getParameter("NAME");
          Statement STU02 = Conn.createStatement();
          String QU02 = "UPDATE DIVISION SET NAME='"+pmt.checkStr(NAME)+"' WHERE ID='"+DIVISIONID+"'";
          STU02.executeUpdate(QU02);
          STU02.close();
        }
        if (act.equals("DIVDELETE")) {
          String DIVISIONID = request.getParameter("DIVISIONID");
          Statement STU03 = Conn.createStatement();
          String QU03 = "DELETE FROM DIVISION WHERE ID='"+DIVISIONID+"'";
          STU03.executeUpdate(QU03);
          STU03.close();
        }
        if (act.equals("SITADD")) {
          String SITEID = request.getParameter("SITEID");
          String NAME = request.getParameter("NAME");
          String DIDTMP = request.getParameter("DIVISIONID");
          String DIVISIONID = DIDTMP.substring(0,DIDTMP.indexOf("-")-1);
          String BIDTMP = request.getParameter("BITLID");
          String BITLID = BIDTMP.substring(0,BIDTMP.indexOf("-")-1);
          Statement STU04 = Conn.createStatement();
          String QU04 = "INSERT INTO LOCATION VALUES ('"+pmt.checkStr(SITEID)+"','"+pmt.checkStr(NAME)+"','"+DIVISIONID+"','"+BITLID+"')";
          STU04.executeUpdate(QU04);
          STU04.close();
        }
        if (act.equals("SITMOD")) {
          String SITEID = request.getParameter("SITEID");
          String NAME = request.getParameter("NAME");
          String DIDTMP = request.getParameter("DIVISIONID");
          String DIVISIONID = DIDTMP.substring(0,DIDTMP.indexOf("-")-1);
          String BIDTMP = request.getParameter("BITLID");
          String BITLID = BIDTMP.substring(0,BIDTMP.indexOf("-")-1);
          Statement STU05 = Conn.createStatement();
          String QU05 = "UPDATE LOCATION SET NAME='"+pmt.checkStr(NAME)+"',DIVISIONID='"+DIVISIONID+"',BITLID='"+BITLID+"' WHERE ID='"+SITEID+"'";
          STU05.executeUpdate(QU05);
          STU05.close();
        }
        if (act.equals("SITDELETE")) {
          String SITEID = request.getParameter("SITEID");
          Statement STU06 = Conn.createStatement();
          String QU06 = "DELETE FROM LOCATION WHERE ID='"+SITEID+"'";
          STU06.executeUpdate(QU06);
          STU06.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>Location(s)</h1></strong></td></tr></table></center><hr>");
        out.print("<Table><tr><td>You are here : Administration \\ Manage location(s)</td><td><A HREF=\"adminlocation.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Division(s)</strong></h2></center></td>");
        out.print("<td><A HREF=\"adminaddlocationdivision.jsp?TODO=ADD\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("<td>&nbsp;</td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME FROM DIVISION";
        ResultSet R01 = STR01.executeQuery(QR01);
        while(R01.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF><center><table><tr><td>"+R01.getString("ID")+"</td><td><td><A HREF=\"adminaddlocationdivision.jsp?TODO=MOD&DIVISIONID="+R01.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+R01.getString("NAME")+"</center></td>");
          out.print("<td><center><A HREF=\"admindeletelocationdivision.jsp?TODO=DELETE&DIVISIONID="+R01.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR01.close();
        out.print("</table>");
        out.print("<table><tr><td><h2><strong>Site(s)</strong></h2></center></td>");
        out.print("<td><A HREF=\"adminaddlocationsite.jsp?TODO=ADD\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Division</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>BITL</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Calendar</center></td>");
        out.print("<td>&nbsp;</td>");
        out.print("</tr>");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT ID,NAME,DIVISIONID,BITLID FROM LOCATION";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF><center><table><tr><td>"+R02.getString("ID")+"</td><td><td><A HREF=\"adminaddlocationsite.jsp?TODO=MOD&SITEID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("NAME")+"</center></td>");
          Statement STR03 = Conn.createStatement();
          String QR03 = "SELECT NAME FROM DIVISION WHERE ID='"+R02.getString("DIVISIONID")+"'";
          ResultSet R03 = STR03.executeQuery(QR03);
          if (R03.next()) {
            out.print("<td bgcolor=#FFFFFF><center>"+R03.getString("NAME")+"</center></td>");
          }
          STR03.close();
          Statement STR04 = Conn.createStatement();
          String QR04 = "SELECT NAME,FORNAME FROM EMPLOYEE WHERE ID='"+R02.getString("BITLID")+"'";
          ResultSet R04 = STR04.executeQuery(QR04);
          if (R04.next()) {
            out.print("<td bgcolor=#FFFFFF><center>"+R04.getString("NAME")+" "+R04.getString("FORNAME")+"</center></td>");
          }
          STR04.close();
          out.print("<td bgcolor=#FFFFFF><center><A HREF=\"admincalendar.jsp?TODO=NONE&SITEID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></center></td>");
          out.print("<td><center><A HREF=\"admindeletelocationsite.jsp?TODO=DELETE&SITEID="+R02.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR02.close();
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
