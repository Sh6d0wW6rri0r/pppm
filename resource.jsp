
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
    function showModalCAPACITY(reqstr)
    {
    	window.showModalDialog('resourcecapacity.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='resource.jsp?TODO=NONE';
    }
    </script>
          <script>
    function showModalPROFILE(reqstr)
    {
    	window.showModalDialog('resourceprofile.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='resource.jsp?TODO=NONE';
    }
    </script>
          <script>
    function showModalDAYOFF(reqstr)
    {
    	window.showModalDialog('resourcecalendar.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='resource.jsp?TODO=NONE';
    }
    </script>
          <script>
    function showModalREQUEST(reqstr)
    {
    	window.showModalDialog('resourcerequest.jsp?TODO=NONE&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='resource.jsp?TODO=NONE';
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
              	out.print("<center><strong><h1>Resources(s)</h1></strong></center><br>");

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
                out.print("<form name=\"formFILTER\" method=\"post\" action=\"resource.jsp?TODO=FILTER&FILTER=FILTER\" target=\"appliFrame\">");
                PPMFilter filterengine = new PPMFilter(Conn);
                String LASTFILTERTEAMRESOURCE=filterengine.getFilterValue("LASTFILTERTEAMRESOURCE",Userlogin);
                String filter = request.getParameter("FILTER");
                String filterstatement ="";
                String filstrTEAM=request.getParameter("SELECTFILTERTEAM");
                if (filstrTEAM==null) {
                  if (LASTFILTERTEAMRESOURCE!=null) {
                    filter="FILTER";
                    filstrTEAM=LASTFILTERTEAMRESOURCE;
                  } else {
                    filter=null;
                    filstrTEAM="*** - ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERTEAMRESOURCE",Userlogin,filstrTEAM);
                }
                out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
                out.print("<tr><td>");
                out.print("<table width=\"100%\" CELLSPACING=\"0\"><tr>");
                out.print("<td bgcolor=\"#FFFFFF\">");
                out.print("Team : <select name=\"SELECTFILTERTEAM\">");
                out.print("<option>*** - ALL</option>");
                out.print("<option");
                if (filstrTEAM.equals("ORG - My hierarchical team")) {
                  out.print(" selected ");
                }
                out.print(">ORG - My hierarchical team</option>");
                Statement st22 = Conn.createStatement();
                String q22 = "SELECT ID,NAME FROM TEAM WHERE ID IN (select TEAMID FROM EMPTM WHERE EMPLOYEEID='"+Userlogin+"')  ORDER BY NAME";
                ResultSet r22 = st22.executeQuery(q22);
                while(r22.next()) {
                  out.print("<option");
                  if (filstrTEAM.equals(r22.getString("ID")+" - "+r22.getString("NAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+r22.getString("ID")+" - "+r22.getString("NAME")+"</option>");
                }
                st22.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=\"#FFFFFF\"><center>");
                out.print("<input type=\"image\" border=0 src=\"icons/search.png\" name=\"filter\" value=\"submit\"></center>");
                out.print("</td>");
                out.print("</tr></table>");
                out.print("</td>");
                out.print("</tr></table>");
                out.print("<br>");
                out.print("</form>");
                boolean first=true;
                boolean hastoreduce = true;
                if (filter!= null) {
                  String idfilTEAM = filstrTEAM.substring(0,filstrTEAM.indexOf("-")-1);
                  if (idfilTEAM.equals("ORG")) {
                    filterstatement= "WHERE OUID IN (SELECT ID FROM OU WHERE EMPLOYEEID='"+Userlogin+"')";
                    hastoreduce=false;
                  } else {
                    if (!idfilTEAM.equals("***")) {
                      if (!first) {
                        filterstatement = filterstatement + " AND ";
                      } else {
                        filterstatement = " WHERE " ;
                      }
                      filterstatement = filterstatement + "ID in (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID='"+idfilTEAM+"')";
                      first = false;
                    } else {
                      hastoreduce=false;
                      if (!first) {
                        filterstatement = filterstatement + " AND ";
                      } else {
                        filterstatement = " WHERE " ;
                      }
                      filterstatement = filterstatement + "OUID IN (SELECT ID FROM OU WHERE EMPLOYEEID='"+Userlogin+"') OR ID in (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID IN (SELECT TEAMID FROM EMPTM WHERE EMPLOYEEID='"+Userlogin+"'))";
                      first = false;
                    }           
                  }
                }
                if (hastoreduce) {
                  if (!first) {
                    filterstatement = filterstatement + " AND ";
                  } else {
                    filterstatement = " WHERE " ;
                  }
                  filterstatement = filterstatement + "ID in (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID IN (SELECT TEAMID FROM EMPTM WHERE EMPLOYEEID='"+Userlogin+"') OR TEAMID IN (SELECT TEAMID FROM GRPTM WHERE GROUPID IN (SELECT GROUPID FROM GROUP_USER WHERE LOGIN='"+Userlogin+"')) )";
                }
                out.print("<table><tr><td><h2><strong>Resource(s)</strong></h2></center></td></tr></table>");
                out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
                out.print("<tr height=\"20\">");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"30%\"><center><A HREF=\"resource.jsp?TODO=SORT&FIELD=NAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Name</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"25%\"><center><A HREF=\"resource.jsp?TODO=SORT&FIELD=FORNAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Forname</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Capacity</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Profile(s)</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Day(s) off</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Request(s)</center></td>");
                out.print("</tr>");
                Statement st30 = Conn.createStatement();
                String q30 = "SELECT * FROM EMPLOYEE "+filterstatement+" ORDER BY "+COLTOSORT+" "+DIRSORT;
                ResultSet r30 = st30.executeQuery(q30);
                while(r30.next()) {
                  out.print("<tr height=15>");
                  out.print("<td bgcolor=#FFFFFF><center>&nbsp;"+r30.getString("NAME")+"</center></td>");
                  out.print("<td bgcolor=#FFFFFF><center>&nbsp;"+r30.getString("FORNAME")+"</center></td>");
                  out.print("<td bgcolor=#FFFFFF><center><A HREF=\"#\" onclick=\"showModalCAPACITY('EMPLOYEEID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/capacitysmall.png\" height=15></A></center></td>");
                  Statement st31 = Conn.createStatement();
                  String q31 = "SELECT PROFILEID FROM EMPPRF WHERE EMPLOYEEID='"+r30.getString("ID")+"'";
                  ResultSet r31 = st31.executeQuery(q31);
                  int nbprf=0;
                  while(r31.next()) {
                    nbprf++;
                  }
                  st31.close();
                  out.print("<td bgcolor=#FFFFFF><center>"+nbprf+"<A HREF=\"#\" onclick=\"showModalPROFILE('EMPLOYEEID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/profilesmall.png\" height=15></A></center></td>");
                  st31 = Conn.createStatement();
                  q31 = "SELECT COUNT(DAYOFF) FROM HOLLIDAY WHERE EMPLOYEEID='"+r30.getString("ID")+"'";
                  r31 = st31.executeQuery(q31);
                  int nbdoff=0;
                  if(r31.next()) {
                    nbdoff=r31.getInt("COUNT(DAYOFF)");
                  }
                  st31.close();
                  out.print("<td bgcolor=#FFFFFF><center>"+nbdoff+"<A HREF=\"#\" onclick=\"showModalDAYOFF('EMPLOYEEID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/calendarsmall.png\" height=15></A></center></td>");
                  st31 = Conn.createStatement();
                  q31 = "SELECT PROJECTID FROM RESOURCE_USER_ACTIVITY WHERE EMPLOYEEID='"+r30.getString("ID")+"' AND APPROVED='NO'";
                  r31 = st31.executeQuery(q31);
                  int nbreq=0;
                  while(r31.next()) {
                    nbreq++;
                  }
                  st31.close();
                  out.print("<td bgcolor=#FFFFFF><center>"+nbreq+"<A HREF=\"#\" onclick=\"showModalREQUEST('EMPLOYEEID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/requestsmall.png\" height=15></A></center></td>");
                  out.print("</tr>");
                }
                st30.close();
                out.print("</table>");
                Conn.close();
              } 

    %>
  </body>
</html>
