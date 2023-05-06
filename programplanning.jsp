
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
  <%@ page import = "java.util.*" %>
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
        String PROGRAMID = request.getParameter("PROGRAMID");
        String RO = request.getParameter("RO");

        if (RO==null) {
          RO="NO";
        }
      	Program prg = new Program(Conn,PROGRAMID);
        PPPMTools pt= new PPPMTools();
        if (act.equals("BASELINE")) {
          String NAME=pt.checkStr(request.getParameter("NAME"));
          prg.createBaseline(NAME);
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/planning.png\"></td><td><strong><h1>Project planning</h1></strong></td></tr></table></center><hr>");
         if (RO.equals("NO")) {
           User us = new User(Conn);
           if (us.hasRole(Userlogin,"BASELINE")) {
            out.print("<td><A HREF=\"addprogrambaseline.jsp?TODO=NONE&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/addbaseline.png\"> </A></td>");
          }
        }
        out.print("<td><A HREF=\"programbaseline.jsp?TODO=NONE&PROGRAMID="+PROGRAMID+"&RO="+RO+"\"><img border=0 src=\"icons/baseline.png\"> </A></td></tr></table>");
        out.print("<hr>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"30\">");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Project</center></td>");
        out.print("<td width=\"5%\" background=\"images/fond_titre.jpg\"><center>#</center></td>");
        out.print("<td width=\"30%\" background=\"images/fond_titre.jpg\"><center>Activity</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Duration (days)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Workload (hours)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Start</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>End</center></td>");
        out.print("</tr>");
        Statement st29 = Conn.createStatement();
        String q29 = "SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"'";
        ResultSet r29 = st29.executeQuery(q29);
        while(r29.next()) {
          Statement st30 = Conn.createStatement();
          String q30 = "SELECT NAME,DATE_START,DATE_END,ID FROM PROJECT_ACTIVITY WHERE PROJECTID='"+r29.getString("PROJECTID")+"' AND FATHER='ROOT' ORDER BY ORD ASC";
          ResultSet r30 = st30.executeQuery(q30);
          while(r30.next()) {
            out.print("<tr>");
            Statement st43 = Conn.createStatement();
            String q43 = "SELECT ID,NAME FROM PROJECT WHERE ID='"+r29.getString("PROJECTID")+"'";
            ResultSet r43 = st43.executeQuery(q43);
            if (r43.next()) {
              out.print("<td bgcolor=\"#FFFFFF\">"+r43.getString("NAME")+"</td>");
            } else {
              out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
            }
            st43.close();
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("ID")+"</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\">"+r30.getString("NAME")+"</td>");
            Statement st31b = Conn.createStatement();
            String q31b = "SELECT WORKLOAD FROM PROJECT_ACTIVITY WHERE PROJECTID='"+r29.getString("PROJECTID")+"' AND FATHER='"+r30.getInt("ID")+"' ORDER BY ORD ASC";
            ResultSet r31b = st31b.executeQuery(q31b);
            int wrktmp=0;
            while(r31b.next()) {
              wrktmp=wrktmp+r31b.getInt("WORKLOAD");
            }
            st31b.close();
            SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
            long begincreneau = d1.parse(r30.getString("DATE_START")).getTime();
            long endcreneau = d2.parse(r30.getString("DATE_END")).getTime();  
            long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
            long nday=0;
            for (long delta = begincreneau; delta <= endcreneau; delta = delta+ MILLISECONDS_PER_DAY) {
              Calendar cday = Calendar.getInstance();
              cday.setTimeInMillis(delta);
              if ((cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
                nday++;
              }
            }
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+nday+"</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+wrktmp+"</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DATE_START")+"</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DATE_END")+"</center></A></td>");
            out.print("</tr>");
          }
          st30.close();
        }
        st29.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");     
        Conn.close();
      }

    %>
  </body>
</html>
