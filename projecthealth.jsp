
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
        String PROJECTID = request.getParameter("PROJECTID");
      	if (act.equals("ADD")) {
          Calendar calnow = Calendar.getInstance();
          String datenow = ""+calnow.get(Calendar.YEAR)+"-"+(calnow.get(Calendar.MONTH)+1)+"-"+calnow.get(Calendar.DAY_OF_MONTH);
          Statement st330 = Conn.createStatement();
          String q330 = "SELECT * FROM HEALTH_QUESTION ORDER BY ORD";
          ResultSet r330 = st330.executeQuery(q330);
          while(r330.next()) {
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO PROJECT_HEALTH VALUES('"+PROJECTID+"','"+datenow+"','"+r330.getString("ID")+"',"+request.getParameter("ANSWER"+r330.getString("ID"))+",'"+checkstr(request.getParameter("COMMENT"+r330.getString("ID")))+"','"+request.getParameter("PHASE")+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
          st330.close();
        }
        if (act.equals("MOD")) {
          String DATE_HEALTH=request.getParameter("DATE_HEALTH");
          Statement st330 = Conn.createStatement();
          String q330 = "SELECT * FROM HEALTH_QUESTION ORDER BY ORD";
          ResultSet r330 = st330.executeQuery(q330);
          while(r330.next()) {
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE PROJECT_HEALTH SET RESULT="+request.getParameter("ANSWER"+r330.getString("ID"))+",COMMENT='"+checkstr(request.getParameter("COMMENT"+r330.getString("ID")))+"',PHASE='"+request.getParameter("PHASE")+"' WHERE PROJECTID='"+PROJECTID+"' AND HEALTH_QUESTIONID='"+r330.getString("ID")+"' AND DATE_HEALTH='"+DATE_HEALTH+"'";
            sti2.executeUpdate(i2);
            sti2.close();
          }
          st330.close();
        }
        if (act.equals("DELETE")) {
          String DATE_HEALTH=request.getParameter("DATE_HEALTH");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM PROJECT_HEALTH WHERE PROJECTID='"+PROJECTID+"' AND DATE_HEALTH='"+DATE_HEALTH+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/health.png\"></td><td><strong><h1>Project health check(s)</h1></strong></td></tr></table></center><hr>");
           out.print("<table><tr><td><h2><strong>Project Health check(s)</strong></h2></center></td>");
        Calendar calnow = Calendar.getInstance();
        String datenow = ""+calnow.get(Calendar.YEAR)+"-"+(calnow.get(Calendar.MONTH)+1)+"-"+calnow.get(Calendar.DAY_OF_MONTH);
        boolean canadd=true;
        boolean canupdate=true;
        Statement st29 = Conn.createStatement();
        String q29 = "SELECT * FROM PROJECT_HEALTH WHERE PROJECTID='"+PROJECTID+"' AND DATE_HEALTH='"+datenow+"'";
        ResultSet r29 = st29.executeQuery(q29);
        if (r29.next()) {
          canadd=false;
        }
        st29.close();
        st29 = Conn.createStatement();
        q29 = "SELECT * FROM USER_RIGHT WHERE LOGIN='"+Userlogin+"' AND USERRIGHT='HEALTH'";
        r29 = st29.executeQuery(q29);
        if (!r29.next()) {
          canupdate=false;  
        }
        st29.close();
        if (canadd && canupdate) {
          out.print("<td><A HREF=\"addhealth.jsp?TODO=ADD&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        } else {
          out.print("</tr></table>");
        }
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Date</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Phase</center></td>");
        Statement st330 = Conn.createStatement();
        int nbquestion=0;
        String q330 = "SELECT * FROM HEALTH_QUESTION ORDER BY ORD";
        ResultSet r330 = st330.executeQuery(q330);
        while(r330.next()) {
          out.print("<td background=\"images/fond_titre.jpg\"><center>"+r330.getString("NAME")+"</center></td>");
          nbquestion++;
        }
        st330.close();
        out.print("<td><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT DISTINCT DATE_HEALTH,PHASE FROM PROJECT_HEALTH WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet r30 = st30.executeQuery(q30);
        int lasthealth[] = new int[255];
        for (int i =0; i<255;i++) {
          lasthealth[i]=0;
        }
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><table><tr><td><center>"+r30.getString("DATE_HEALTH")+"</center></td>");
          if (canupdate) {
            out.print("<td><A HREF=\"addhealth.jsp?TODO=MOD&PROJECTID="+PROJECTID+"&DATE_HEALTH="+r30.getString("DATE_HEALTH")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></td>");
          } else {
            out.print("<td><A HREF=\"addhealth.jsp?TODO=DISP&PROJECTID="+PROJECTID+"&DATE_HEALTH="+r30.getString("DATE_HEALTH")+"\"><img border=0 src=\"icons/viewsmall.png\"></A></td></tr></table></td>");        
          }
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("PHASE")+"</center></td>");
          Statement st301 = Conn.createStatement();
          String q301 = "SELECT * FROM HEALTH_QUESTION ORDER BY ORD";
          ResultSet r301 = st301.executeQuery(q301);
          int nbq = 0;
          while(r301.next()) {
            Statement st302 = Conn.createStatement();
            String q302 = "SELECT * FROM PROJECT_HEALTH WHERE PROJECTID='"+PROJECTID+"' AND HEALTH_QUESTIONID='"+r301.getString("ID")+"' AND DATE_HEALTH='"+r30.getString("DATE_HEALTH")+"'";
            ResultSet r302 = st302.executeQuery(q302);
            if (r302.next()) {
              out.print("<td bgcolor=\"#FFFFFF\"><table><tr><td><center>"+r302.getString("RESULT")+"</center></td>");
              if (lasthealth[nbq]!=0) {
                if (lasthealth[nbq]>r302.getInt("RESULT")) {
                  out.print("<td><center><img border=0 src=\"icons/upsmall.png\"></center></td>");
                } else {
                  if (lasthealth[nbq]<r302.getInt("RESULT")) {
                    out.print("<td><center><img border=0 src=\"icons/downsmall.png\"></center></td>");
                  }
                }
              }          
              out.print("</tr></table></td>");
              lasthealth[nbq]=r302.getInt("RESULT");
            }
            st302.close();
            nbq++;
          }
          st301.close();
          if (canupdate) {
            out.print("<td><center><A HREF=\"deletehealth.jsp?TODO=DELETE&DATE_HEALTH="+r30.getString("DATE_HEALTH")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
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
