
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
      PPPMTools pt = new PPPMTools();
    
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
      	if (act.equals("ADD")) {
          int ORD=0;
          Statement st43 = Conn.createStatement();
          String q43 = "SELECT ID,SEQ FROM INDX WHERE ID='TEAM'";
          ResultSet r43 = st43.executeQuery(q43);
          if (r43.next()) {
            ORD=r43.getInt("SEQ");
          }
          st43.close();
          Statement sti2 = Conn.createStatement();
          String i2 = "INSERT INTO TEAM VALUES('TEAM"+ORD+"','"+pt.checkStr(request.getParameter("NAME"))+"','"+pt.checkStr(request.getParameter("DESCRIPTION"))+"')";
          sti2.executeUpdate(i2);
          sti2.close();
          Statement sti1 = Conn.createStatement();
          String i1 = "UPDATE INDX SET SEQ="+(ORD+1)+" WHERE ID='TEAM'";
          sti1.executeUpdate(i1);
          sti1.close();
        }
        if (act.equals("MOD")) {
          String TEAMID=request.getParameter("TEAMID");
          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE TEAM SET NAME='"+pt.checkStr(request.getParameter("NAME"))+"', DESCRIPTION='"+pt.checkStr(request.getParameter("DESCRIPTION"))+"' WHERE ID='"+TEAMID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("DELETE")) {
          String TEAMID=request.getParameter("TEAMID");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM TEAM WHERE ID='"+TEAMID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        out.print("<center><strong><h1>Resources team configuration</h1></strong></center><hr>");
        out.print("<table><tr><td>You are here : Resources Management \\ Resources team configuration </td><td><A HREF=\"resconfig.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
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
        out.print("<table><tr><td><h2><strong>Team(s)</strong></h2></center></td><td><A HREF=\"addteam.jsp?TODO=ADD\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"20\">");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center><A HREF=\"resconfig.jsp?TODO=SORT&FIELD=NAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"30%\"><center>Description</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Employee(s)</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Access</td>");
        out.print("<td background=\"images/fond.gif\" width=\"10%\"><center>&nbsp;</td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT * FROM TEAM ORDER BY "+COLTOSORT+" "+DIRSORT;
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr height=15>");
          out.print("<td bgcolor=\"#FFFFFF\"><table><tr>");
          out.print("<td><center>"+r30.getString("NAME")+"</center></td>");    
          out.print("<td><center><A HREF=\"addteam.jsp?TODO=MOD&TEAMID="+r30.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></A></center></td>");
          out.print("</tr></table></td>"); 
          out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r30.getString("DESCRIPTION")+"</center></td>");   
          int nbresource=0;
          Statement st31 = Conn.createStatement();
          String q31 = "SELECT * FROM RESTM WHERE TEAMID='"+r30.getString("ID")+"'";
          ResultSet r31 = st31.executeQuery(q31);
          while(r31.next()) {
            nbresource++;
          }
          int nbaccess=0;
          st31 = Conn.createStatement();
          q31 = "SELECT * FROM EMPTM WHERE TEAMID='"+r30.getString("ID")+"'";
          r31 = st31.executeQuery(q31);
          while(r31.next()) {
            nbaccess++;
          }
          st31.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+nbresource+"</td><td><A HREF=\"teamresource.jsp?TODO=NONE&TEAMID="+r30.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></A></center></td></tr></table></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+nbaccess+"</td><td><A HREF=\"teamaccess.jsp?TODO=NONE&TEAMID="+r30.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></A></center></td></tr></table></td>");
          out.print("<td background=\"images/fond.gif\"><center><A HREF=\"deleteteam.jsp?TODO=DELETE&TEAMID="+r30.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        Conn.close();
      } 

   %>
  </body>
</html>
