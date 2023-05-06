
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

  <%!void updateresourceactivity(String ID,Connection Conn,String PRODUCTID,String MODELID) throws Exception {
      Statement st31 = Conn.createStatement();  
      String q31 = "SELECT ID FROM PRODUCT_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND FATHER='"+ID+"'";
      ResultSet r31 = st31.executeQuery(q31);
      while(r31.next()) {
        Statement sti2 = Conn.createStatement();
        String i2 = "DELETE FROM PRODUCT_RESOURCE_USER_ACTIVITY WHERE ACTIVITYID="+r31.getString("ID")+" AND PRODUCTID='"+PRODUCTID+"'";
        sti2.executeUpdate(i2);  
        sti2.close();
        Statement st32 = Conn.createStatement();  
        String q32 = "SELECT * FROM PRODUCT_RESOURCE_USER_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND ACTIVITYID='"+MODELID+"'";
        ResultSet r32 = st32.executeQuery(q32);
        while(r32.next()) {
          sti2 = Conn.createStatement();
          i2 = "INSERT INTO PRODUCT_RESOURCE_USER_ACTIVITY VALUES('"+PRODUCTID+"',"+r31.getString("ID")+",'"+r32.getString("EMPLOYEEID")+"',"+r32.getInt("PERCENTAGE")+",'"+r32.getString("PROFILEID")+"')";
          sti2.executeUpdate(i2);  
          sti2.close();
        }
        st32.close();
        updateresourceactivity(r31.getString("ID"),Conn,PRODUCTID,MODELID);
      }
      st31.close();
    }
  %>

  <%!void updateprofileactivity(String ID,Connection Conn,String PRODUCTID,String MODELID) throws Exception {
      Statement st31 = Conn.createStatement();  
      String q31 = "SELECT ID FROM PRODUCT_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND FATHER='"+ID+"'";
      ResultSet r31 = st31.executeQuery(q31);
      while(r31.next()) {
        Statement sti2 = Conn.createStatement();
        String i2 = "DELETE FROM PRODUCT_RESOURCE_PROFILE_ACTIVITY WHERE ACTIVITYID="+r31.getString("ID")+" AND PRODUCTID='"+PRODUCTID+"'";
        sti2.executeUpdate(i2);  
        sti2.close();
        Statement st32 = Conn.createStatement();  
        String q32 = "SELECT * FROM PRODUCT_RESOURCE_PROFILE_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND ACTIVITYID='"+MODELID+"'";
        ResultSet r32 = st32.executeQuery(q32);
        while(r32.next()) {
          sti2 = Conn.createStatement();
          i2 = "INSERT INTO PRODUCT_RESOURCE_PROFILE_ACTIVITY VALUES('"+PRODUCTID+"',"+r31.getString("ID")+",'"+r32.getString("PROFILEID")+"',"+r32.getInt("PERCENTAGE")+")";
          sti2.executeUpdate(i2);  
          sti2.close();
        }
        st32.close();
        updateprofileactivity(r31.getString("ID"),Conn,PRODUCTID,MODELID);
      }
      st31.close();
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
        String PRODUCTID = request.getParameter("PRODUCTID");
        String ACTIVITYID = request.getParameter("ACTIVITYID");
      	if (act.equals("PROADD")) {
          String PROFILEID = request.getParameter("PROFILEID");
          Statement sti2 = Conn.createStatement();
          String i2 = "INSERT INTO PRODUCT_RESOURCE_PROFILE_ACTIVITY VALUES ('"+PRODUCTID+"',"+ACTIVITYID+",'"+PROFILEID+"',100)";
          sti2.executeUpdate(i2);
          sti2.close();
          updateprofileactivity(ACTIVITYID,Conn,PRODUCTID,ACTIVITYID);
        }
        if (act.equals("PROPERCENT")) {
          String PROFILEID = request.getParameter("PROFILEID");
          String PERCENTAGE = request.getParameter("PERCENTAGE");
          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE PRODUCT_RESOURCE_PROFILE_ACTIVITY SET PERCENTAGE="+PERCENTAGE+" WHERE PRODUCTID='"+PRODUCTID+"' AND ACTIVITYID="+ACTIVITYID+" AND PROFILEID='"+PROFILEID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
          updateprofileactivity(ACTIVITYID,Conn,PRODUCTID,ACTIVITYID);
        }
        if (act.equals("PRODELETE")) {
          String PROFILEID = request.getParameter("PROFILEID");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM  PRODUCT_RESOURCE_PROFILE_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND ACTIVITYID="+ACTIVITYID+" AND PROFILEID='"+PROFILEID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
          updateprofileactivity(ACTIVITYID,Conn,PRODUCTID,ACTIVITYID);
        }
        if (act.equals("USRADD")) {
          String EMPLOYEEID = request.getParameter("EMPLOYEEID");
          Statement sti2 = Conn.createStatement();
          String i2 = "INSERT INTO PRODUCT_RESOURCE_USER_ACTIVITY VALUES ('"+PRODUCTID+"',"+ACTIVITYID+",'"+EMPLOYEEID+"',100,'NONE','NO')";
          sti2.executeUpdate(i2);
          sti2.close();
          updateresourceactivity(ACTIVITYID,Conn,PRODUCTID,ACTIVITYID);
        }
        if (act.equals("USRPROFILE")) {
          String EMPLOYEEID = request.getParameter("EMPLOYEEID");
          String PROFILEID = request.getParameter("PROFILEID");
          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE PRODUCT_RESOURCE_USER_ACTIVITY SET PROFILEID='"+PROFILEID+"' WHERE PRODUCTID='"+PRODUCTID+"' AND ACTIVITYID="+ACTIVITYID+" AND EMPLOYEEID='"+EMPLOYEEID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
          updateresourceactivity(ACTIVITYID,Conn,PRODUCTID,ACTIVITYID);
        }
        if (act.equals("USRPERCENT")) {
          String EMPLOYEEID = request.getParameter("EMPLOYEEID");
          String PERCENTAGE = request.getParameter("PERCENTAGE");
          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE PRODUCT_RESOURCE_USER_ACTIVITY SET PERCENTAGE="+PERCENTAGE+" WHERE PRODUCTID='"+PRODUCTID+"' AND ACTIVITYID="+ACTIVITYID+" AND EMPLOYEEID='"+EMPLOYEEID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
          updateresourceactivity(ACTIVITYID,Conn,PRODUCTID,ACTIVITYID);
        }
        if (act.equals("USRDELETE")) {
          String EMPLOYEEID = request.getParameter("EMPLOYEEID");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM  PRODUCT_RESOURCE_USER_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND ACTIVITYID="+ACTIVITYID+" AND EMPLOYEEID='"+EMPLOYEEID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
          updateresourceactivity(ACTIVITYID,Conn,PRODUCTID,ACTIVITYID);
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/resources.png\"></td><td><strong><h1>Activity ressources</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Product Portfolio \\ <A HREF=\"productportfolio.jsp?TODO=NONE\" target=\"appliFrame\"> Products</A> \\ <A HREF=\"productplanning.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"\"> Product Planning </A>\\ Activity resources</td><td><A HREF=\"productresourcesactivity.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");

       Statement st301 = Conn.createStatement();
        String q301 = "SELECT * FROM PRODUCT_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND FATHER="+ACTIVITYID;
        ResultSet r301 = st301.executeQuery(q301);
        if(r301.next()) {
          out.print("<H2> <center>WARNING !, MODIFYING THE RESOUCE AT THIS LEVEL,<br> WILL REPLACE THE RESOURCE DATA FOR ALL ACTIVITIES LINKED TO THIS ONE</CENTER></H2><HR>");
        }
        st301.close();

        out.print("<table><tr><td><h2><strong>Required profile(s)</strong></h2></center></td><td><A HREF=\"productprofileactivityit.jsp?TODO=ADD&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"30%\" background=\"images/fond_titre.jpg\"><center>Percentage assigned</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT PROFILEID,PERCENTAGE FROM PRODUCT_RESOURCE_PROFILE_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND ACTIVITYID="+ACTIVITYID;
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          Statement st31 = Conn.createStatement();
          String q31 = "SELECT ID,NAME FROM PROFILE WHERE ID='"+r30.getString("PROFILEID")+"'";
          ResultSet r31 = st31.executeQuery(q31);
          if (r31.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("ID")+"</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("NAME")+"</center></A></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>?</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>?</center></A></td>");
          }
          st31.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+r30.getString("PERCENTAGE")+"</td><td><A HREF=\"productprofileactivitypercentit.jsp?TODO=ADD&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"&PROFILEID="+r30.getString("PROFILEID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></A></td>");
          out.print("<td><center><A HREF=\"deleteproductprofileactivity.jsp?TODO=DELETE&PROFILEID="+r30.getString("PROFILEID")+"&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        st30.close();
        out.print("</table><br><br>");
        out.print("<hr><table><tr><td><h2><strong>Assigned employee(s)</strong></h2></center></td><td><A HREF=\"productemployeeactivityit.jsp?TODO=ADD&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Forname</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Working as profile</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Percentage assigned</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Approved</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT EMPLOYEEID,PERCENTAGE,PROFILEID,APPROVED FROM PRODUCT_RESOURCE_USER_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND ACTIVITYID="+ACTIVITYID;
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          Statement st31 = Conn.createStatement();
          String q31 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID='"+r30.getString("EMPLOYEEID")+"'";
          ResultSet r31 = st31.executeQuery(q31);
          if (r31.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("ID")+"</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("NAME")+"</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("FORNAME")+"</center></A></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>?</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>?</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>?</center></A></td>");
          }
          st31.close();
          st31 = Conn.createStatement();
          q31 = "SELECT ID,NAME FROM PROFILE WHERE ID='"+r30.getString("PROFILEID")+"'";
          r31 = st31.executeQuery(q31);
          if (r31.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+r31.getString("NAME")+"</td><td><A HREF=\"productemployeeactivityprofileit.jsp?TODO=ADD&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"&EMPLOYEEID="+r30.getString("EMPLOYEEID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></A></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+r30.getString("PROFILEID")+"</td><td><A HREF=\"productemployeeactivityprofileit.jsp?TODO=ADD&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"&EMPLOYEEID="+r30.getString("EMPLOYEEID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></A></td>");
          }
          st31.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+r30.getString("PERCENTAGE")+"</td><td><A HREF=\"productemployeeactivitypercentit.jsp?TODO=ADD&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"&EMPLOYEEID="+r30.getString("EMPLOYEEID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("APPROVED")+"</center></A></td>");
          out.print("<td><center><A HREF=\"deleteproductemployeeactivity.jsp?TODO=DELETE&EMPLOYEEID="+r30.getString("EMPLOYEEID")+"&PRODUCTID="+PRODUCTID+"&ACTIVITYID="+ACTIVITYID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        Conn.close();
      }

    %>
  </body>
</html>
