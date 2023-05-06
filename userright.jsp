
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
        String LOGIN = request.getParameter("LOGIN");
      	User us = new User(Conn);
        if (act.equals("URADD")) {
          String RIGHT = request.getParameter("RIGHT");
          us.addRight(LOGIN,RIGHT); 
        }
        if (act.equals("URDELETE")) {
          String RIGHT = request.getParameter("RIGHT");
          us.deleteRight(LOGIN,RIGHT); 
        }
        out.print("<center><strong><h1>User rights management</h1></strong></center><hr>");
        out.print("<Table><tr><td>You are here : Administration \\ <A HREF=\"user.jsp?TODO=NONE&PAGE=0\">Manage user(s)</A> \\ Manage user right(s)</td><td><A HREF=\"userright.jsp?TODO=NONE&LOGIN="+LOGIN+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>User</strong></h2></center></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Login</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Forname</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>LDAP login</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Disabled</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Mail</center></td>");
        out.print("</tr>");
        Statement st130 = Conn.createStatement();
        String q130 = "SELECT LOGIN,NAME,FORNAME,LDAPLOGIN,DISABLED,MAIL FROM USERS WHERE LOGIN='"+LOGIN+"'";
        ResultSet r130 = st130.executeQuery(q130);
        if (r130.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF><center>"+r130.getString("LOGIN")+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+r130.getString("NAME")+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+r130.getString("FORNAME")+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+r130.getString("LDAPLOGIN")+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+r130.getString("DISABLED")+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+r130.getString("MAIL")+"</center></td>");
          out.print("</tr>");
        }
        st130.close();
        out.print("</table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>User right(s)</strong></h2></center></td><td><A HREF=\"rightit.jsp?TODO=ADD&LOGIN="+LOGIN+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"90%\" background=\"images/fond_titre.jpg\"><center>Right</center></td>");
        out.print("<td>&nbsp;</td>");
        out.print("</tr>");
        Statement st131 = Conn.createStatement();
        String q131 = "SELECT USERRIGHT FROM USER_RIGHT WHERE LOGIN='"+LOGIN+"'";
        ResultSet r131 = st131.executeQuery(q131);
        while (r131.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF><center>"+r131.getString("USERRIGHT")+"</center></td>");
          out.print("<td><center><A HREF=\"deleteright.jsp?TODO=DELETE&RIGHT="+r131.getString("USERRIGHT")+"&LOGIN="+LOGIN+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        st131.close();
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
