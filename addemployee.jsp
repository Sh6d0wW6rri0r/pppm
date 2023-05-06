
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
  <%@ page import = "fr.pppm.*" %>
  

  <body>
    <script language="JavaScript" src="javascript/calendar_db.js"></script>
    <link rel="stylesheet" href="javascript/calendar.css">
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
        String ID = request.getParameter("EID");
        String currentpage= request.getParameter("PAGE");
      	out.print("<hr>");
        String NAME = "-";
        String FORNAME = "-";
        String OUID="ENT";
        String CONTRACTOR="N";
        String SITEID="-";
        String PROFILEID="-";
        String SKILL="0";
        String CAPACITY="160";
        String RATE="0";
        if (act.equals("ADD")) {
          ID="";
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"adminemployee.jsp?TODO=ADD&PAGE="+currentpage+"\" target=\"appliFrame\">");
        } else {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"adminemployee.jsp?TODO=MOD&EID="+ID+"&PAGE="+currentpage+"\" target=\"appliFrame\">");
        }
        if (act.equals("MOD")) {
            Employee e = new Employee(Conn,ID);
            NAME=e.getName();
            FORNAME=e.getForname();
            OUID=e.getOuid();
            CONTRACTOR=e.getContractor();
            SITEID=e.getSiteid();
            PROFILEID=e.getProfileid();
            SKILL=""+e.getSkill();
            CAPACITY=""+e.getCapacity();
            RATE=""+e.getRate();
        }
        out.print("<table>");
        out.print("<tr><td>Name : </td><td><input name=\"NAME\" type=\"text\" size=\"50\" value=\""+NAME+"\"></td></tr>");
        out.print("<tr><td>Forname : </td><td><input name=\"FORNAME\" type=\"text\" size=\"50\" value=\""+FORNAME+"\"></td></tr>");
        out.print("<tr><td>OU Id : </td><td><input name=\"OUID\" type=\"text\" size=\"50\" value=\""+OUID+"\"></td></tr>");
        out.print("<tr><td>Contractor : </td><td><INPUT TYPE=\"checkbox\" NAME=\"CONTRACTOR\" VALUE=\"+CONTRACTOR+\"");
        if (CONTRACTOR.equals("Y")) {
          out.print(" CHECKED ");
        }
        out.print("></td></tr>");
        out.print("<tr><td>Site Id : </td><td><input name=\"SITEID\" type=\"text\" size=\"50\" value=\""+SITEID+"\"></td></tr>");
        out.print("<tr><td>Profile : </td><td><select name=\"PROFILEID\">");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT ID,NAME FROM PROFILE";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<option");
          if (PROFILEID.equals(R02.getString("ID"))) {
            out.print(" selected ");
          }
          out.print(">"+R02.getString("ID")+" - "+R02.getString("NAME")+"</option>");
        }
        STR02.close();
        out.print("</select></td></tr>");
        out.print("<tr><td>Skills : </td><td><input name=\"SKILL\" type=\"text\" size=\"50\" value=\""+SKILL+"\"></td></tr>");
        out.print("<tr><td>Capacity : </td><td><input name=\"CAPACITY\" type=\"text\" size=\"50\" value=\""+CAPACITY+"\"></td></tr>");

        if (act.equals("ADD")) {
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"adminemployee.jsp?TODO=NONE&PAGE="+currentpage+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        } else {  
          out.print("<tr><td>Rate : </td><td><input name=\"RATE\" type=\"text\" size=\"50\" value=\""+RATE+"\"></td></tr>"); 
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"adminemployee.jsp?TODO=NONE&PAGE="+currentpage+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        }
        out.print("</table>");
        out.print("</form>");
        Conn.close();
      }
    %>
  </body>
</html>
