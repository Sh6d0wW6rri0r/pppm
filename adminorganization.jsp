
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


  <%@ page import = "java.io.*" %>
  <%@ page import = "java.util.*" %>
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


  <%!void displayorganization(String FATHER,Connection Conn,javax.servlet.jsp.JspWriter out,int level) throws Exception {
      Statement STR01 = Conn.createStatement();  
      String QR01 = "SELECT NAME,ID,EMPLOYEEID FROM OU WHERE FATHER='"+FATHER+"'";
      ResultSet R01 = STR01.executeQuery(QR01);
      while(R01.next()) {   
        out.print("<tr>");
        out.print("<td><table><tr>");
        out.print("<td><center><A HREF=\"adminaddou.jsp?TODO=ADD&FATHER="+R01.getString("ID")+"\"><img border=0 src=\"icons/addsmall.png\"></A></center></td>");
        out.print("<td><center><A HREF=\"admindeleteou.jsp?TODO=DELETE&OUID="+R01.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></A></center></td>");
        out.print("</tr></td></table></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"80%\">");
        for (int i=0;i<level;i++) {
          out.print("&nbsp;&nbsp;&nbsp;");
        }
        out.print(""+R01.getString("NAME")+"</td><td width=\"20%\"><A HREF=\"adminaddou.jsp?TODO=MOD&ID="+R01.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"80%\"><center>"+R01.getString("EMPLOYEEID")+"</center></td><td width=\"20%\"><A HREF=\"oumanager.jsp?TODO=NONE&OUID="+R01.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+R01.getString("ID")+"</center></td>");
        out.print("</tr>");    
        displayorganization(R01.getString("ID"),Conn,out,level+1);
      } 
      STR01.close();
    }
  
%>

  <%!void deleteou(String ID,Connection Conn) throws Exception {
      Statement st31 = Conn.createStatement();  
      String q31 = "SELECT ID FROM OU WHERE FATHER='"+ID+"'";
      ResultSet r31 = st31.executeQuery(q31);
      while(r31.next()) {  
        deleteou(r31.getString("ID"),Conn);
      }
      st31.close();
      Statement sti2 = Conn.createStatement();
      String i2 = "DELETE FROM OU WHERE ID='"+ID+"'";
      sti2.executeUpdate(i2);
      sti2.close();
    }
  
%>

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
        if (act.equals("OUADD")) {
          String ID  = request.getParameter("ID");
          String FATHER  = request.getParameter("FATHER");
          String NAME  = request.getParameter("NAME");
          Statement STU01 = Conn.createStatement();
          String QU01 = "INSERT INTO OU VALUES ('"+ID+"','"+NAME+"','"+FATHER+"','')";
          STU01.executeUpdate(QU01);
          STU01.close();
        }
        if (act.equals("OUMOD")) {
          String ID  = request.getParameter("ID");
          String NAME=request.getParameter("NAME");
          Statement STU02 = Conn.createStatement();
          String QU02 = "UPDATE OU SET NAME='"+NAME+"' WHERE ID='"+ID+"'";
          STU02.executeUpdate(QU02);
          STU02.close();       
        }
        if (act.equals("OUDELETE")) {
          String OUID  = request.getParameter("OUID");
          deleteou(OUID,Conn);
        }
        if (act.equals("MANAGER")) {
          String ID  = request.getParameter("ID");
          String OUID=request.getParameter("OUID");
          Statement STU03 = Conn.createStatement();
          String QU03 = "UPDATE OU SET EMPLOYEEID='"+ID+"' WHERE ID='"+OUID+"'";
          STU03.executeUpdate(QU03);
          STU03.close();       
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/organization.png\"></td><td><strong><h1>Organizational structure</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Administration \\ Organization management </td><td><A HREF=\"adminorganization.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"5%\"><center>&nbsp;</center></td>");
        out.print("<td width=\"75%\" background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>MANAGER</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>ID</center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td><table><tr>");
        out.print("<td><center><A HREF=\"adminaddou.jsp?TODO=ADD&FATHER=ROOT\"><img border=0 src=\"icons/addsmall.png\"></A></center></td>");
        out.print("<td><center>&nbsp;</center></td>");
        out.print("</tr></td></table></td>");
        out.print("<td bgcolor=\"#EFEFEF\">ORGANIZATIONAL STRUCTURE</A></td>");
        out.print("<td bgcolor=\"#EFEFEF\"><center>---</center></A></td>");
        out.print("<td bgcolor=\"#EFEFEF\"><center>ROOT</center></A></td>");        
        out.print("</tr>");
        displayorganization("ROOT",Conn,out,1);
        out.print("</table>");
        Conn.close();
      }

    %>
  </body>
</html>
