
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
<%@ page import="fr.pppm.*" %> 

<body>
    <script>
    function showModalADD(reqstr)
    {
    	window.showModalDialog('roomit.jsp?TODO=NEW&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='room.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalMOD(reqstr)
    {
    	window.showModalDialog('roomit.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='room.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalDELETE(reqstr)
    {
    	window.showModalDialog('deleteroom.jsp?TODO=DELETE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='room.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPLUG(reqstr)
    {
    	window.showModalDialog('plug.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='room.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalDISPLAY(reqstr)
    {
    	window.showModalDialog('roomdisp.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='room.jsp?TODO=NONE';
    }
    </script>

<jsp:include page="../mainmenu.jsp" />
<%
  String Userlogin = (String)session.getAttribute("LOGIN");
  if (Userlogin==null) {
    out.print("<script language=\"JavaScript\">");
    out.print("top.location='index.jsp?TIMEOUT=TRUE';");
    out.print("</script>");
  } else {
    String POOLNAME=(String)session.getAttribute("POOLNAME");
    Context initCtx = new InitialContext();
    DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
    Connection Conn = ds.getConnection();
    String act = request.getParameter("TODO");
    String MAILSERVER = (String)session.getAttribute("MAILSERVER");
    String THISSERVER = (String)session.getAttribute("THISSERVER");
    PPPMTools pt = new PPPMTools();
    out.print("<center><strong><h1>Room(s)</h1></strong></center><hr>");
    out.print("<table><tr><td><h2><strong>Room(s)</strong></h2></center></td><td><center><A HREF=\"#\" onclick=\"showModalADD('');\"><img border=0 src=\"icons/addsmall.png\"></center></A></td></tr></table></td>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>ROOM ID</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>DESCRIPTION</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>SITE</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\"><center>POWER PLUG</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\"><center>DISPLAY</center></td>");  
    out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_ROOM ORDER BY ID";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp<A HREF=\"#\" onclick=\"showModalMOD('ID="+r30.getString("ID")+"');\">"+r30.getString("ID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("DESCRIPTION")+"</center></td>");
      Statement st31b = Conn.createStatement();
      String q31b = "SELECT * FROM LOCATION WHERE ID='"+r30.getString("SITEID")+"'";
      ResultSet r31b = st31b.executeQuery(q31b);
      if(r31b.next()) {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r31b.getString("NAME")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></td>");
      }
      st31b.close();
      int nbcontract=0;
      Statement st31 = Conn.createStatement();
      String q31 = "SELECT * FROM CMDB_PLUG WHERE ROOMID='"+r30.getString("ID")+"'";
      ResultSet r31 = st31.executeQuery(q31);
      while(r31.next()) {
        nbcontract++;
      }
      st31.close();
      out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPLUG('ROOMID="+r30.getString("ID")+"');\">"+nbcontract+"</center></A></td>");      
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp<A HREF=\"#\" onclick=\"showModalDISPLAY('ID="+r30.getString("ID")+"');\">Display</center></A></td>");
      out.print("<td><center><A HREF=\"#\" onclick=\"showModalDELETE('ID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");

      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    Conn.close();
  }
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
