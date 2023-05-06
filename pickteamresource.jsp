
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
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>

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
        String TEAMID = request.getParameter("TEAMID");
        String ptmp = request.getParameter("PAGE");

        int PAGE=0;
        if (ptmp==null) {
          PAGE=0;
        } else {
          PAGE=Integer.parseInt(ptmp);
        }      	
        out.print("<center><strong><h1>Project(s)</h1></strong></center><hr>");
        out.print("You are here : Resources management \\ <A HREF=\"resconfig.jsp?TODO=NONE\" target=\"appliFrame\"> Resources configuration</A> \\ <A HREF=\"teamresource.jsp?TODO=NONE&TEAMID="+TEAMID+"\" target=\"appliFrame\">Team resource(s)</A> \\ Add resource");
        out.print("<hr>");
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"pickteamresource.jsp?TODO=FILTER&FILTER=FILTER&TEAMID="+TEAMID+"&PAGE=0\" target=\"appliFrame\">");
        String LASTFILTERNAME=null;
        Statement st123b = Conn.createStatement();
        String q123b = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERNAMEPICKTEAMRES'";
        ResultSet r123b = st123b.executeQuery(q123b);
        if (r123b.next()) {
          LASTFILTERNAME=r123b.getString("FILTERVALUE");
        }
        st123b.close();
        String LASTFILTERFORNAME=null;
        Statement st123c = Conn.createStatement();
        String q123c = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERFORNAMEPICKTEAMRES'";
        ResultSet r123c = st123c.executeQuery(q123c);
        if (r123c.next()) {
          LASTFILTERFORNAME=r123c.getString("FILTERVALUE");
        }
        st123c.close();
        String filter = request.getParameter("FILTER");
        String filterstatement ="";
        String filstrNAME=request.getParameter("SELECTFILTERNAME");
        String filstrFORNAME=request.getParameter("SELECTFILTERFORNAME");
        if (filstrNAME==null) {
          if (LASTFILTERNAME!=null) {
            filter="FILTER";
            filstrNAME=LASTFILTERNAME;
          } else {
            filter=null;
            filstrNAME="";
          }
        } else {
          if (LASTFILTERNAME!=null) {
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE FILTER SET FILTERVALUE='"+filstrNAME+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERNAMEPICKTEAMRES'";
            sti2.executeUpdate(i2);
            sti2.close();
          } else {
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERNAMEPICKTEAMRES','"+filstrNAME+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        if (filstrFORNAME==null) {
          if (LASTFILTERFORNAME!=null) {
            filter="FILTER";
            filstrFORNAME=LASTFILTERFORNAME;
          } else {
            filter=null;
            filstrFORNAME="";
          }
        } else {
          if (LASTFILTERFORNAME!=null) {
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE FILTER SET FILTERVALUE='"+filstrFORNAME+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERFORNAMEPICKTEAMRES'";
            sti2.executeUpdate(i2);
            sti2.close();
          } else {
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERFORNAMEPICKTEAMRES','"+filstrFORNAME+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
        out.print("<tr><td bgcolor=#FFFFFF>");
        out.print("<table width=\"100%\"><tr>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Name : </td><td><input name=\"SELECTFILTERNAME\" type=\"text\" size=\"50\" value=\""+filstrNAME+"\">");
        out.print("</td>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Forname : </td><td><input name=\"SELECTFILTERFORNAME\" type=\"text\" size=\"50\" value=\""+filstrFORNAME+"\">");
        out.print("</td>");
        out.print("<td>");
        out.print("<input type=\"image\" border=0 src=\"icons/search.png\" name=\"filter\" value=\"submit\"></center>");
        out.print("</td>");
        out.print("</tr></table>");
        out.print("</td>");
        out.print("</tr></table>");
        out.print("<br>");
        out.print("</form>");
        boolean first=true;
        if (filter!= null) {
          String idfilNAME = filstrNAME;
          String idfilFORNAME = filstrFORNAME;
          if (!idfilNAME.equals("") || !idfilFORNAME.equals("")) {
            if (idfilNAME.equals("")) {
              filterstatement = filterstatement + "MATCH (FORNAME) AGAINST ('"+filstrFORNAME+"*' IN BOOLEAN MODE)";
            } else {
              if (idfilFORNAME.equals("")) {
                filterstatement = filterstatement + "MATCH (NAME) AGAINST ('"+filstrNAME+"*' IN BOOLEAN MODE)";
              } else {
                filterstatement = filterstatement + "MATCH (NAME,FORNAME) AGAINST ('"+filstrNAME+"* "+filstrFORNAME+"*' IN BOOLEAN MODE)";
              }
            }            
            first = false;
          }
        }
        if (first) {
          filterstatement="";
        } else {
          filterstatement=filterstatement+" AND ";
        }

        int nbpage=0;
        Statement st230 = Conn.createStatement();
        String q230 = "SELECT COUNT(ID) FROM EMPLOYEE WHERE "+filterstatement+" ID NOT IN (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID='"+TEAMID+"')";
        ResultSet r230 = st230.executeQuery(q230);
        if (r230.next()) {    
          nbpage=r230.getInt("COUNT(ID)")/20;
        }
        st230.close();
        String NAME = "";
        out.print("<table><tr><td>Page : </td>");
        for (int i=0; i<=nbpage;i++) {
          out.print("<td><A HREF=\"pickteamresource.jsp?TODO=ADD&PAGE="+i+"&TEAMID="+TEAMID+"\">"+i+"</A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"10%\">&nbsp;</td>");
        out.print("<td width=\"80%\" background=\"images/fond_titre.jpg\"><center>Team member</center></td>");
        out.print("<td width=\"10%\">&nbsp;</td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE "+filterstatement+" ID NOT IN (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID='"+TEAMID+"')";
        ResultSet R01 = STR01.executeQuery(QR01);
        int pagecount=0;
        while(R01.next()) {
          if (pagecount>=PAGE*20 && pagecount<(PAGE+1)*20) {
            out.print("<tr>");
            out.print("<td>&nbsp;</td>");
            out.print("<td bgcolor=\"#FFFFFF\"><A HREF=\"teamresource.jsp?TODO=ADD&EMPLOYEEID="+R01.getString("ID")+"&TEAMID="+TEAMID+"\">"+R01.getString("NAME")+" "+R01.getString("FORNAME")+"</td>");
            out.print("<td>&nbsp;</td>");
            out.print("</tr>");
          }
          pagecount++;
        }
        STR01.close();
        out.print("</table>");
        out.print("<A HREF=\"teamresource.jsp?TODO=NONE&TEAMID="+TEAMID+"\"><img border=0 src=\"icons/cancel.png\"></A>");
        Conn.close();
      }

    %>
  </body>
</html>
