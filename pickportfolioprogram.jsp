
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
   
        // JSP parameter
        String Language = (String)session.getAttribute("LANGUAGE");
        String act = request.getParameter("TODO");
        String PORTFOLIOID = request.getParameter("PORTFOLIOID");
        String ptmp = request.getParameter("PAGE");

        int PAGE=0;
        if (ptmp==null) {
          PAGE=0;
        } else {
          PAGE=Integer.parseInt(ptmp);
        }
      	out.print("<center><strong><h1>Program(s)</h1></strong></center><hr>");
        out.print("You are here : Portfolio \\ <A HREF=\"portconfig.jsp?TODO=NONE\" target=\"appliFrame\"> Portfolio configuration</A> \\ <A HREF=\"portfolioprogram.jsp?TODO=NONE&PORTFOLIOID="+PORTFOLIOID+"\" target=\"appliFrame\">Portfolio program(s)</A> \\ Add Program");
        out.print("<hr>");
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"pickportfolioprogram.jsp?TODO=FILTER&FILTER=FILTER&PORTFOLIOID="+PORTFOLIOID+"&PAGE=0\" target=\"appliFrame\">");
        String LASTFILTERBPO=null;
        Statement st123b = Conn.createStatement();
        String q123b = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERBPOPGMPICK'";
        ResultSet r123b = st123b.executeQuery(q123b);
        if (r123b.next()) {
          LASTFILTERBPO=r123b.getString("FILTERVALUE");
        }
        st123b.close();
        String LASTFILTERPM=null;
        Statement st123c = Conn.createStatement();
        String q123c = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERPMPGMPICK'";
        ResultSet r123c = st123c.executeQuery(q123c);
        if (r123c.next()) {
          LASTFILTERPM=r123c.getString("FILTERVALUE");
        }
        st123c.close();
        String filter = request.getParameter("FILTER");
        String filterstatement ="";
        String filstrBPO=request.getParameter("SELECTFILTERBPO");
        String filstrPM=request.getParameter("SELECTFILTERPM");
        if (filstrBPO==null) {
          if (LASTFILTERBPO!=null) {
            filter="FILTER";
            filstrBPO=LASTFILTERBPO;
          } else {
            filter=null;
            filstrBPO="*** - ALL";
          }
        } else {
          if (LASTFILTERBPO!=null) {
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE FILTER SET FILTERVALUE='"+filstrBPO+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERBPOPGMPICK'";
            sti2.executeUpdate(i2);
            sti2.close();
          } else {
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERBPOPGMPICK','"+filstrBPO+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        if (filstrPM==null) {
          if (LASTFILTERPM!=null) {
            filter="FILTER";
            filstrPM=LASTFILTERPM;
          } else {
            filter=null;
            filstrPM="ALL";
          }
        } else {
          if (LASTFILTERPM!=null) {
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE FILTER SET FILTERVALUE='"+filstrPM+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERPMPGMPICK'";
            sti2.executeUpdate(i2);
            sti2.close();
          } else {
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERPMPGMPICK','"+filstrPM+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
        out.print("<tr><td bgcolor=#FFFFFF>");
        out.print("<table width=\"100%\"><tr>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("BPO : <select name=\"SELECTFILTERBPO\">");
        out.print("<option>*** - ALL</option>");
        Statement st22 = Conn.createStatement();
        String q22 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (select EMPLOYEEID FROM PGMBPO)  ORDER BY NAME,FORNAME";
        ResultSet r22 = st22.executeQuery(q22);
        while(r22.next()) {
          out.print("<option");
          if (filstrBPO.equals(r22.getString("ID")+" - "+r22.getString("NAME")+" "+r22.getString("FORNAME"))) {
            out.print(" selected ");
          }
          out.print(">"+r22.getString("ID")+" - "+r22.getString("NAME")+" "+r22.getString("FORNAME")+"</option>");
        }
        st22.close();
        out.print("</select>");
        out.print("</td>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Program Manager : <select name=\"SELECTFILTERPM\">");
        out.print("<option>*** - ALL</option>");
        Statement st23 = Conn.createStatement();
        String q23 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (select EMPLOYEEID FROM PGMPM) ORDER BY NAME,FORNAME";
        ResultSet r23 = st23.executeQuery(q23);
        while(r23.next()) {
          out.print("<option");
          if (filstrPM.equals(r23.getString("ID")+" - "+r23.getString("NAME")+" "+r23.getString("FORNAME"))) {
            out.print(" selected ");
          }
          out.print(">"+r23.getString("ID")+" - "+r23.getString("NAME")+" "+r23.getString("FORNAME")+"</option>");
        }
        st23.close();
        out.print("</select>");
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
          String idfilBPO = filstrBPO.substring(0,filstrBPO.indexOf("-")-1);
          if (!idfilBPO.equals("***")) {
            if (!first) {
              filterstatement = filterstatement + " AND ";
            } else {
              filterstatement = " WHERE " ;
            }
            filterstatement = filterstatement + "ID in (SELECT PROGRAMID FROM PGMBPO WHERE EMPLOYEEID='"+idfilBPO+"')";
            first = false;
          }
          String idfilPM = filstrPM.substring(0,filstrPM.indexOf("-")-1);
          if (!idfilPM.equals("***")) {
            if (!first) {
              filterstatement = filterstatement + " AND ";
            } else {
              filterstatement = " WHERE " ;
            }
            filterstatement = filterstatement + "ID in (SELECT PROGRAMID FROM PGMPM WHERE EMPLOYEEID='"+idfilPM+"')";
            first = false;
          }
        }
        if (first) {
          filterstatement="WHERE";
        } else {
          filterstatement=filterstatement+" AND ";
        }

        out.print("<hr>");
        int nbpage=0;
        Statement st230 = Conn.createStatement();
        String q230 = "SELECT COUNT(ID) FROM PROGRAM "+filterstatement+" ID NOT IN (SELECT PROGRAMID FROM PGMPOR WHERE PORTFOLIOID='"+PORTFOLIOID+"')";
        ResultSet r230 = st230.executeQuery(q230);
        if (r230.next()) {    
          nbpage=r230.getInt("COUNT(ID)")/20;
        }
        st230.close();
        out.print("<table><tr><td>Page : </td>");
        for (int i=0; i<=nbpage;i++) {
          out.print("<td><A HREF=\"pickportfolioprogram.jsp?TODO=ADD&PAGE="+i+"&PORTFOLIOID="+PORTFOLIOID+"\">"+i+"</A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"10%\">&nbsp;</td>");
        out.print("<td width=\"80%\" background=\"images/fond_titre.jpg\"><center>Program</center></td>");
        out.print("<td width=\"10%\">&nbsp;</td>");
        out.print("</tr>");        
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME FROM PROGRAM "+filterstatement+" ID NOT IN (SELECT PROGRAMID FROM PGMPOR WHERE PORTFOLIOID='"+PORTFOLIOID+"')";
        ResultSet R01 = STR01.executeQuery(QR01);
        int pagecount=0;
        while(R01.next()) {
          if (pagecount>=PAGE*20 && pagecount<(PAGE+1)*20) {
            out.print("<tr>");
            out.print("<td>&nbsp;</td>");          
            out.print("<td bgcolor=\"#FFFFFF\"><A HREF=\"portfolioprogram.jsp?TODO=ADD&PROGRAMID="+R01.getString("ID")+"&PORTFOLIOID="+PORTFOLIOID+"\">"+R01.getString("NAME")+"</td>");
            out.print("<td>&nbsp;</td>");          
            out.print("<tr>");
          }
          pagecount++;
        }
        STR01.close();
        out.print("</table>");
        out.print("<A HREF=\"portfolioprogram.jsp?TODO=NONE&PORTFOLIOID="+PORTFOLIOID+"\"><img border=0 src=\"icons/cancel.png\"></A>");
        Conn.close();
      }

    %>
  </body>
</html>
