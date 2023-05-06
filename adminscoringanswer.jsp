
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
        String QUESTIONID = request.getParameter("QUESTIONID");      	
        PPPMTools pmt = new PPPMTools();
        if (act.equals("ADD")) {
          String ANSWERID = request.getParameter("ANSWERID");
          String NAME = request.getParameter("NAME");
          String SCORE = request.getParameter("SCORE");
          Statement STU01 = Conn.createStatement();
          String QU01 = "INSERT INTO SCORING_QUESTION_ANSWER VALUES ('"+pmt.checkStr(ANSWERID)+"','"+pmt.checkStr(NAME)+"',"+SCORE+",'"+pmt.checkStr(QUESTIONID)+"')";
          STU01.executeUpdate(QU01);
          STU01.close();
        }
        if (act.equals("MOD")) {
          String ANSWERID = request.getParameter("ANSWERID");
          String NAME = request.getParameter("NAME");
          String SCORE = request.getParameter("SCORE");
          Statement STU02 = Conn.createStatement();
          String QU02 = "UPDATE SCORING_QUESTION_ANSWER SET NAME='"+pmt.checkStr(NAME)+"',SCORE="+SCORE+" WHERE ID='"+ANSWERID+"' AND QUESTIONID='"+QUESTIONID+"'";
          STU02.executeUpdate(QU02);
          STU02.close();
        }
        if (act.equals("DELETE")) {
          String ANSWERID = request.getParameter("ANSWERID");
          Statement STU03 = Conn.createStatement();
          String QU03 = "DELETE FROM SCORING_QUESTION_ANSWER WHERE ID='"+ANSWERID+"' AND QUESTIONID='"+QUESTIONID+"'";
          STU03.executeUpdate(QU03);
          STU03.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>Answer(s) to scoring question</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Administration \\ <A HREF=\"adminscoring.jsp?TODO=NONE\" target=\"appliFrame\"> Scoring </A>\\ Answers</td><td><A HREF=\"adminscoringanswer.jsp?TODO=NONE&QUESTIONID="+QUESTIONID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Scoring question</strong></h2></center></td></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>ID</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>WEIGHT</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>GROUP</center></td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME,WEIGHT,GROUPID FROM SCORING_QUESTION WHERE ID='"+QUESTIONID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        if(R01.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+R01.getString("ID")+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\">"+R01.getString("NAME")+"</td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+R01.getString("WEIGHT")+"</center></td>");
          Statement STR02 = Conn.createStatement();
          String QR02 = "SELECT ID,NAME FROM SCORING_GROUP WHERE ID='"+R01.getString("GROUPID")+"'";
          ResultSet R02 = STR02.executeQuery(QR02);
          if (R02.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+R02.getString("NAME")+"</center></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>?</center></td>");
          }
          STR02.close();
          out.print("</tr>");
        }
        STR01.close();
        out.print("</table>");
        out.print("<br><hr><table><tr><td><h2><strong>Question answer(s)</strong></h2></center></td><td><A HREF=\"adminaddscoringanswer.jsp?TODO=ADD&QUESTIONID="+QUESTIONID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td background=\"images/fond_titre.jpg\"><center>ID</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>SCORE</center></td>");
        out.print("<td><center></center></td>");
        out.print("</tr>");
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT ID,NAME,SCORE FROM SCORING_QUESTION_ANSWER WHERE QUESTIONID='"+QUESTIONID+"'";
        ResultSet R03 = STR03.executeQuery(QR03);
        while(R03.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><table><tr><td>"+R03.getString("ID")+"</td><td><center><A HREF=\"adminaddscoringanswer.jsp?TODO=MOD&ANSWERID="+R03.getString("ID")+"&QUESTIONID="+QUESTIONID+"\"><img border=0 src=\"icons/modifysmall.png\"></center></A></td></tr></table></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+R03.getString("NAME")+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+R03.getString("SCORE")+"</center></td>");
          out.print("<td><center><A HREF=\"admindeletescoringanswer.jsp?TODO=DELETE&ANSWERID="+R03.getString("ID")+"&QUESTIONID="+QUESTIONID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR03.close();
        out.print("</table>");
        Conn.close();
      }

    %>
  </body>
</html>
