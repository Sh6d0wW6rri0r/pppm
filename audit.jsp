
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

  <%!String checkstr(String str) {
  
      String insertok="";
  
      for (int it=0; it <str.length();it++) {
        if ((str.charAt(it)>='a') && (str.charAt(it)<='z')) {
          insertok=insertok+str.charAt(it);
        }
        if ((str.charAt(it)>='A') && (str.charAt(it)<='Z')) {
          insertok=insertok+str.charAt(it);
        }
        if ((str.charAt(it)>='0') && (str.charAt(it)<='9')) {
          insertok=insertok+str.charAt(it);
        }
        if ((str.charAt(it)==' ')) {
          insertok=insertok+" ";
        } 
        if ((str.charAt(it)=='\n')) {
          insertok=insertok+"\\\n";
        } 
        if ((str.charAt(it)=='\'')) {
          insertok=insertok+"''";
        }
        if ((str.charAt(it)=='à')) {
          insertok=insertok+"&agrave;";
        }
        if ((str.charAt(it)=='é')) {
          insertok=insertok+"&eacute;";
        }
        if ((str.charAt(it)=='è')) {
          insertok=insertok+"&egrave;";
        }
        if ((str.charAt(it)=='ù')) {
          insertok=insertok+"&ugrave;";
        }
        if ((str.charAt(it)=='ô')) {
          insertok=insertok+"&ocirc;";
        }
        if ((str.charAt(it)=='ê')) {
          insertok=insertok+"&ecirc;";
        }
        if ((str.charAt(it)=='€')) {
          insertok=insertok+"&euro;";
        }
        if ((str.charAt(it)=='ç')) {
          insertok=insertok+"&ccedil;";
        }
        if ((str.charAt(it)=='&')) {
          insertok=insertok+"&amp;";
        }
        if ((str.charAt(it)=='\"')) {
          insertok=insertok+"&quot;";
        }
        if ((str.charAt(it)=='\\')) {
          insertok=insertok+"\\\\";
        }
        if ((str.charAt(it)=='$')) {
          insertok=insertok+"$";
        }
        if ((str.charAt(it)=='*')) {
         insertok=insertok+"*";
        }
        if ((str.charAt(it)=='%')) {
          insertok=insertok+"%";
        }
        if ((str.charAt(it)=='/')) {
          insertok=insertok+"/";
        }
        if ((str.charAt(it)=='.')) {
          insertok=insertok+".";
        }
        if ((str.charAt(it)=='?')) {
          insertok=insertok+"?";
        }
        if ((str.charAt(it)==',')) {
          insertok=insertok+",";
        }
        if ((str.charAt(it)==';')) {
          insertok=insertok+";";
        }
        if ((str.charAt(it)==':')) {
          insertok=insertok+":";
        }
        if ((str.charAt(it)=='!')) {
          insertok=insertok+"!";
        }
        if ((str.charAt(it)=='|')) {
          insertok=insertok+"|";
        }
        if ((str.charAt(it)=='{')) {
          insertok=insertok+"{";
        }
        if ((str.charAt(it)=='}')) {
          insertok=insertok+"}";
        }
        if ((str.charAt(it)=='(')) {
          insertok=insertok+"(";
        }
        if ((str.charAt(it)==')')) {
          insertok=insertok+")";
        }
        if ((str.charAt(it)=='[')) {
          insertok=insertok+"{";
        }
        if ((str.charAt(it)==']')) {
          insertok=insertok+"}";
        }
        if ((str.charAt(it)=='~')) {
          insertok=insertok+"~";
        }
        if ((str.charAt(it)=='#')) {
          insertok=insertok+"#";
        }
        if ((str.charAt(it)=='=')) {
          insertok=insertok+"=";
        }
        if ((str.charAt(it)=='@')) {
          insertok=insertok+"@";
        }
        if ((str.charAt(it)=='-')) {
          insertok=insertok+"-";
        }
        if ((str.charAt(it)=='_')) {
          insertok=insertok+"_";
        }
        if ((str.charAt(it)=='<')) {
          insertok=insertok+"&lt;";
        }
        if ((str.charAt(it)=='>')) {
          insertok=insertok+"&gt;";
        }
      }
  
      return insertok;

    }
  
%>

  <body bgcolor="#FFFFFF">
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
        String VENDORID = request.getParameter("VENDORID");
        // JSP parameters
        String act = request.getParameter("TODO");
      	if (act.equals("ADD")) {
          int ID=0;
          Statement STR01 = Conn.createStatement();
          String QR01 = "SELECT ID FROM VENDOR_AUDIT WHERE VENDORID='"+VENDORID+"' ORDER BY ID DESC";
          ResultSet R01 = STR01.executeQuery(QR01);
          if(R01.next()) {
            ID=(R01.getInt("ID")+1);
          }
          STR01.close();
          Statement STU01 = Conn.createStatement();
          String QU01 = "INSERT INTO VENDOR_AUDIT VALUES('"+VENDORID+"',"+ID+",'"+checkstr(request.getParameter("DATEAUDIT"))+"','"+checkstr(request.getParameter("COMMENT"))+"','"+checkstr(request.getParameter("RESULT"))+"')";
          STU01.executeUpdate(QU01);
          STU01.close();
        }
        if (act.equals("MOD")) {
          String AUDITID=request.getParameter("AUDITID");
          Statement STU02 = Conn.createStatement();
          String QU02 = "UPDATE VENDOR_AUDIT SET DATEAUDIT='"+checkstr(request.getParameter("DATEAUDIT"))+"',COMMENT='"+checkstr(request.getParameter("COMMENT"))+"',RESULT='"+checkstr(request.getParameter("RESULT"))+"' WHERE VENDORID='"+VENDORID+"' AND ID="+AUDITID;
          STU02.executeUpdate(QU02);
          STU02.close();
        }
        if (act.equals("DELETE")) {
          String AUDITID=request.getParameter("AUDITID");
          Statement STU03 = Conn.createStatement();
          String QU03 = "DELETE FROM VENDOR_AUDIT WHERE VENDORID='"+VENDORID+"' AND ID="+AUDITID;
          STU03.executeUpdate(QU03);
          STU03.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/audit.png\"></td><td><strong><h1>Vendor audit(s)</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td><h2><strong>Vendor audit(s)</strong></h2></center></td><td><center><A HREF=\"addvendoraudit.jsp?TODO=ADD&VENDORID="+VENDORID+"\"><img border=0 src=\"icons/addsmall.png\"></center></A></td></tr></table></td>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"20\">");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Vendor</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Audit date</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Result</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"50%\"><center>Comment</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT * FROM VENDOR_AUDIT WHERE VENDORID='"+VENDORID+"' ORDER BY DATEAUDIT";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<tr height=15>");
          Statement STR03 = Conn.createStatement();
          String QR03 = "SELECT NAME FROM VENDOR WHERE ID='"+R02.getString("VENDORID")+"'";
          ResultSet R03 = STR03.executeQuery(QR03);
          String VENDORNAME="";
          if(R03.next()) {
            VENDORNAME=R03.getString("NAME");
          }
          STR03.close();
          out.print("<td bgcolor=#FFFFFF><center>"+VENDORNAME+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center><table><tr><td>"+R02.getString("DATEAUDIT")+"</td><td><center><A HREF=\"addvendoraudit.jsp?TODO=MOD&VENDORID="+R02.getString("VENDORID")+"&AUDITID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\" height=15></center></A></td></tr></table></center></td>");
          out.print("<td bgcolor=#FFFFFF><center>&nbsp;"+R02.getString("RESULT")+"</center></td>");
          out.print("<td bgcolor=#FFFFFF><center>&nbsp;"+R02.getString("COMMENT")+"</center></td>");
          out.print("<td><center><A HREF=\"deletevendoraudit.jsp?TODO=DELETE&VENDORID="+R02.getString("VENDORID")+"&AUDITID="+R02.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");
          out.print("</tr>");
        }
        STR02.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        Conn.close();
      } 

    %>
  </body>
</html>
