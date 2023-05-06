
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
<%@ page import="fr.pppm.*" %>

  <body bgcolor="#FFFFFF">
    <script>
    function showModalADD(reqstr)
    {
    	window.showModalDialog('addvendor.jsp?TODO=ADD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='vendor.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalMOD(reqstr)
    {
    	window.showModalDialog('addvendor.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='vendor.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalDELETE(reqstr)
    {
    	window.showModalDialog('deletevendor.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='vendor.jsp?TODO=NONE';
    }
    </script>
    
    <script>
    function showModalAUDITS(reqstr)
    {
    	window.showModalDialog('audit.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='vendor.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalCONTRACTS(reqstr)
    {
    	window.showModalDialog('vendorcontract.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='vendor.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalCONTACTS(reqstr)
    {
    	window.showModalDialog('vendorcontact.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='vendor.jsp?TODO=NONE';
    }
    </script>

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

        if (act.equals("DELETE")) {
          String VENDORID=request.getParameter("VENDORID");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM VENDOR WHERE ID='"+VENDORID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/vendor.png\"></td><td><strong><h1>Vendor(s)</h1></strong></td></tr></table></center><hr>");

        out.print("<table><tr><td><h2><strong>Vendor(s)</strong></h2></center></td><td><center><A HREF=\"#\" onclick=\"showModalADD('');\"><img border=0 src=\"icons/addsmall.png\"></center></A></td></tr></table></td>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"20\">");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"25%\"><center>Address</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center>Contracts</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center>Contacts</center></td>");       
        out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center>Audits</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT * FROM VENDOR ORDER BY NAME";
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr height=15>");
          out.print("<td bgcolor=#FFFFFF><center>&nbsp;<A HREF=\"#\" onclick=\"showModalMOD('VENDORID="+r30.getString("ID")+"');\">"+r30.getString("NAME")+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center>&nbsp;"+r30.getString("ADDRESS")+"</center></td>");
          int nbcontract=0;
          Statement st31 = Conn.createStatement();
          String q31 = "SELECT * FROM CMDB_VENDOR_CONTRACT WHERE VENDORID='"+r30.getString("ID")+"'";
          ResultSet r31 = st31.executeQuery(q31);
          while(r31.next()) {
            nbcontract++;
          }
          st31.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalCONTRACTS('VENDORID="+r30.getString("ID")+"');\">"+nbcontract+"</center></A></td>");                
          Statement st32 = Conn.createStatement();
          String q32 = "SELECT COUNT(ID) FROM VENDOR_CONTACT WHERE VENDORID='"+r30.getString("ID")+"'";
          ResultSet r32 = st32.executeQuery(q32);
          int nbctc=0;
          if(r32.next()) {
            nbctc=r32.getInt("COUNT(ID)");
          }
          st32.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalCONTACTS('VENDORID="+r30.getString("ID")+"');\">"+nbctc+"</center></A></td>");      
          Statement st33 = Conn.createStatement();
          String q33 = "SELECT COUNT(ID) FROM VENDOR_AUDIT WHERE VENDORID='"+r30.getString("ID")+"'";
          ResultSet r33 = st33.executeQuery(q33);
          int nbaudit=0;
          if(r33.next()) {
            nbaudit=r33.getInt("COUNT(ID)");
          }
          st33.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalAUDITS('VENDORID="+r30.getString("ID")+"');\">"+nbaudit+"</center></A></td>");         
          out.print("<td><center><A HREF=\"#\" onclick=\"showModalDELETE('VENDORID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        Conn.close();
      }
 
    %>
  </body>
</html>
