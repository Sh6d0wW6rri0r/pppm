
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
    	window.showModalDialog('switchit.jsp?TODO=NEW&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='switch.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalMOD(reqstr)
    {
    	window.showModalDialog('switchit.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='switch.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalDELETE(reqstr)
    {
    	window.showModalDialog('deleteswitch.jsp?TODO=DELETE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='switch.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalDISPLAY(reqstr)
    {
    	window.showModalDialog('switchdisp.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='switch.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPOWER(reqstr)
    {
    	window.showModalDialog('switchpower.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='switch.jsp?TODO=NONE';
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
 
  out.print("<center><strong><h1>Switch list</h1></strong></center><hr>");
  out.print("<table><tr><td><h2><strong>Switch(s)</strong></h2></center></td><td><center><A HREF=\"#\" onclick=\"showModalADD('');\"><img border=0 src=\"icons/addsmall.png\"></center></A></td></tr></table></td>");
  out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
  out.print("<tr>");
  out.print("<td background=\"images/fond_titre.jpg\"><center>SWITCH ID</center></td>");
  out.print("<td background=\"images/fond_titre.jpg\"><center>DESCRIPTION</center></td>"); 
  out.print("<td background=\"images/fond_titre.jpg\"><center># OF PORT</center></td>"); 
  out.print("<td background=\"images/fond_titre.jpg\"><center>VENDOR</center></td>"); 
  out.print("<td background=\"images/fond_titre.jpg\"><center>RACK ON U</center></td>"); 
  out.print("<td background=\"images/fond_titre.jpg\"><center>SIZE IN U</center></td>"); 
  out.print("<td background=\"images/fond_titre.jpg\"><center>POWER ADAPTER</center></td>"); 
  out.print("<td background=\"images/fond_titre.jpg\"><center>RACK</center></td>");  
  out.print("<td background=\"images/fond_titre.jpg\"><center>SUPPORT CONTRACT</center></td>");  
  out.print("<td background=\"images/fond_titre.jpg\"><center>SITEID</center></td>"); 
  out.print("<td background=\"images/fond_titre.jpg\"><center>DISPLAY</center></td>");  
  out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
  out.print("</tr>");
  Statement st30 = Conn.createStatement();
  String q30 = "SELECT * FROM CMDB_SWITCH ORDER BY ID";
  ResultSet r30 = st30.executeQuery(q30);
  while(r30.next()) {
    out.print("<tr>");
    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp<A HREF=\"#\" onclick=\"showModalMOD('ID="+r30.getString("ID")+"');\">"+r30.getString("ID")+"</center></A></td>");
    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("DESCRIPTION")+"</center></td>");
    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("NBPLUG")+"</center></td>");
    Statement st132 = Conn.createStatement();
    String q132 = "SELECT * FROM VENDOR WHERE ID='"+r30.getString("VENDORID")+"'";
    ResultSet r132 = st132.executeQuery(q132);
    if (r132.next()) {
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r132.getString("NAME")+"</center></td>");
    } else {
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></td>");
    }
    st132.close();
    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("U")+"</center></td>");
    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("USIZE")+"</center></td>");
    int nbpower=0;
    Statement st131 = Conn.createStatement();
    String q131 = "SELECT * FROM CMDB_SWITCH_POWER WHERE SWITCHID='"+r30.getString("ID")+"'";
    ResultSet r131 = st131.executeQuery(q131);
    while(r131.next()) {
      nbpower++;
    }
    st131.close();
    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPOWER('ID="+r30.getString("ID")+"');\">"+nbpower+"</center></A></td>");      
    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("RACKID")+"</center></td>");
    Statement st31 = Conn.createStatement();
    String q31 = "SELECT * FROM CMDB_VENDOR_CONTRACT WHERE ID='"+r30.getString("CONTRACTID")+"'";
    ResultSet r31 = st31.executeQuery(q31);
    if (r31.next()) {
      Statement st32 = Conn.createStatement();
      String q32 = "SELECT * FROM VENDOR WHERE ID='"+r31.getString("VENDORID")+"'";
      ResultSet r32 = st32.executeQuery(q32);
      if (r32.next()) {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r31.getString("REFERENCE")+" / "+r32.getString("NAME")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r31.getString("REFERENCE")+"</center></td>");
      }
      st32.close();
    } else {
      out.print("<td bgcolor=\"#FFFFFF\"><center>NO CONTRACT</center></td>");
    }
    st31.close();
    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("SITEID")+"</center></td>");
    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp<A HREF=\"#\" onclick=\"showModalDISPLAY('ID="+r30.getString("ID")+"');\">Display</center></A></td>");
    out.print("<td><center><A HREF=\"#\" onclick=\"showModalDELETE('ID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");    
    out.print("</tr>");
  }
  st30.close();
  out.print("</table>");
}
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
