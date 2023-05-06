
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: 11px}
      h1 { color: black; font-family: arial; font-size: 16px}
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
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>

  <body background="images/fond.gif">
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
        String PRODUCTID = request.getParameter("PRODUCTID");
        String ACTIVITYID = request.getParameter("ACTIVITYID");
      	out.print("<center><strong><h1>Profiles</h1></strong></center><hr>");
        out.print("<table><tr><td>You are here : Products Portfolio \\ <A HREF=\"productportfolio.jsp?TODO=NONE\" target=\"appliFrame\"> Products</A> \\ <A HREF=\"productplanning.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"\"> Product Planning </A>\\ <A HREF=\"productresourcesactivity.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"\"> Activity resources</A> \\ Add profile");
        out.print("<hr>");
        String NAME = "";
        String FORNAME = "";
        String FUNCTION = "";
        String SITEID = "";
        String DEPTID = "";
        out.print("<table>");
        out.print("<tr><td>ID</td>");
        out.print("<td>Name</td></tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME FROM PROFILE";
        ResultSet R01 = STR01.executeQuery(QR01);
        while(R01.next()) {
          out.print("<tr><td><A HREF=\"productresourcesactivity.jsp?TODO=PROADD&PROFILEID="+R01.getString("ID")+"&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"\">"+R01.getString("ID")+"</td>");
          out.print("<td>"+R01.getString("NAME")+"</td></tr>");
        }
        STR01.close();
        out.print("</table>");
        out.print("<A HREF=\"productresourcesactivity.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"\"><img border=0 src=\"icons/cancel.png\"></A>");
        Conn.close();
      }

    %>
  </body>
</html>
