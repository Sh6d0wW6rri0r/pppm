
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
      	PPPMTools pt = new PPPMTools();
        Portfolio pf = new Portfolio(Conn); 
        if (act.equals("ADD")) {
          pf.addPortfolio(pt.checkStr(request.getParameter("NAME")),pt.checkStr(request.getParameter("DESCRIPTION")));
        }
        if (act.equals("MOD")) {
          String PORTFOLIOID=request.getParameter("PORTFOLIOID");
          pf.modifyPortfolio(PORTFOLIOID,pt.checkStr(request.getParameter("NAME")),pt.checkStr(request.getParameter("DESCRIPTION")));
        }
        if (act.equals("DELETE")) {
          String PORTFOLIOID=request.getParameter("PORTFOLIOID");
          pf.deletePortfolio(PORTFOLIOID);
        }
        out.print("<center><strong><h1>Portfolio configuration</h1></strong></center><hr>");
        out.print("<table><tr><td>You are here : Portfolio Management \\ Portfolio configuration </td><td><A HREF=\"portconfig.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        String COLTOSORT = "ID";
        String DIRSORT = "ASC";
        if (act.equals("SORT")) {
          if (request.getParameter("FIELD").equals(request.getParameter("OLDFIELD"))) {
            COLTOSORT=request.getParameter("FIELD");
            if (request.getParameter("OLDDIR").equals("ASC")) {
              DIRSORT="DESC";
            } else {
              DIRSORT="ASC";
            }
          } else {
            COLTOSORT=request.getParameter("FIELD");
            DIRSORT="ASC";
          }
        }
        out.print("<table><tr><td><h2><strong>Portfolio(s)</strong></h2></center></td><td><A HREF=\"addportfolio.jsp?TODO=ADD\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"20\">");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center><A HREF=\"portconfig.jsp?TODO=SORT&FIELD=ID&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">#</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center><A HREF=\"portconfig.jsp?TODO=SORT&FIELD=NAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>Description</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Project(s)</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Program(s)</td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Product(s)</td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>User Acces</td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Group Acces</td>");
        out.print("<td width=\"5%\"><center>&nbsp;</td>");
        out.print("</tr>");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT * FROM PORTFOLIO ORDER BY "+COLTOSORT+" "+DIRSORT;
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<tr height=15>");
          out.print("<td bgcolor=\"#FFFFFF\"><table><tr>");
          out.print("<td><center>"+R02.getString("ID")+"</center></td>");     
          out.print("<td><center><A HREF=\"addportfolio.jsp?TODO=MOD&PORTFOLIOID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></A></center></td>");
          out.print("</tr></table></td>"); 
          out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+R02.getString("NAME")+"</center></td>");       
          out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+R02.getString("DESCRIPTION")+"</center></td>");  
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+pf.projectNB(R02.getString("ID"))+"</td><td><A HREF=\"portfolioproject.jsp?TODO=NONE&PORTFOLIOID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></A></center></td></tr></table></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+pf.programNB(R02.getString("ID"))+"</td><td><A HREF=\"portfolioprogram.jsp?TODO=NONE&PORTFOLIOID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></A></center></td></tr></table></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+pf.productNB(R02.getString("ID"))+"</td><td><A HREF=\"portfolioproduct.jsp?TODO=NONE&PORTFOLIOID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></A></center></td></tr></table></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+pf.userNB(R02.getString("ID"))+"</td><td><A HREF=\"portfolioaccess.jsp?TODO=NONE&PORTFOLIOID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></A></center></td></tr></table></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+pf.groupNB(R02.getString("ID"))+"</td><td><A HREF=\"portfoliogroupaccess.jsp?TODO=NONE&PORTFOLIOID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></A></center></td></tr></table></td>");
          out.print("<td><center><A HREF=\"deleteportfolio.jsp?TODO=DELETE&PORTFOLIOID="+R02.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");
          out.print("</tr>");
        }
        STR02.close();
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
