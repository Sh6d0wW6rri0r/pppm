
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: 11px}
      h1 { color: black; font-family: arial; font-size: 16px}
      h2 { color: black; font-family: arial; font-size: 13px}
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
        String EMPLOYEEID = request.getParameter("EMPLOYEEID");
      	if (act.equals("PROMOD")) {
          String PROFILEID = request.getParameter("PROFILEID");
          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE EMPLOYEE SET PROFILEID='"+PROFILEID+"' WHERE ID='"+EMPLOYEEID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("SKMOD")) {
          String LEVEL = request.getParameter("LEVEL");
          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE EMPLOYEE SET SKILL='"+LEVEL+"' WHERE ID='"+EMPLOYEEID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("ADD")) {
          String PROFILEID = request.getParameter("PROFILEID");
          Statement sti2 = Conn.createStatement();
          String i2 = "INSERT INTO EMPPRF VALUES ('"+EMPLOYEEID+"','"+PROFILEID+"',0)";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("SKILL")) {
          String PROFILEID = request.getParameter("PROFILEID");
          String LEVEL = request.getParameter("LEVEL");
          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE EMPPRF SET SKILL="+LEVEL+" WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND PROFILEID='"+PROFILEID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("DELETE")) {
          String PROFILEID = request.getParameter("PROFILEID");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM EMPPRF WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND PROFILEID='"+PROFILEID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/resources.png\"></td><td><strong><h1>Resource profile(s)</h1></strong></td></tr></table></center><hr>");
 
        out.print("<table><tr><td><h2><strong>Resource primary profile</strong></h2></center></td>");
        out.print("</tr></table>");
        String PROFILE = "";
        String SKILL = "";
        Statement st10 = Conn.createStatement();
        String q10 = "SELECT ID,NAME FROM PROFILE WHERE ID IN (SELECT PROFILEID FROM EMPLOYEE WHERE ID='"+EMPLOYEEID+"')";
        ResultSet r10 = st10.executeQuery(q10);
        if (r10.next()) {
          PROFILE=r10.getString("NAME");
        }
        st10.close();
        st10 = Conn.createStatement();
        q10 = "SELECT ID,SKILL FROM EMPLOYEE WHERE ID='"+EMPLOYEEID+"'";
        r10 = st10.executeQuery(q10);
        if (r10.next()) {
          SKILL=r10.getString("SKILL");
        }
        st10.close();
        String skilll="Not defined";
        Statement st132 = Conn.createStatement();
        String q132 = "SELECT ID,NAME FROM SKILL WHERE ID='"+SKILL+"'";
        ResultSet r132 = st132.executeQuery(q132);
        if (r132.next()) {
          skilll=r132.getString("NAME");
        }
        st132.close();
        out.print("<table>");
        out.print("<tr><td><table><tr><td><h2><strong>Profile </td><td><A HREF=\"pickresourceprofile.jsp?TODO=ADD&EMPLOYEEID="+EMPLOYEEID+"&CALL=PRIMARY\"><img border=0 src=\"icons/modifysmall.png\"></A></td><td>:</td></tr></table></strong></h2></td><td>"+PROFILE+"</td></tr>");
        out.print("<tr><td><table><tr><td><h2><strong>Skill </td><td><A HREF=\"pickresourceprofileskill.jsp?TODO=ADD&EMPLOYEEID="+EMPLOYEEID+"&CALL=PRIMARY\"><img border=0 src=\"icons/modifysmall.png\"></A></td><td>:</td></tr></table></strong></h2></td><td>"+skilll+"</td></tr>");
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Resource secondary profile(s)</strong></h2></center></td><td><A HREF=\"pickresourceprofile.jsp?TODO=ADD&EMPLOYEEID="+EMPLOYEEID+"&CALL=SECONDARY\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"55%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"35%\" background=\"images/fond_titre.jpg\"><center>Skill</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT ID,NAME FROM PROFILE WHERE ID IN (SELECT PROFILEID FROM EMPPRF WHERE EMPLOYEEID='"+EMPLOYEEID+"')";
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          Statement st31 = Conn.createStatement();
          String q31 = "SELECT SKILL FROM EMPPRF WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND PROFILEID='"+r30.getString("ID")+"'";
          ResultSet r31 = st31.executeQuery(q31);
          if (r31.next()) {
            Statement st32 = Conn.createStatement();
            String q32 = "SELECT ID,NAME FROM SKILL WHERE ID='"+r31.getString("SKILL")+"'";
            ResultSet r32 = st32.executeQuery(q32);
            String skilllevel="Not defined";
            if (r32.next()) {
              skilllevel=r32.getString("NAME");
            }
            st32.close();
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+skilllevel+"<A HREF=\"pickresourceprofileskill.jsp?TODO=ADD&EMPLOYEEID="+EMPLOYEEID+"&PROFILEID="+r30.getString("ID")+"&CALL=SECONDARY\"><img border=0 src=\"icons/modifysmall.png\"></A></center></td>");
          }
          st31.close();
          out.print("<td><center><A HREF=\"deleteresourceprofile.jsp?TODO=DELETE&PROFILEID="+r30.getString("ID")+"&EMPLOYEEID="+EMPLOYEEID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        Conn.close();
      }

    %>
  </body>
</html>
