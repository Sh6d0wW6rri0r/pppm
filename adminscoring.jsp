
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
  body { color: black; font-family: arial; font-size: 11px}
  h1 { color: black; font-family: arial; font-size: 16px}
</style> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.navbar {
    overflow: hidden;
    background-color: #333;
    font-family: Arial;
}

.navbar a {
    float: left;
    font-size: 16px;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

.dropdown {
    float: left;
    overflow: hidden;
}

.dropdown .dropbtn {
    cursor: pointer;
    font-size: 16px;    
    border: none;
    outline: none;
    color: white;
    padding: 14px 16px;
    background-color: inherit;
}

.navbar a:hover, .dropdown:hover .dropbtn {
    background-color: red;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    float: none;
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left;
}

.dropdown-content a:hover {
    background-color: #ddd;
}

.show {
    display: block;
}
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

  
  <body>

      <jsp:include page="mainmenu.jsp" />

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
      	PPPMTools pmt = new PPPMTools();
        if (act.equals("GRPADD")) {
          String GROUPID = request.getParameter("GROUPID");
          String NAME = request.getParameter("NAME");
          Statement STU01 = Conn.createStatement();
          String QU01 = "INSERT INTO SCORING_GROUP VALUES ('"+pmt.checkStr(GROUPID)+"','"+pmt.checkStr(NAME)+"')";
          STU01.executeUpdate(QU01);
          STU01.close();
        }
        if (act.equals("GRPMOD")) {
          String GROUPID = request.getParameter("GROUPID");
          String NAME = request.getParameter("NAME");
          Statement STU02 = Conn.createStatement();
          String QU02 = "UPDATE SCORING_GROUP SET NAME='"+pmt.checkStr(NAME)+"' WHERE ID='"+GROUPID+"'";
          STU02.executeUpdate(QU02);
          STU02.close();
        }
        if (act.equals("GRPDELETE")) {
          String GROUPID = request.getParameter("GROUPID");
          Statement STU03 = Conn.createStatement();
          String QU03 = "DELETE FROM SCORING_GROUP WHERE ID='"+GROUPID+"'";
          STU03.executeUpdate(QU03);
          STU03.close();
        }
        if (act.equals("QSTADD")) {
          String QUESTIONID = request.getParameter("QUESTIONID");
          String NAME = request.getParameter("NAME");
          String DESCRIPTION = request.getParameter("DESCRIPTION");
          String WEIGHT = request.getParameter("WEIGHT");
          String GIDTMP = request.getParameter("GROUPID");
          String GROUPID = GIDTMP.substring(0,GIDTMP.indexOf("-")-1);
          Statement STU04 = Conn.createStatement();
          String QU04 = "INSERT INTO SCORING_QUESTION VALUES ('"+pmt.checkStr(QUESTIONID)+"','"+pmt.checkStr(NAME)+"',"+WEIGHT+",'"+GROUPID+"','"+DESCRIPTION+"')";
          STU04.executeUpdate(QU04);
          STU04.close();
        }
        if (act.equals("QSTMOD")) {
          String QUESTIONID = request.getParameter("QUESTIONID");
          String NAME = request.getParameter("NAME");
          String DESCRIPTION = request.getParameter("DESCRIPTION");
          String WEIGHT = request.getParameter("WEIGHT");
          String GIDTMP = request.getParameter("GROUPID");
          String GROUPID = GIDTMP.substring(0,GIDTMP.indexOf("-")-1);
          Statement STU05 = Conn.createStatement();
          String QU05 = "UPDATE SCORING_QUESTION SET NAME='"+pmt.checkStr(NAME)+"',WEIGHT="+WEIGHT+",GROUPID='"+GROUPID+"',DESCRIPTION='"+DESCRIPTION+"' WHERE ID='"+QUESTIONID+"'";
          STU05.executeUpdate(QU05);
          STU05.close();
        }
        if (act.equals("QSTDELETE")) {
          String QUESTIONID = request.getParameter("QUESTIONID");
          Statement STU06 = Conn.createStatement();
          String QU06 = "DELETE FROM SCORING_QUESTION WHERE ID='"+QUESTIONID+"'";
          STU06.executeUpdate(QU06);
          STU06.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>Scoring questionnaire</h1></strong></td></tr></table></center><hr>");
        out.print("<Table><tr><td>You are here : Administration \\ Manage scoring</td><td><A HREF=\"adminscoring.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Scoring question group(s)</strong></h2></center></td>");
        out.print("<td><A HREF=\"adminaddscoringgroup.jsp?TODO=ADD\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("<td>&nbsp;</td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Portfolio(s)</center></td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME FROM SCORING_GROUP";
        ResultSet R01 = STR01.executeQuery(QR01);
        while(R01.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF><center><table><tr><td>"+R01.getString("ID")+"</td><td><td><A HREF=\"adminaddscoringgroup.jsp?TODO=MOD&GROUPID="+R01.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+R01.getString("NAME")+"</center></td>");
          Statement STR02 = Conn.createStatement();
          String QR02 = "SELECT COUNT(PORTFOLIOID) FROM SCORING_GROUP_PORTFOLIO WHERE GROUPID='"+R01.getString("ID")+"'";
          ResultSet R02 = STR02.executeQuery(QR02);
          int nbport = 0;
          if (R02.next()) {
            nbport=R02.getInt("COUNT(PORTFOLIOID)");
          }
          STR02.close();
          out.print("<td bgcolor=#FFFFFF><center><A HREF=\"adminscoringportfolio.jsp?TODO=NONE&GROUPID="+R01.getString("ID")+"\">"+nbport+"</center></A></td>");
          out.print("<td><center><A HREF=\"admindeletescoringgroup.jsp?TODO=DELETE&GROUPID="+R01.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR01.close();
        out.print("</table>");
        out.print("<table><tr><td><h2><strong>Scoring question(s)</strong></h2></center></td>");
        out.print("<td><A HREF=\"adminaddscoring.jsp?TODO=ADD\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Description</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Weight</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Group</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Answer(s)</center></td>");
        out.print("<td>&nbsp;</td>");
        out.print("</tr>");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT ID,NAME,WEIGHT,GROUPID,DESCRIPTION FROM SCORING_QUESTION";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF><center><table><tr><td>"+R02.getString("ID")+"</td><td><td><A HREF=\"adminaddscoring.jsp?TODO=MOD&QUESTIONID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("NAME")+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("DESCRIPTION")+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("WEIGHT")+"</center></td>");
          Statement STR03 = Conn.createStatement();
          String QR03 = "SELECT NAME FROM SCORING_GROUP WHERE ID='"+R02.getString("GROUPID")+"'";
          ResultSet R03 = STR03.executeQuery(QR03);
          if (R03.next()) {
            out.print("<td bgcolor=#FFFFFF><center>"+R03.getString("NAME")+"</center></td>");
          }
          STR03.close();
          int nbanswer = 0;
          Statement STR04 = Conn.createStatement();
          String QR04 = "SELECT COUNT(ID) FROM SCORING_QUESTION_ANSWER WHERE QUESTIONID='"+R02.getString("ID")+"'";
          ResultSet R04 = STR04.executeQuery(QR04);
          if (R04.next()) {
            nbanswer=R04.getInt("COUNT(ID)");
          }
          STR04.close();
          out.print("<td bgcolor=#FFFFFF><center><table><tr><td>"+nbanswer+"</td><td><A HREF=\"adminscoringanswer.jsp?TODO=NONE&QUESTIONID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
          out.print("<td><center><A HREF=\"admindeletescoring.jsp?TODO=DELETE&QUESTIONID="+R02.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR02.close();
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
