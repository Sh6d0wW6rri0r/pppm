
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
        String PROJECTID = request.getParameter("PROJECTID");
        String ptmp = request.getParameter("PAGE");

        int PAGE=0;
        if (ptmp==null) {
          PAGE=0;
        } else {
          PAGE=Integer.parseInt(ptmp);
        }
      	out.print("<center><strong><h1>Resource</h1></strong></center><hr>");
        out.print("You are here : Portfolio \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\"> Projects</A> \\ <A HREF=\"projectresources.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\" target=\"appliFrame\">Project resources</A> \\ Add resource");
        out.print("<hr>");       
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"pickresource.jsp?TODO=FILTER&FILTER=FILTER&PROJECTID="+PROJECTID+"&PAGE=0\" target=\"appliFrame\">");
        String LASTFILTERNAME=null;
        Statement st123b = Conn.createStatement();
        String q123b = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERNAMEPICKRES'";
        ResultSet r123b = st123b.executeQuery(q123b);
        if (r123b.next()) {
          LASTFILTERNAME=r123b.getString("FILTERVALUE");
        }
        st123b.close();
        String LASTFILTERFORNAME=null;
        Statement st123c = Conn.createStatement();
        String q123c = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERFORNAMEPICKRES'";
        ResultSet r123c = st123c.executeQuery(q123c);
        if (r123c.next()) {
          LASTFILTERFORNAME=r123c.getString("FILTERVALUE");
        }
        st123c.close();
        String LASTFILTERPROFILE=null;
        Statement st123d = Conn.createStatement();
        String q123d = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERPROFILEPICKRES'";
        ResultSet r123d = st123d.executeQuery(q123d);
        if (r123d.next()) {
          LASTFILTERPROFILE=r123d.getString("FILTERVALUE");
        }
        st123d.close();
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
            String i2 = "UPDATE FILTER SET FILTERVALUE='"+filstrNAME+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERNAMEPICKRES'";
            sti2.executeUpdate(i2);
            sti2.close();
          } else {
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERNAMEPICKRES','"+filstrNAME+"')";
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
            String i2 = "UPDATE FILTER SET FILTERVALUE='"+filstrFORNAME+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERFORNAMEPICKRES'";
            sti2.executeUpdate(i2);
            sti2.close();
          } else {
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERFORNAMEPICKRES','"+filstrFORNAME+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        String filstrPROFILE=request.getParameter("SELECTFILTERPROFILE");
        if (filstrPROFILE==null) {
          if (LASTFILTERPROFILE!=null) {
            filter="FILTER";
            filstrPROFILE=LASTFILTERPROFILE;
          } else {
            filter=null;
            filstrPROFILE="";
          }
        } else {
          if (LASTFILTERPROFILE!=null) {
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE FILTER SET FILTERVALUE='"+filstrPROFILE+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERPROFILEPICKRES'";
            sti2.executeUpdate(i2);
            sti2.close();
          } else {
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERPROFILEPICKRES','"+filstrPROFILE+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
        out.print("<tr><td bgcolor=#FFFFFF>");
        out.print("<table width=\"100%\"><tr>");
        out.print("<td bgcolor=#FFFFFF>");
        out.print("Name : </td><td><input name=\"SELECTFILTERNAME\" type=\"text\" size=\"50\" value=\""+filstrNAME+"\">");
        out.print("</td></tr>");
        out.print("<tr><td bgcolor=#FFFFFF>");
        out.print("Forname : </td><td><input name=\"SELECTFILTERFORNAME\" type=\"text\" size=\"50\" value=\""+filstrFORNAME+"\">");
        out.print("</td></tr>");
        out.print("<tr><td bgcolor=#FFFFFF>");
        out.print("Profile : </td><td><select name=\"SELECTFILTERPROFILE\">");
        out.print("<option>*** - ALL</option>");
        Statement STR15 = Conn.createStatement();
        String QR15 = "SELECT ID,NAME FROM PROFILE ORDER BY NAME";
        ResultSet R15 = STR15.executeQuery(QR15);
        while(R15.next()) {
          out.print("<option");
          if (filstrPROFILE.equals(R15.getString("ID")+" - "+R15.getString("NAME"))) {
            out.print(" selected ");
          }
          out.print(">"+R15.getString("ID")+" - "+R15.getString("NAME")+"</option>");
        }
        STR15.close();
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
          String idfilprofile = filstrPROFILE.substring(0,filstrPROFILE.indexOf("-")-1);
          if (!idfilprofile.equals("***")) {
            if (first) { 
               filterstatement = filterstatement + " (PROFILEID='"+idfilprofile+"' OR ID IN (SELECT EMPLOYEEID FROM EMPPRF WHERE PROFILEID='"+idfilprofile+"'))";
            } else {
               filterstatement = filterstatement + " AND ";
               filterstatement = filterstatement + " (PROFILEID='"+idfilprofile+"' OR ID IN (SELECT EMPLOYEEID FROM EMPPRF WHERE PROFILEID='"+idfilprofile+"'))";
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
        String q230 = "SELECT COUNT(ID) FROM EMPLOYEE WHERE "+filterstatement+" ID NOT IN (SELECT EMPLOYEEID FROM WORKON WHERE PROJECTID='"+PROJECTID+"')";
        ResultSet r230 = st230.executeQuery(q230);
        if (r230.next()) {    
          nbpage=r230.getInt("COUNT(ID)")/20;
        }
        st230.close();
        String NAME = "";
        out.print("<table><tr><td>Page : </td>");
        for (int i=0; i<=nbpage;i++) {
          out.print("<td><A HREF=\"pickresource.jsp?TODO=ADD&PAGE="+i+"&PROJECTID="+PROJECTID+"\">"+i+"</A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"5%\">&nbsp;</td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Project Resource</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Capacity</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Primary profile</center></td>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><center>Secondary profile(s)</center></td>");
        out.print("<td width=\"5%\">&nbsp;</td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME,FORNAME,PROFILEID FROM EMPLOYEE WHERE "+filterstatement+" ID NOT IN (SELECT EMPLOYEEID FROM WORKON WHERE PROJECTID='"+PROJECTID+"')";
        ResultSet R01 = STR01.executeQuery(QR01);
        int pagecount=0;
        while(R01.next()) {
          if (pagecount>=PAGE*20 && pagecount<(PAGE+1)*20) {
            out.print("<tr>");
            out.print("<td>&nbsp;</td>");
            out.print("<td bgcolor=\"#FFFFFF\"><A HREF=\"setresourcerequest.jsp?TODO=RESADD&EMPLOYEEID="+R01.getString("ID")+"&PROJECTID="+PROJECTID+"\">"+R01.getString("NAME")+" "+R01.getString("FORNAME")+"</td>");
            out.print("<td bgcolor=#FFFFFF><center><A HREF=\"#\" onclick=\"window.showModalDialog('listemployeeworkload.jsp?TODO=NONE&EMPLOYEEID="+R01.getString("ID")+"','','dialogHeight:400px;dialogWidth:800px;');\"><img border=0 src=\"icons/capacity.png\"></A></span></td>");
            Statement STR02 = Conn.createStatement();
            String QR02 = "SELECT ID,NAME FROM PROFILE WHERE ID='"+R01.getString("PROFILEID")+"'";
            ResultSet R02 = STR02.executeQuery(QR02);
            if (R02.next()) {
              out.print("<td bgcolor=\"#FFFFFF\">"+R02.getString("NAME")+"</td>");
            } else {
              out.print("<td bgcolor=\"#FFFFFF\">Not defined</td>");
            }
            STR02.close();
            Statement STR03 = Conn.createStatement();
            String QR03 = "SELECT ID,NAME FROM PROFILE WHERE ID IN (SELECT PROFILEID FROM EMPPRF WHERE EMPLOYEEID='"+R01.getString("ID")+"')";
            ResultSet R03 = STR03.executeQuery(QR03);
            out.print("<td bgcolor=\"#FFFFFF\">");
            while (R03.next()) {
              out.print(" "+R03.getString("NAME")+" ");
            }
            out.print("</td>");
            STR03.close();
            out.print("<td>&nbsp;</td>");
            out.print("<tr>");
          }
          pagecount++;
        }
        STR01.close();
        out.print("</table>");
        out.print("<A HREF=\"projectresources.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/cancel.png\"></A>");
        Conn.close();
      }

    %>
  </body>
</html>
