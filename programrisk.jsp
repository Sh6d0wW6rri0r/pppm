
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
        String Language = (String)session.getAttribute("LANGUAGE");
        String act = request.getParameter("TODO");
        String PROGRAMID = request.getParameter("PROGRAMID");
       
        String risk_matrix[][] = new String[6][6];
        risk_matrix[1][5]="O";
        risk_matrix[1][4]="G";
        risk_matrix[1][3]="G";
        risk_matrix[1][2]="G";
        risk_matrix[1][1]="G";
        risk_matrix[2][5]="O";
        risk_matrix[2][4]="O";
        risk_matrix[2][3]="G";
        risk_matrix[2][2]="G";
        risk_matrix[2][1]="G";
        risk_matrix[3][5]="R";
        risk_matrix[3][4]="O";
        risk_matrix[3][3]="O";
        risk_matrix[3][2]="G";
        risk_matrix[3][1]="G";
        risk_matrix[4][5]="R";
        risk_matrix[4][4]="R";
        risk_matrix[4][3]="O";
        risk_matrix[4][2]="O";
        risk_matrix[4][1]="G";
        risk_matrix[5][5]="R";
        risk_matrix[5][4]="R";
        risk_matrix[5][3]="R";
        risk_matrix[5][2]="O";
        risk_matrix[5][1]="O";
      	out.print("<center><table><tr><td><img border=0 src=\"icons/risks.png\"></td><td><strong><h1>Program risks/Issues</h1></strong></td></tr></table></center><hr>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"30\">");
        out.print("<td width=\"40%\" background=\"images/fond.gif\"><center>&nbsp;</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>LOW</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>HIGH</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>CRITICAL</center></td>");
        out.print("</tr>");
        out.print("<tr height=\"30\">");
        Statement st40a = Conn.createStatement();
        String q40a = "SELECT PROJECTID,IMPACT,LIKELIHOOD FROM PROJECT_RISK WHERE ESCALATE='Y' AND PROJECTID IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"')";
        int nbrlow=0;
        int nbrhigh = 0;
        int nbrcritical = 0;
        ResultSet r40a = st40a.executeQuery(q40a);
        while(r40a.next()) {
          int impact = r40a.getInt("IMPACT");
          int likelihood = r40a.getInt("LIKELIHOOD");
          if (risk_matrix[impact][likelihood].equals("G")) {
            nbrlow++;
          }
          if (risk_matrix[impact][likelihood].equals("O")) {
            nbrhigh++;
          }
          if (risk_matrix[impact][likelihood].equals("R")) {
            nbrcritical++;
          }
        }
        st40a.close();
        out.print("<td background=\"images/fond_titre.jpg\"><center>RISK(S)</center></td>");
        out.print("<td bgcolor=\"#00FF00\"><center><A HREF=\"#\" onclick=\"window.showModalDialog('listprogramrisk.jsp?TODO=NONE&LEVEL=LOW&PROGRAMID="+PROGRAMID+"','','dialogHeight:400px;dialogWidth:800px;');\">"+nbrlow+"</A></center></td>");
        out.print("<td bgcolor=\"#FF7F3F\"><center><A HREF=\"#\" onclick=\"window.showModalDialog('listprogramrisk.jsp?TODO=NONE&LEVEL=MEDIUM&PROGRAMID="+PROGRAMID+"','','dialogHeight:400px;dialogWidth:800px;');\">"+nbrhigh+"</center></td>");
        out.print("<td bgcolor=\"#FF0000\"><center><A HREF=\"#\" onclick=\"window.showModalDialog('listprogramrisk.jsp?TODO=NONE&LEVEL=HIGH&PROGRAMID="+PROGRAMID+"','','dialogHeight:400px;dialogWidth:800px;');\">"+nbrcritical+"</center></td>");
        out.print("<td background=\"images/fond.gif\"><center>&nbsp;</center></td>");
        out.print("</table>");
        out.print("<br><hr><table><tr><td><h2><strong>Project risk(s)</strong></h2></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"30\">");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>PROJECT</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>SCORE</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>DATE DISCOVERED</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>DATE CLOSED</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>OWNER</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>ACTIONS</center></td>");
        out.print("</tr>");
        Statement st29 = Conn.createStatement();
        String q29 = "SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"'";
        ResultSet r29 = st29.executeQuery(q29);
        while(r29.next()) {
          Statement st30 = Conn.createStatement();
          String q30 = "SELECT ID,NAME,DESCRIPTION,DATE_DISCOVER,DATE_CLOSING,EMPLOYEEID,IMPACT,LIKELIHOOD FROM PROJECT_RISK WHERE PROJECTID='"+r29.getString("PROJECTID")+"' AND ESCALATE='Y'";
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
            out.print("<td bgcolor=\"#FFFFFF\">"+r30.getString("NAME")+"</td>");
            int impact = r30.getInt("IMPACT");
            int likelihood = r30.getInt("LIKELIHOOD");
            if (risk_matrix[impact][likelihood].equals("G")) {
              out.print("<td bgcolor=\"#00FF00\"><center>Low</center></td>");
            }
            if (risk_matrix[impact][likelihood].equals("O")) {
              out.print("<td bgcolor=\"#FF7F3F\"><center>High</center></td>");
            }
            if (risk_matrix[impact][likelihood].equals("R")) {
              out.print("<td bgcolor=\"#FF0000\"><center>Critical</center></td>");
            }
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getInt("DATE_DISCOVER")+"</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getInt("DATE_CLOSING")+"</center></td>");
            Statement st32 = Conn.createStatement();
            String q32 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID='"+r30.getString("EMPLOYEEID")+"'";
            ResultSet r32 = st32.executeQuery(q32);
            if (r32.next()) {
              out.print("<td bgcolor=\"#FFFFFF\"><center>"+r32.getString("FORNAME")+" "+r32.getString("NAME")+"</center></td>");
            } else {
              out.print("<td bgcolor=\"#FFFFFF\"><center>?</center></td>");
            }
            st32.close();
            Statement st38 = Conn.createStatement();
            String q38 = "SELECT ID FROM PROJECT_RISK_ACTION WHERE PROJECTID='"+r29.getString("PROJECTID")+"' AND RISKID='"+r30.getString("ID")+"'";
            ResultSet r38 = st38.executeQuery(q38);
            int nbrac = 0;
            while (r38.next()) {
              nbrac++;
            }
            out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+nbrac+"</td></tr></table></center></td>");
            st38.close();
            out.print("</tr>");
            out.print("<tr>");
            out.print("<td>&nbsp;</td>");
            out.print("<td colspan=6>");
            out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
            out.print("<tr>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>RESPONSE NAME</center></td>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>DATE CREATION</center></td>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>DATE_CLOSING</center></td>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>OWNER</center></td>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>IMPLEMENTATION</center></td>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>CLOSED</center></td>");
            out.print("</tr>");
            Statement st330 = Conn.createStatement();
            String q330 = "SELECT ID,NAME,DESCRIPTION,DATE_CREATION,DATE_CLOSING,STATUS,EMPLOYEEID,IMPACT,LIKELIHOOD,IMPLEMENT,CLOSED FROM PROJECT_RISK_ACTION WHERE PROJECTID='"+r29.getString("PROJECTID")+"' AND RISKID='"+r30.getString("ID")+"'";
            ResultSet r330 = st330.executeQuery(q330);
            while(r330.next()) {
              out.print("<tr>");
              out.print("<td bgcolor=\"#FFFFFF\">"+r330.getString("NAME")+"</td>");
              out.print("<td bgcolor=\"#FFFFFF\"><center>"+r330.getString("DATE_CREATION")+"</center></td>");
              out.print("<td bgcolor=\"#FFFFFF\"><center>"+r330.getString("DATE_CLOSING")+"</center></td>");
              out.print("<td bgcolor=\"#FFFFFF\"><center>"+r330.getString("EMPLOYEEID")+"</center></td>");
              out.print("<td bgcolor=\"#FFFFFF\"><center>"+r330.getString("IMPLEMENT")+"</center></td>");
              out.print("<td bgcolor=\"#FFFFFF\"><center>"+r330.getString("CLOSED")+"</center></td>");
              out.print("</tr>");
            }
            st330.close();
            out.print("</table>");
            out.print("</td>");
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
