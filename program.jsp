
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
  <%@ page import = "fr.pppm.*" %>

  <body>
      <script>
    function showModalPROGRAMDETAILS(reqstr)
    {
    	window.showModalDialog('programdetails.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='program.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROGRAMBUDGET(reqstr)
    {
    	window.showModalDialog('programbudget.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='program.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROGRAMPLANNING(reqstr)
    {
    	window.showModalDialog('programplanning.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='program.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROGRAMRISK(reqstr)
    {
    	window.showModalDialog('programrisk.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='program.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROGRAMRESOURCES(reqstr)
    {
    	window.showModalDialog('programresources.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='program.jsp?TODO=NONE';
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
                PPPMTools pt = new PPPMTools();

                // database connection
                Context initCtx = new InitialContext();
                DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
                Connection Conn = ds.getConnection();

                // JSP parameters
                String act = request.getParameter("TODO");
              	out.print("<center><strong><h1>Program(s)</h1></strong></center><br>");
                String COLTOSORT = "ID";
                String DIRSORT = "ASC";
                if (act.equals("SORT")) {
                  if (request.getParameter("FIELD").equals(request.getParameter("OLDFIELD"))) {
                    COLTOSORT=request.getParameter("FIELD");
                    if (request.getParameter("OLDDIR").equals("ASC")) {
                      DIRSORT="DESC";
                    } else {
                      DIRSORT="ASC";
                    }
                  } else {
                    COLTOSORT=request.getParameter("FIELD");
                    DIRSORT="ASC";
                  }
                }
                out.print("<form name=\"formFILTER\" method=\"post\" action=\"program.jsp?TODO=FILTER&FILTER=FILTER\" target=\"appliFrame\">");
                PPMFilter filterengine = new PPMFilter(Conn);
                String LASTFILTERBPO=filterengine.getFilterValue("LASTFILTERBPOPORTFOLIO",Userlogin);
                String LASTFILTERPM=filterengine.getFilterValue("LASTFILTERPMPORTFOLIO",Userlogin);
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
                  filterengine.setFilterValue("LASTFILTERBPOPORTFOLIO",Userlogin,filstrBPO);
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
                  filterengine.setFilterValue("LASTFILTERPMPORTFOLIO",Userlogin,filstrPM);
                }
                out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
                out.print("<tr><td bgcolor=#FFFFFF>");
                out.print("<table width=\"100%\"><tr>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("BPO : </td><td bgcolor=#FFFFFF><select name=\"SELECTFILTERBPO\">");
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
                out.print("Program Manager : </td><td bgcolor=#FFFFFF><select name=\"SELECTFILTERPM\">");
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
                out.print("<td width=40>");
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
                if (!first) {
                  filterstatement = filterstatement + " AND STATUS<>'REQUEST'";
                } else {
                  filterstatement = " WHERE STATUS<>'REQUEST'";
                }
                User us = new User(Conn);
                out.print("<table><tr><td><h2><strong>Program(s)</strong></h2></center></td></tr></table>");
                out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
                out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"20\">");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center><A HREF=\"program.jsp?TODO=SORT&FIELD=NAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Name</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"9%\"><center>Attributes</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Score</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"9%\"><center>Status</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"9%\"><center>Budget</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"9%\"><center>Planning</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"9%\"><center>Risks</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"9%\"><center>Resources</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"9%\"><center>START</td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"9%\"><center>END</center></td>");
                out.print("</tr>");
                Statement st30 = Conn.createStatement();
                String q30 = "SELECT * FROM PROGRAM "+filterstatement+" ORDER BY "+COLTOSORT+" "+DIRSORT;
                ResultSet r30 = st30.executeQuery(q30);
                boolean paire=false;
                while(r30.next()) {
                  if (us.hasProgramAccess(Userlogin,r30.getString("ID"))) {
                    out.print("<tr height=15>");
                    if (r30.getString("NAME").equals("")) {
                      out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
                    } else {
                      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r30.getString("NAME")+"</center></td>");
                    }        
                    String RO="NO";
                    if (r30.getString("CLOSED").equals("Y")) {
                      RO="YES";
                    }
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROGRAMDETAILS('PROGRAMID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/attributes.png\" height=15></A></center></td>");
                    Statement st31 = Conn.createStatement();
                    String q31 = "SELECT ID,SCORE FROM PROJECT WHERE ID IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+r30.getString("ID")+"')";
                    ResultSet r31 = st31.executeQuery(q31);
                    int maxscore=0;
                    while(r31.next()) {
                      if (r31.getInt("SCORE")>maxscore) {
                        maxscore=r31.getInt("SCORE");
                      }
                    }
                    st31.close();
                    out.print("<td bgcolor=\"#FFFFFF\"><center>"+maxscore+"</center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><img border=0 src=\"icons/status.png\" height=15></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROGRAMBUDGET('PROGRAMID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/financials.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROGRAMPLANNING('PROGRAMID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/planning.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROGRAMRISK('PROGRAMID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/risks.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROGRAMRESOURCES('PROGRAMID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/resources.png\" height=15></A></center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r30.getString("DATE_START")+"</center></td>");
                    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r30.getString("DATE_END")+"</center></td>");
                    out.print("</tr>");
                  }
                }
                st30.close();
                out.print("</table>");
                Conn.close();
              } 

    %>
  </body>
</html>
