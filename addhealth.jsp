
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
        String DATE_HEALTH = request.getParameter("DATE_HEALTH");
        String ANSWER = "";
        String COMMENT = "";
        String PHASE = "";
        if (!act.equals("DISP")) {
          if (act.equals("ADD")) {
            out.print("<form name=\"formFILTER\" method=\"post\" action=\"projecthealth.jsp?TODO=ADD&PROJECTID="+PROJECTID+"\" target=\"appliFrame\">");
          } else {
            out.print("<form name=\"formFILTER\" method=\"post\" action=\"projecthealth.jsp?TODO=MOD&PROJECTID="+PROJECTID+"&DATE_HEALTH="+DATE_HEALTH+"\" target=\"appliFrame\">");
          }   
        }
        out.print("<center><strong><h1>Health Check project</h1></strong></center><hr>");
        out.print("You are here : Portfolio \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\">Projects </A> \\ <A HREF=\"projecthealth.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\" target=\"appliFrame\">Project health check(s)</A> \\ Add health-check");
        out.print("<hr>");
        if (act.equals("MOD") ||act.equals("DISP")) {
          Statement STR01 = Conn.createStatement();
          String QR01 = "SELECT DISTINCT PHASE FROM PROJECT_HEALTH WHERE DATE_HEALTH='"+DATE_HEALTH+"' AND PROJECTID='"+PROJECTID+"'";
          ResultSet R01 = STR01.executeQuery(QR01);
          if (R01.next()) {
            PHASE=R01.getString("PHASE");
          }
          STR01.close();
        }
        if (act.equals("DISP")) {
          out.print("Project phase : "+PHASE);
        } else {
          out.print("Project phase : <select name=\"PHASE\">");
          Statement STR02 = Conn.createStatement();
          String QR02 = "SELECT NAME FROM PROJECT_ACTIVITY WHERE PROJECTID='"+PROJECTID+"' AND FATHER='ROOT'";
          ResultSet R02 = STR02.executeQuery(QR02);
          while(R02.next()) {
            out.print("<option");
            if (PHASE.equals(R02.getString("NAME"))) {
              out.print(" selected ");
            }
            out.print(">"+R02.getString("NAME")+"</option>");
          }
          STR02.close();
          out.print("</select>");
        }
        out.print("<hr>");
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectstatus.jsp?TODO=ADD&PROJECTID="+PROJECTID+"\" target=\"appliFrame\">");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>Area</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Very high risk - 1</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>High risk - 2</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Moderate risk - 3</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Low risk - 4</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Very low risk - 5</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Score</center></td>");
        out.print("<td width=\"25%\" background=\"images/fond_titre.jpg\"><center>Comment(s)</center></td>");
        out.print("</tr>");
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT ID,NAME FROM HEALTH_QUESTION";
        ResultSet R03 = STR03.executeQuery(QR03);
        while (R03.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\">"+R03.getString("NAME")+"</td>");
          Statement STR04 = Conn.createStatement();
          String QR04 = "SELECT * FROM HEALTH_ANSWER WHERE QUESTIONID='"+R03.getString("ID")+"' AND ID=1";
          ResultSet R04 = STR04.executeQuery(QR04);
          if (R04.next()) {
            out.print("<td bgcolor=\"#FFFFFF\">"+R04.getString("ANSWER")+"</td>");
          } else {
            out.print("<td bgcolor=\"#EFEFEF\">&nbsp;</td>");
          }
          STR04.close(); 
          STR04 = Conn.createStatement();
          QR04 = "SELECT * FROM HEALTH_ANSWER WHERE QUESTIONID='"+R03.getString("ID")+"' AND ID=2";
          R04 = STR04.executeQuery(QR04);
          if (R04.next()) {
            out.print("<td bgcolor=\"#FFFFFF\">"+R04.getString("ANSWER")+"</td>");
          } else {
            out.print("<td bgcolor=\"#EFEFEF\">&nbsp;</td>");
          }
          STR04.close();       
          STR04 = Conn.createStatement();
          QR04 = "SELECT * FROM HEALTH_ANSWER WHERE QUESTIONID='"+R03.getString("ID")+"' AND ID=3";
          R04 = STR04.executeQuery(QR04);
          if (R04.next()) {
            out.print("<td bgcolor=\"#FFFFFF\">"+R04.getString("ANSWER")+"</td>");
          } else {
            out.print("<td bgcolor=\"#EFEFEF\">&nbsp;</td>");
          }
          STR04.close();       
          STR04 = Conn.createStatement();
          QR04 = "SELECT * FROM HEALTH_ANSWER WHERE QUESTIONID='"+R03.getString("ID")+"' AND ID=4";
          R04 = STR04.executeQuery(QR04);
          if (R04.next()) {
            out.print("<td bgcolor=\"#FFFFFF\">"+R04.getString("ANSWER")+"</td>");
          } else {
            out.print("<td bgcolor=\"#EFEFEF\">&nbsp;</td>");
          }
          STR04.close();       
          STR04 = Conn.createStatement();
          QR04 = "SELECT * FROM HEALTH_ANSWER WHERE QUESTIONID='"+R03.getString("ID")+"' AND ID=5";
          R04 = STR04.executeQuery(QR04);
          if (R04.next()) {
            out.print("<td bgcolor=\"#FFFFFF\">"+R04.getString("ANSWER")+"</td>");
          } else {
            out.print("<td bgcolor=\"#EFEFEF\">&nbsp;</td>");
          }
          STR04.close();    
          if (act.equals("MOD") ||act.equals("DISP")) {
            Statement STR05 = Conn.createStatement();
            String QR05 = "SELECT * FROM PROJECT_HEALTH WHERE HEALTH_QUESTIONID='"+R03.getString("ID")+"' AND DATE_HEALTH='"+DATE_HEALTH+"' AND PROJECTID='"+PROJECTID+"'";
            ResultSet R05 = STR05.executeQuery(QR05);
            if (R05.next()) {
              ANSWER=R05.getString("RESULT");
              COMMENT=R05.getString("COMMENT");
            }
            STR05.close();
          }
          if (!act.equals("DISP")) {
            out.print("<td bgcolor=\"#FFFFFF\"><center><select NAME=\"ANSWER"+R03.getString("ID")+"\">");
            Statement STR06 = Conn.createStatement();
            String QR06 = "SELECT * FROM HEALTH_ANSWER WHERE QUESTIONID='"+R03.getString("ID")+"'";
            ResultSet R06 = STR06.executeQuery(QR06);
            while (R06.next()) {
              out.print("<option");
              if (ANSWER.equals(R06.getString("ID"))) {
                out.print(" selected ");
              }
              out.print(">"+R06.getString("ID")+"</option>");
            } 
            STR06.close();      
            out.print("</select></center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center><textarea name=\"COMMENT"+R03.getString("ID")+"\" cols=\"30\" rows=\"5\" value=\"\">"+COMMENT+"</textarea></center></td></tr>"); 
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+ANSWER+"</center></td>"); 
            out.print("<td bgcolor=\"#FFFFFF\">"+COMMENT+"</center></td>"); 
          }
          out.print("</tr>");
        }
        out.print("<table>");
        if (!act.equals("DISP")) {
          if (act.equals("ADD")) {
            out.print("<tr><td>&nbsp;</td><td><input type=\"image\" border=0 src=\"icons/add.png\" name=\"Score\" value=\"submit\"></td>");
          } else {
            out.print("<tr><td>&nbsp;</td><td><input type=\"image\" border=0 src=\"icons/modify.png\" name=\"Score\" value=\"submit\"></td>");
          }
        }
        out.print("<td><A HREF=\"projecthealth.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></center>");
        out.print("</table>");
        STR03.close();
        out.print("</form>");
        Conn.close();
      }      
    %>
  </body>
</html>
