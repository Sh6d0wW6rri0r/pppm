
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
        String REQ = request.getParameter("REQ");
        String PROJECTID = request.getParameter("PROJECTID");
        String GROUPID = request.getParameter("GROUPID");
      	out.print("<center><strong><h1>Score project</h1></strong></center><hr>");
        out.print("You are here : Portfolio \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\">Projects </A> \\ Score");
        out.print("<hr>");
        if (REQ.equals("N")) {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectdetails.jsp?TODO=SCORE&PROJECTID="+PROJECTID+"\" target=\"appliFrame\">");
        } else {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"requestdetails.jsp?TODO=SCORE&PROJECTID="+PROJECTID+"\" target=\"appliFrame\">");
        }
        out.print("<table>");
        Statement st10 = Conn.createStatement();
        String q10 = "SELECT ID,NAME FROM SCORING_GROUP WHERE ID='"+GROUPID+"'";
        ResultSet r10 = st10.executeQuery(q10);
        while (r10.next()) {
          out.print("<tr><td colspan=3 background=\"images/fond_titre.jpg\">"+r10.getString("NAME")+"</td></tr>");
          Statement st11 = Conn.createStatement();
          String q11 = "SELECT ID,NAME,GROUPID,DESCRIPTION FROM SCORING_QUESTION WHERE GROUPID='"+r10.getString("ID")+"'";
          ResultSet r11 = st11.executeQuery(q11);
          while (r11.next()) {
            out.print("<tr><td width=100px>&nbsp;</td><td>"+r11.getString("NAME")+"</td><td><select name=\""+r11.getString("ID")+"\">");
            Statement st12 = Conn.createStatement();
            String q12 = "SELECT ID,NAME,QUESTIONID FROM SCORING_QUESTION_ANSWER WHERE QUESTIONID='"+r11.getString("ID")+"' ORDER BY ID DESC";
            ResultSet r12 = st12.executeQuery(q12);
            while (r12.next()) {
              out.print("<option");
              Statement st13 = Conn.createStatement();
              String q13 = "SELECT PROJECTID,QUESTIONID,ANSWERID FROM PRJANS WHERE PROJECTID='"+PROJECTID+"' AND QUESTIONID='"+r11.getString("ID")+"' AND ANSWERID='"+r12.getString("ID")+"'";
              ResultSet r13 = st13.executeQuery(q13);
              if (r13.next()) { 
                out.print("  selected ");
              }
              st13.close();
              out.print(">"+r12.getString("NAME")+"</option>");        
            }
            out.print("</select></td></tr>");
            st12.close();
            out.print("<tr><td>&nbsp;</td><td>&nbsp;</td><td bgcolor=#EFEFEF>"+r11.getString("DESCRIPTION")+"</td></tr>");
            out.print("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></center>");
          }
          st11.close();      
        }
        out.print("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></center>");
        if (REQ.equals("N")) {
          out.print("<tr><td>&nbsp;</td><td><input type=\"image\" border=0 src=\"icons/modify.png\" name=\"Score\" value=\"submit\"></td><td><A HREF=\"projectdetails.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></center>");
        } else {
          out.print("<tr><td>&nbsp;</td><td><input type=\"image\" border=0 src=\"icons/modify.png\" name=\"Score\" value=\"submit\"></td><td><A HREF=\"requestdetails.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></center>");
        }
        out.print("</table>");
        st10.close();
        out.print("</form>");
        Conn.close();
      }

    %>
  </body>
</html>
