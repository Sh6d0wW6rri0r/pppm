
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: 11px}
      h1 { color: black; font-family: arial; font-size: 16px}
      h2 { color: black; font-family: arial; font-size: 13px}
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
        String TEMPLATE = request.getParameter("TEMPLATE");
        String ORD = request.getParameter("ORD");
      	PPPMTools pmt = new PPPMTools();
        if (act.equals("ADD")) {
          Statement STR02 = Conn.createStatement();
          String QR02 = "SELECT ACTORD FROM PHASE_TEMPLATE_ACTIVITY WHERE TEMPLATE='"+TEMPLATE+"' AND ORD="+ORD+" ORDER BY ACTORD DESC";
          ResultSet R02 = STR02.executeQuery(QR02);
          int actord=0;
          if (R02.next()) {
            actord=R02.getInt("ACTORD")+1;
          }
          STR02.close();
          String NAME = request.getParameter("NAME");
          String DOCLINK = request.getParameter("DOCLINK");
          if (!DOCLINK.startsWith("http")) {
            DOCLINK="http://"+DOCLINK;
          }
          String WORKLOAD = request.getParameter("WORKLOAD");
          Statement STU01 = Conn.createStatement();
          String QU01 = "INSERT INTO PHASE_TEMPLATE_ACTIVITY VALUES ('"+pmt.checkStr(TEMPLATE)+"',"+ORD+",'"+pmt.checkStr(NAME)+"','"+pmt.checkStr(WORKLOAD)+"','"+pmt.checkStr(DOCLINK)+"',"+actord+")";
          STU01.executeUpdate(QU01);
          STU01.close();
        }
        if (act.equals("MOD")) {
          String ACTORD = request.getParameter("ACTORD");
          String NAME = request.getParameter("NAME");
          String DOCLINK = request.getParameter("DOCLINK");
          if (!DOCLINK.startsWith("http")) {
            DOCLINK="http://"+DOCLINK;
          }
          String WORKLOAD = request.getParameter("WORKLOAD");
          Statement STU02 = Conn.createStatement();
          String QU02 = "UPDATE PHASE_TEMPLATE_ACTIVITY SET NAME='"+pmt.checkStr(NAME)+"',WORKLOAD='"+pmt.checkStr(WORKLOAD)+"',DOCLINK='"+pmt.checkStr(DOCLINK)+"' WHERE TEMPLATE='"+TEMPLATE+"' AND ORD="+ORD+" AND ACTORD="+ACTORD;
          STU02.executeUpdate(QU02);
          STU02.close();
        }
        if (act.equals("DELETE")) {
          String ACTORD = request.getParameter("ACTORD");
          Statement STU03 = Conn.createStatement();
          String QU03 = "DELETE FROM PHASE_TEMPLATE_ACTIVITY WHERE TEMPLATE='"+TEMPLATE+"' AND ORD="+ORD+" AND ACTORD="+ACTORD;
          STU03.executeUpdate(QU03);
          STU03.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>Phase template(s)</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Administration \\ <A HREF=\"adminphasetemplate.jsp?TODO=NONE\"> Phase template(s)</A> \\ Activity(s)</td><td><A HREF=\"admintemplateactivity.jsp?TODO=NONE&TEMPLATE="+TEMPLATE+"&ORD="+ORD+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Phase template activity(s)</strong></h2></center></td><td><A HREF=\"adminaddtemplateactivity.jsp?TODO=ADD&TEMPLATE="+TEMPLATE+"&ORD="+ORD+"\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"10%\"  background=\"images/fond_titre.jpg\"><center>#</center></td>");
        out.print("<td width=\"15%\"  background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"15%\"  background=\"images/fond_titre.jpg\"><center>Workload</center></td>");
        out.print("<td width=\"25%\"  background=\"images/fond_titre.jpg\"><center>Template link</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT NAME,WORKLOAD,DOCLINK,ACTORD FROM PHASE_TEMPLATE_ACTIVITY WHERE TEMPLATE='"+TEMPLATE+"' AND ORD="+ORD+" ORDER BY ACTORD ASC";
        ResultSet R01 = STR01.executeQuery(QR01);
        while(R01.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+R01.getInt("ACTORD")+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+R01.getString("NAME")+"</td><td><A HREF=\"adminaddtemplateactivity.jsp?TODO=MOD&TEMPLATE="+TEMPLATE+"&ORD="+ORD+"&ACTORD="+R01.getString("ACTORD")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+R01.getInt("WORKLOAD")+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\""+R01.getString("DOCLINK")+"\" target=\"_new\">"+R01.getString("DOCLINK")+"</A></center></A></td>");
          out.print("<td><center><A HREF=\"admindeletetemplateactivity.jsp?TODO=DELETE&TEMPLATE="+TEMPLATE+"&ORD="+ORD+"&ACTORD="+R01.getString("ACTORD")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR01.close();
        out.print("</table>");
        Conn.close();
      }

    %>
  </body>
</html>
