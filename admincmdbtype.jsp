
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
        String PROGRAMID = request.getParameter("PROGRAMID");      	
        PPPMTools pmt = new PPPMTools();
        if (act.equals("APPADD")) {
          String APPLICATIONID = request.getParameter("APPLICATIONID");
          String NAME = request.getParameter("NAME");
          Statement STU01 = Conn.createStatement();
          String QU01 = "INSERT INTO APPLICATIONTYPE VALUES ('"+pmt.checkStr(APPLICATIONID)+"','"+pmt.checkStr(NAME)+"')";
          STU01.executeUpdate(QU01);
          STU01.close();
        }
        if (act.equals("APPMOD")) {
          String APPLICATIONID = request.getParameter("APPLICATIONID");
          String NAME = request.getParameter("NAME");
          Statement STU02 = Conn.createStatement();
          String QU02 = "UPDATE APPLICATIONTYPE SET NAME='"+pmt.checkStr(NAME)+"' WHERE ID='"+APPLICATIONID+"'";
          STU02.executeUpdate(QU02);
          STU02.close();
        }
        if (act.equals("APPDELETE")) {
          String APPLICATIONID = request.getParameter("APPLICATIONID");
          Statement STU03 = Conn.createStatement();
          String QU03 = "DELETE FROM APPLICATIONTYPE WHERE ID='"+APPLICATIONID+"'";
          STU03.executeUpdate(QU03);
          STU03.close();
        }
        if (act.equals("INFADD")) {
          String INFRASTRUCTUREID = request.getParameter("INFRASTRUCTUREID");
          String NAME = request.getParameter("NAME");
          Statement STU04 = Conn.createStatement();
          String QU04 = "INSERT INTO INFRASTRUCTURETYPE VALUES ('"+pmt.checkStr(INFRASTRUCTUREID)+"','"+pmt.checkStr(NAME)+"')";
          STU04.executeUpdate(QU04);
          STU04.close();
        }
        if (act.equals("INFMOD")) {
          String INFRASTRUCTUREID = request.getParameter("INFRASTRUCTUREID");
          String NAME = request.getParameter("NAME");
          Statement STU05 = Conn.createStatement();

          String QU05 = "UPDATE INFRASTRUCTURETYPE SET NAME='"+pmt.checkStr(NAME)+"' WHERE ID='"+INFRASTRUCTUREID+"'";
          STU05.executeUpdate(QU05);
          STU05.close();
        }
        if (act.equals("INFDELETE")) {
          String INFRASTRUCTUREID = request.getParameter("INFRASTRUCTUREID");
          Statement STU06 = Conn.createStatement();
          String QU06 = "DELETE FROM INFRASTRUCTURETYPE WHERE ID='"+INFRASTRUCTUREID+"'";
          STU06.executeUpdate(QU06);
          STU06.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>CMDB types</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Administration \\ CMDB tpyes</td><td><A HREF=\"admincmdbtype.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<hr><table><tr><td><h2><strong>Application type(s)</strong></h2></center></td><td><A HREF=\"adminaddapplicationcmdb.jsp?TODO=ADD\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"20%\"  background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td width=\"35%\"  background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME FROM APPLICATIONTYPE";
        ResultSet R01 = STR01.executeQuery(QR01);
        while(R01.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+R01.getString("ID")+"</td><td><A HREF=\"adminaddapplicationcmdb.jsp?TODO=MOD&APPLICATIONID="+R01.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+R01.getString("NAME")+"</center></A></td>");
          out.print("<td><center><A HREF=\"admindeleteapplicationcmdb.jsp?TODO=DELETE&APPLICATIONID="+R01.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR01.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Infrastructure type(s)</strong></h2></center></td><td><A HREF=\"adminaddinfrastructurecmdb.jsp?TODO=ADD\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td width=\"35%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT ID,NAME FROM INFRASTRUCTURETYPE";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+R02.getString("ID")+"</td><td><A HREF=\"adminaddinfrastructurecmdb.jsp?TODO=MOD&INFRASTRUCTUREID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+R02.getString("NAME")+"</center></A></td>");
          out.print("<td><center><A HREF=\"admindeleteinfrastructurecmdb.jsp?TODO=DELETE&INFRASTRUCTUREID="+R02.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR02.close();
        out.print("</table>");
        Conn.close();
      }

    %>
  </body>
</html>
