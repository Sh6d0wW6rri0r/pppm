
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
        String PROJECTID = request.getParameter("PROJECTID");
        String RISKID = request.getParameter("RISKID");
      	if (act.equals("ADD")) {  
          out.print("<center><table><tr><td><img border=0 src=\"icons/risks.png\"></td><td><strong><h1>Add project risk</h1></strong></td></tr></table></center><hr>");
        } else {
          out.print("<center><table><tr><td><img border=0 src=\"icons/risks.png\"></td><td><strong><h1>Modify project risk</h1></strong></td></tr></table></center><hr>");
        }
        out.print("<hr>");
        String NAME = "";
        String DESCRIPTION = "";
        Calendar rn= Calendar.getInstance();
        String DATE_DISCOVER = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
        String DATE_CLOSING = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
        String EMPLOYEEID="";
        String IMPACT="0";
        String LIKELIHOOD="0";
        String ESCALATE="N";
        String CLOSED="N";
        if (act.equals("ADD")) {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectrisk.jsp?TODO=RSKADD&PROJECTID="+PROJECTID+"\" target=\"_top\">");
        } else {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectrisk.jsp?TODO=RSKMOD&PROJECTID="+PROJECTID+"&RISKID="+RISKID+"\" target=\"_top\">");
        }
        if (act.equals("MOD")) {
          Statement STR01 = Conn.createStatement();
          String QR01 = "SELECT ID,NAME,DESCRIPTION,DATE_DISCOVER,DATE_CLOSING,EMPLOYEEID,IMPACT,LIKELIHOOD,ESCALATE,CLOSED FROM PROJECT_RISK WHERE PROJECTID='"+PROJECTID+"' AND ID="+RISKID;
          ResultSet R01 = STR01.executeQuery(QR01);
          if (R01.next()) {
            NAME=R01.getString("NAME");
            DESCRIPTION=R01.getString("DESCRIPTION");
            DATE_DISCOVER=R01.getString("DATE_DISCOVER");
            DATE_CLOSING=R01.getString("DATE_CLOSING");
            EMPLOYEEID=R01.getString("EMPLOYEEID");
            IMPACT=R01.getString("IMPACT");
            LIKELIHOOD=R01.getString("LIKELIHOOD");
            ESCALATE=R01.getString("ESCALATE");
            CLOSED=R01.getString("CLOSED");
          }
          STR01.close();
        }
        out.print("<table>");
        out.print("<tr><td>Name : </td><td><input name=\"NAME\" type=\"text\" size=\"50\" value=\""+NAME+"\"></td></tr>");
        out.print("<tr><td>Description : </td><td><textarea name=\"DESCRIPTION\" cols=\"60\" rows=\"5\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");
        out.print("<tr><td>Date discovered : </td><td><input name=\"DATE_DISCOVER\" type=\"text\" size=\"50\" value=\""+DATE_DISCOVER+"\" readonly=\"readonly\">");
        out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_DISCOVER'}); </script>");
        out.print("</td></tr>");
        out.print("<tr><td>Closed : </td><td><INPUT TYPE=\"checkbox\" NAME=\"CLOSED\" VALUE=\"+CLOSED+\"");
        if (CLOSED.equals("Y")) {
          out.print(" CHECKED ");
        }
        out.print("></td></tr>");	
        out.print("<tr><td>Date closed : </td><td><input name=\"DATE_CLOSING\" type=\"text\" size=\"50\" value=\""+DATE_CLOSING+"\" readonly=\"readonly\">");  
        out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_CLOSING'}); </script>");
        out.print("</td></tr>");
        out.print("<tr><td>Responsible : </td><td><select name=\"EMPLOYEEID\">");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (SELECT EMPLOYEEID FROM RESOURCE_USER_ACTIVITY WHERE PROJECTID='"+PROJECTID+"' AND APPROVED='YES')";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<option");
          if (EMPLOYEEID.equals(R02.getString("ID"))) {
            out.print(" selected ");
          }
          out.print(">"+R02.getString("ID")+" - "+R02.getString("NAME")+" "+R02.getString("FORNAME")+"</option>");
        }
        STR02.close();
        out.print("</select></td></tr>");
        out.print("<tr><td>Impact : </td><td><select name=\"IMPACT\">");
        for (int i=1;i<=5;i++) {
          out.print("<option");
          if (IMPACT.equals(""+i)) {
            out.print(" selected ");
          }
          out.print(">"+i+"</option>");
        }
        out.print("</select></td></tr>");
        out.print("<tr><td>Likelihood : </td><td><select name=\"LIKELIHOOD\">");
        for (int i=1;i<=5;i++) {
          out.print("<option");
          if (LIKELIHOOD.equals(""+i)) {
            out.print(" selected ");
          }
          out.print(">"+i+"</option>");
        }
        out.print("</select></td></tr>");
        out.print("<tr><td>Escalate to program </td><td><INPUT TYPE=\"checkbox\" NAME=\"ESCALATE\" VALUE=\"+ESCALATE+\"");
        if (ESCALATE.equals("Y")) {
          out.print(" CHECKED ");
        }
        out.print("></td></tr>");
        out.print("</table>");
        if (act.equals("ADD")) {
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"projectrisk.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        } else {  
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"projectrisk.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        }
        out.print("</table>");
        out.print("</form>");
        Conn.close();
      }

    %>
  </body>
</html>
