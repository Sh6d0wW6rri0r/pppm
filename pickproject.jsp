
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
        String PROGRAMID = request.getParameter("PROGRAMID");
        String ptmp = request.getParameter("PAGE");

        int PAGE=0;
        if (ptmp==null) {
          PAGE=0;
        } else {
          PAGE=Integer.parseInt(ptmp);
        }      	
        out.print("<center><strong><h1>Project(s)</h1></strong></center><hr>");
        out.print("You are here : Portfolio \\ <A HREF=\"program.jsp?TODO=NONE\" target=\"appliFrame\"> Program(s)</A> \\ <A HREF=\"programdetails.jsp?TODO=NONE&PROGRAMID="+PROGRAMID+"\" target=\"appliFrame\">Program details</A> \\ Add BPO");
        out.print("<hr>");
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"pickproject.jsp?TODO=FILTER&FILTER=FILTER&PROGRAMID="+PROGRAMID+"&PAGE=0\" target=\"appliFrame\">");
        String LASTFILTERLOCATION=null;
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERLOCATIONPICKPRJ'";
        ResultSet R02 = STR02.executeQuery(QR02);
        if (R02.next()) {
          LASTFILTERLOCATION=R02.getString("FILTERVALUE");
        }
        STR02.close();
        String LASTFILTERDIVISION=null;
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERDIVISIONPICKPRJ'";
        ResultSet R03 = STR03.executeQuery(QR03);
        if (R03.next()) {
          LASTFILTERDIVISION=R03.getString("FILTERVALUE");
        }
        STR03.close();
        String LASTFILTERBPO=null;
        Statement STR04 = Conn.createStatement();
        String QR04 = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERBPOPICKPRJ'";
        ResultSet R04 = STR04.executeQuery(QR04);
        if (R04.next()) {
          LASTFILTERBPO=R04.getString("FILTERVALUE");
        }
        STR04.close();
        String LASTFILTERPM=null;
        Statement STR05 = Conn.createStatement();
        String QR05 = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERPMPICKPRJ'";
        ResultSet R05 = STR05.executeQuery(QR05);
        if (R05.next()) {
          LASTFILTERPM=R05.getString("FILTERVALUE");
        }
        STR05.close();
        String LASTFILTERSI=null;
        Statement STR06 = Conn.createStatement();
        String QR06 = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERSIPICKPRJ'";
        ResultSet R06 = STR06.executeQuery(QR06);
        if (R06.next()) {
          LASTFILTERSI=R06.getString("FILTERVALUE");
        }
        STR06.close();
        String LASTFILTERAT=null;
        Statement STR07 = Conn.createStatement();
        String QR07 = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERATPICKPRJ'";
        ResultSet R07 = STR07.executeQuery(QR07);
        if (R07.next()) {
          LASTFILTERAT=R07.getString("FILTERVALUE");
        }
        STR07.close();
        String LASTFILTERIT=null;
        Statement STR08 = Conn.createStatement();
        String QR08 = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERITPICKPRJ'";
        ResultSet R08 = STR08.executeQuery(QR08);
        if (R08.next()) {
          LASTFILTERIT=R08.getString("FILTERVALUE");
        }
        STR08.close();
        String filter = request.getParameter("FILTER");
        String filterstatement ="";
        String filstrlocation=request.getParameter("SELECTFILTERLOCATION");
        String filstrdivision=request.getParameter("SELECTFILTERDIVISION");
        String filstrBPO=request.getParameter("SELECTFILTERBPO");
        String filstrPM=request.getParameter("SELECTFILTERPM");
        String filstrSI=request.getParameter("SELECTFILTERSI");
        String filstrAT=request.getParameter("SELECTFILTERAT");
        String filstrIT=request.getParameter("SELECTFILTERIT");
        if (filstrlocation==null) {
          if (LASTFILTERLOCATION!=null) {
            filter="FILTER";
            filstrlocation=LASTFILTERLOCATION;
          } else {
            filter=null;
            filstrlocation="*** - ALL";
          }
        } else {
          if (LASTFILTERLOCATION!=null) {
            Statement STU03 = Conn.createStatement();
            String QU03 = "UPDATE FILTER SET FILTERVALUE='"+filstrlocation+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERLOCATIONPICKPRJ'";
            STU03.executeUpdate(QU03);
            STU03.close();
          } else {
            Statement STU04 = Conn.createStatement();
            String QU04 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERLOCATIONPICKPRJ','"+filstrlocation+"')";
            STU04.executeUpdate(QU04);
            STU04.close();
          }
        }
        if (filstrdivision==null) {
          if (LASTFILTERDIVISION!=null) {
            filter="FILTER";
            filstrdivision=LASTFILTERDIVISION;
          } else {
            filter=null;
            filstrdivision="*** - ALL";
          }
        } else {
          if (LASTFILTERDIVISION!=null) {
            Statement STU05 = Conn.createStatement();
            String QU05 = "UPDATE FILTER SET FILTERVALUE='"+filstrdivision+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERDIVISIONPICKPRJ'";
            STU05.executeUpdate(QU05);
            STU05.close();
          } else {
            Statement STU06 = Conn.createStatement();
            String QU06 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERDIVISIONPICKPRJ','"+filstrdivision+"')";
            STU06.executeUpdate(QU06);
            STU06.close();
          }
        }
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
            Statement STU07 = Conn.createStatement();
            String QU07 = "UPDATE FILTER SET FILTERVALUE='"+filstrBPO+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERBPOPICKPRJ'";
            STU07.executeUpdate(QU07);
            STU07.close();
          } else {
            Statement STU08 = Conn.createStatement();
            String QU08 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERBPOPICKPRJ','"+filstrBPO+"')";
            STU08.executeUpdate(QU08);
            STU08.close();
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
            Statement STU09 = Conn.createStatement();
            String QU09 = "UPDATE FILTER SET FILTERVALUE='"+filstrPM+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERPMPICKPRJ'";
            STU09.executeUpdate(QU09);
            STU09.close();
          } else {
            Statement STU10 = Conn.createStatement();
            String QU10 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERPMPICKPRJ','"+filstrPM+"')";
            STU10.executeUpdate(QU10);
            STU10.close();
          }
        }
        if (filstrSI==null) {
          if (LASTFILTERSI!=null) {
            filter="FILTER";
            filstrSI=LASTFILTERSI;
          } else {
            filter=null;
            filstrSI="ALL";
          }
        } else {
          if (LASTFILTERSI!=null) {
            Statement STU11 = Conn.createStatement();
            String QU11 = "UPDATE FILTER SET FILTERVALUE='"+filstrSI+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERSIPICKPRJ'";
            STU11.executeUpdate(QU11);
            STU11.close();
          } else {
            Statement STU12 = Conn.createStatement();
            String QU12 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERSIPICKPRJ','"+filstrSI+"')";
            STU12.executeUpdate(QU12);
            STU12.close();
          }
        }
        if (filstrAT==null) {
          if (LASTFILTERAT!=null) {
            filter="FILTER";
            filstrAT=LASTFILTERAT;
          } else {
            filter=null;
            filstrAT="ALL";
          }
        } else {
          if (LASTFILTERAT!=null) {
            Statement STU13 = Conn.createStatement();
            String QU13 = "UPDATE FILTER SET FILTERVALUE='"+filstrAT+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERATPICKPRJ'";
            STU13.executeUpdate(QU13);
            STU13.close();
          } else {
            Statement STU14 = Conn.createStatement();
            String QU14 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERATPICKPRJ','"+filstrAT+"')";
            STU14.executeUpdate(QU14);
            STU14.close();
          }
        }
        if (filstrIT==null) {
          if (LASTFILTERIT!=null) {
            filter="FILTER";
            filstrIT=LASTFILTERIT;
          } else {
            filter=null;
            filstrIT="ALL";
          }
        } else {
          if (LASTFILTERIT!=null) {
            Statement STU15 = Conn.createStatement();
            String QU15 = "UPDATE FILTER SET FILTERVALUE='"+filstrIT+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERITPICKPRJ'";
            STU15.executeUpdate(QU15);
            STU15.close();
          } else {
            Statement STU16 = Conn.createStatement();
            String QU16 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERITPICKPRJ','"+filstrIT+"')";
            STU16.executeUpdate(QU16);
            STU16.close();
          }
        }
        out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
        out.print("<tr><td bgcolor=#FFFFFF>");
        out.print("<table width=\"100%\"><tr>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("<table width=\"100%\"><tr>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Filter by Location : <select name=\"SELECTFILTERLOCATION\">");
        out.print("<option>*** - ALL</option>");
        Statement STR09 = Conn.createStatement();
        String QR09 = "SELECT ID,NAME FROM LOCATION ORDER BY NAME";
        ResultSet R09 = STR09.executeQuery(QR09);
        while(R09.next()) {
          out.print("<option");
          if (filstrlocation.equals(R09.getString("ID")+" - "+R09.getString("NAME"))) {
            out.print(" selected ");
          }
          out.print(">"+R09.getString("ID")+" - "+R09.getString("NAME")+"</option>");
        }
        STR09.close();
        out.print("</select>");
        out.print("</td>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Division : <select name=\"SELECTFILTERDIVISION\">");
        out.print("<option>*** - ALL</option>");
        Statement STR10 = Conn.createStatement();
        String QR10 = "SELECT ID,NAME FROM DIVISION ORDER BY NAME";
        ResultSet R10 = STR10.executeQuery(QR10);
        while(R10.next()) {
          out.print("<option");
          if (filstrdivision.equals(R10.getString("ID")+" - "+R10.getString("NAME"))) {
            out.print(" selected ");
          }
          out.print(">"+R10.getString("ID")+" - "+R10.getString("NAME")+"</option>");
        }
        STR10.close();
        out.print("</select>");
        out.print("</td>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("BPO : <select name=\"SELECTFILTERBPO\">");
        out.print("<option>*** - ALL</option>");
        Statement STR11 = Conn.createStatement();
        String QR11 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (select EMPLOYEEID FROM PRJBPO)  ORDER BY NAME,FORNAME";
        ResultSet R11 = STR11.executeQuery(QR11);
        while(R11.next()) {
          out.print("<option");
          if (filstrBPO.equals(R11.getString("ID")+" - "+R11.getString("NAME")+" "+R11.getString("FORNAME"))) {
            out.print(" selected ");
          }
          out.print(">"+R11.getString("ID")+" - "+R11.getString("NAME")+" "+R11.getString("FORNAME")+"</option>");
        }
        STR11.close();
        out.print("</select>");
        out.print("</td>");
        out.print("</tr>");
        out.print("</table>");
        out.print("</td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td>");
        out.print("<table width=\"100%\"><tr>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Project Manager : <select name=\"SELECTFILTERPM\">");
        out.print("<option>*** - ALL</option>");
        Statement STR12 = Conn.createStatement();
        String QR12 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (select EMPLOYEEID FROM PRJPM) ORDER BY NAME,FORNAME";
        ResultSet R12 = STR12.executeQuery(QR12);
        while(R12.next()) {
          out.print("<option");
          if (filstrPM.equals(R12.getString("ID")+" - "+R12.getString("NAME")+" "+R12.getString("FORNAME"))) {
            out.print(" selected ");
          }
          out.print(">"+R12.getString("ID")+" - "+R12.getString("NAME")+" "+R12.getString("FORNAME")+"</option>");
        }
        STR12.close();
        out.print("</select>");
        out.print("</td>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Strategic initiative : <select name=\"SELECTFILTERSI\">");
        out.print("<option>*** - ALL</option>");
        Statement STR13 = Conn.createStatement();
        String QR13 = "SELECT ID,NAME FROM STRATEGICINITIATIVE ORDER BY NAME";
        ResultSet R13 = STR13.executeQuery(QR13);
        while(R13.next()) {
          out.print("<option");
          if (filstrSI.equals(R13.getString("ID")+" - "+R13.getString("NAME"))) {
            out.print(" selected ");
          }
          out.print(">"+R13.getString("ID")+" - "+R13.getString("NAME")+"</option>");
        }
        STR13.close();
        out.print("</select>");
        out.print("</td>");
        out.print("</tr>");
        out.print("</table>");
        out.print("</td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td>");
        out.print("<table width=\"100%\"><tr>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Application type : <select name=\"SELECTFILTERAT\">");
        out.print("<option>*** - ALL</option>");
        Statement STR14 = Conn.createStatement();
        String QR14 = "SELECT ID,NAME FROM APPLICATIONTYPE ORDER BY NAME";
        ResultSet R14 = STR14.executeQuery(QR14);
        while(R14.next()) {
          out.print("<option");
          if (filstrAT.equals(R14.getString("ID")+" - "+R14.getString("NAME"))) {
            out.print(" selected ");
          }
          out.print(">"+R14.getString("ID")+" - "+R14.getString("NAME")+"</option>");
        }
        STR14.close();
        out.print("</select>");
        out.print("</td>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Infrastructure type : <select name=\"SELECTFILTERIT\">");
        out.print("<option>*** - ALL</option>");
        Statement STR15 = Conn.createStatement();
        String QR15 = "SELECT ID,NAME FROM INFRASTRUCTURETYPE ORDER BY NAME";
        ResultSet R15 = STR15.executeQuery(QR15);
        while(R15.next()) {
          out.print("<option");
          if (filstrIT.equals(R15.getString("ID")+" - "+R15.getString("NAME"))) {
            out.print(" selected ");
          }
          out.print(">"+R15.getString("ID")+" - "+R15.getString("NAME")+"</option>");
        }
        STR15.close();
        out.print("</select>");
        out.print("</td>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("<input type=\"image\" border=0 src=\"icons/search.png\" name=\"filter\" value=\"submit\"></center>");
        out.print("</td>");
        out.print("</tr></table>");
        out.print("</td>");
        out.print("</tr></table>");
        out.print("</td>");
        out.print("</tr></table>");
        out.print("<br>");
        out.print("</form>");
        boolean first=true;
        if (filter!= null) {
          String idfillocation = filstrlocation.substring(0,filstrlocation.indexOf("-")-1);
          if (!idfillocation.equals("***")) {
            filterstatement = " ID in (SELECT PROJECTID FROM PRJLOC WHERE LOCATIONID='"+idfillocation+"')";
            first = false;
          }
          String idfildivision = filstrdivision.substring(0,filstrdivision.indexOf("-")-1);
          if (!idfildivision.equals("***")) {
            if (!first) {
              filterstatement = filterstatement + " AND ";
            }
            filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJDIV WHERE DIVISIONID='"+idfildivision+"')";
            first = false;
          }
          String idfilBPO = filstrBPO.substring(0,filstrBPO.indexOf("-")-1);
          if (!idfilBPO.equals("***")) {
            if (!first) {
              filterstatement = filterstatement + " AND ";
            }
            filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJBPO WHERE EMPLOYEEID='"+idfilBPO+"')";
            first = false;
          }
          String idfilPM = filstrPM.substring(0,filstrPM.indexOf("-")-1);
          if (!idfilPM.equals("***")) {
            if (!first) {
              filterstatement = filterstatement + " AND ";
            }
            filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJPM WHERE EMPLOYEEID='"+idfilPM+"')";
            first = false;
          }
          String idfilSI = filstrSI.substring(0,filstrSI.indexOf("-")-1);
          if (!idfilSI.equals("***")) {
            if (!first) {
              filterstatement = filterstatement + " AND ";
            }
            filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJSI WHERE SIID='"+idfilSI+"')";
            first = false;
          }
          String idfilAT = filstrAT.substring(0,filstrAT.indexOf("-")-1);
          if (!idfilAT.equals("***")) {
            if (!first) {
              filterstatement = filterstatement + " AND ";
            }
            filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJAT WHERE ATID='"+idfilAT+"')";
            first = false;
          }
          String idfilIT = filstrIT.substring(0,filstrIT.indexOf("-")-1);
          if (!idfilIT.equals("***")) {
            if (!first) {
              filterstatement = filterstatement + " AND ";
            }
            filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJIT WHERE ITID='"+idfilIT+"')";
            first = false;
          }
        }
        if (!first) {
          filterstatement = filterstatement+" AND ";
        }

        out.print("<hr>");

        int nbpage=0;
        Statement st230 = Conn.createStatement();
        String q230 = "SELECT COUNT(ID) FROM PROJECT WHERE "+filterstatement+" ID NOT IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"')";
        ResultSet r230 = st230.executeQuery(q230);
        if (r230.next()) {    
          nbpage=r230.getInt("COUNT(ID)")/20;
        }
        st230.close();
        out.print("<table><tr><td>Page : </td>");
        for (int i=0; i<=nbpage;i++) {
          out.print("<td><A HREF=\"pickproject.jsp?TODO=ADD&PAGE="+i+"&PROGRAMID="+PROGRAMID+"\">"+i+"</A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"10%\">&nbsp;</td>");
        out.print("<td width=\"80%\" background=\"images/fond_titre.jpg\"><center>Project</center></td>");
        out.print("<td width=\"10%\">&nbsp;</td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME FROM PROJECT WHERE "+filterstatement+" ID NOT IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"')";
        ResultSet R01 = STR01.executeQuery(QR01);
        int pagecount=0;
        while(R01.next()) {
          if (pagecount>=PAGE*20 && pagecount<(PAGE+1)*20) {
            out.print("<tr>");
            out.print("<td>&nbsp;</td>");
            out.print("<td bgcolor=\"#FFFFFF\"><A HREF=\"programdetails.jsp?TODO=PRJADD&ID="+R01.getString("ID")+"&PROGRAMID="+PROGRAMID+"\">"+R01.getString("NAME")+"</td>");
            out.print("<td>&nbsp;</td>");
            out.print("</tr>");
          }
          pagecount++;
        }
        STR01.close();
        out.print("</table>");
        out.print("<A HREF=\"programdetails.jsp?TODO=NONE&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/cancel.png\"></A>");
        Conn.close();
      }

    %>
  </body>
</html>
