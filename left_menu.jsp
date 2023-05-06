<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css">
html {
    overflow-y: scroll;
}
      body { color: black; font-family: arial; font-size: x-small}
      h1 { color: black; font-family: arial; font-size: medium}
      .menuonblack a { color: #FFFFFF; text-decoration: none; font-family: arial; font-size: 12px }
      .menuongrey a { color: #000000; text-decoration: none; font-family: arial; font-size: 12px }
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
  <%@ page import = "fr.pppm.*" %>

  <body bgcolor=#FFFFFF leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    <%
      // session attributes
      String Userlogin = (String)session.getAttribute("LOGIN");
      String POOLNAME=(String)session.getAttribute("POOLNAME");
      
      if (!(Userlogin==null)) {
        // database connection
        Context initCtx = new InitialContext();
        DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
        Connection Conn = ds.getConnection();

        // JSP parameters
        String act = request.getParameter("TODO");
        out.print("<table width=\"100%\" border=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">");
        out.print("<TR height=\"30\" bgcolor=#FFFFFF>");
        out.print("<td><center><img src=\"images/pppmorg.jpg\" height=42 width=150></center></td>");
        out.print("</tr>");
        out.print("</table>");
        out.print("<table width=\"100%\" border=\"0\" CELLSPACING=\"3\">");
        if (us.hasRole(Userlogin,"REQUEST")) {
          out.print("<tr HEIGHT=\"25\"><TD bgcolor=\"#8B17FF\"><font color=\"#FFFFFF\" size=2>Request</font></td></tr>");
          out.print("<tr HEIGHT=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"addrequest.jsp?TODO=ADD\" target=\"appliFrame\">New request</A></center></span></TD></tr>");
          out.print("<tr HEIGHT=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"request.jsp?TODO=NONE\" target=\"appliFrame\">Request list</A></center></span></TD></tr>");
        }
        if (us.hasRole(Userlogin,"PROJECT") ||us.hasRole(Userlogin,"PROGRAM") ||us.hasRole(Userlogin,"PRODUCT") ) {
          out.print("<tr HEIGHT=\"25\"><TD bgcolor=\"#8B17FF\"><font color=\"#FFFFFF\" size=2>Portfolio</font></td></tr>");
          if (us.hasRole(Userlogin,"PROJECT")) {
            out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\">Projects</A></center></span></TD></tr>");
          }
          if (us.hasRole(Userlogin,"PROGRAM")) {
            out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"program.jsp?TODO=NONE\" target=\"appliFrame\">Programs</A></center></span></TD></tr>");
          }
          if (us.hasRole(Userlogin,"PRODUCT")) {
            out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"productportfolio.jsp?TODO=NONE\" target=\"appliFrame\">Products</A></center></span></TD></tr>");
          }
          if (us.hasRole(Userlogin,"PORTCONF") || us.hasRole(Userlogin,"PRODUCTCONF")) {
            out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"portconfig.jsp?TODO=NONE\" target=\"appliFrame\">Configure</A></center></span></TD></tr>");
          }
        }
        if (us.hasRole(Userlogin,"RESOURCE")) {
          out.print("<tr HEIGHT=\"25\"><TD bgcolor=\"#8B17FF\"><font color=\"#FFFFFF\" size=2>Resources</font></td></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"resource.jsp?TODO=NONE\" target=\"appliFrame\">Manage resources</A></center></span></TD></tr>");
          if (us.hasRole(Userlogin,"RESCONF")) {
            out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"resconfig.jsp?TODO=NONE\" target=\"appliFrame\">Configure</A></center></span></TD></tr>");
          }
        }
        if (us.hasRole(Userlogin,"VENDOR")) {
          out.print("<tr HEIGHT=\"25\"><TD bgcolor=\"#8B17FF\"><font color=\"#FFFFFF\" size=2>Vendors</font></td></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"vendor.jsp?TODO=NONE\" target=\"appliFrame\">Vendors</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"audit.jsp?TODO=NONE\" target=\"appliFrame\">Audits</A></center></span></TD></tr>");
        }
        if (us.hasRole(Userlogin,"REPORTING")) {
          out.print("<tr HEIGHT=\"25\"><TD bgcolor=\"#8B17FF\"><font color=\"#FFFFFF\" size=2>Reports</font></td></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"createreport.jsp?TODO=NONE\" target=\"appliFrame\">New</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"reportcapacity.jsp?TODO=NONE\" target=\"appliFrame\">Capacity</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"reportpmogroup.jsp?TODO=NONE\" target=\"appliFrame\">PMO</A></center></span></TD></tr>");
        }
       if (true) {
          out.print("<tr HEIGHT=\"25\"><TD bgcolor=\"#8B17FF\"><font color=\"#FFFFFF\" size=2>CMDB</font></td></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/room.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Room</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/rack.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Rack</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/switch.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Switch</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/san.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">SAN</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/backup.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Backup</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/other.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Other</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/server.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Server</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/serverapp.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Software/Server</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/activity.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Activity</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/software.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Software</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/versions.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Versions</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/incident.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Software Incident</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/vendor.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Vendor / Contract Management</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/service.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Services</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/os.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">OS</A></center></span></TD></tr>");
        }

        if (us.hasRole(Userlogin,"ADMIN")) {
          out.print("<tr HEIGHT=\"25\"><TD bgcolor=\"#8B17FF\"><font color=\"#FFFFFF\" size=2>Admin</font></td></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"group.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Group mgt.</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"user.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">User mgt.</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminscoring.jsp?TODO=NONE\" target=\"appliFrame\">Scoring</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminstrategicinitiative.jsp?TODO=NONE\" target=\"appliFrame\">Stategic initiatives</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminlocation.jsp?TODO=NONE\" target=\"appliFrame\">Divs & Sites</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminorganization.jsp?TODO=NONE\" target=\"appliFrame\">Organization</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminemployee.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Employee</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"admincmdbtype.jsp?TODO=NONE\" target=\"appliFrame\">CMDB types</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminrecurringactivity.jsp?TODO=NONE\" target=\"appliFrame\">Recurring activities</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminphasetemplate.jsp?TODO=NONE\" target=\"appliFrame\">Phase templates</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"vendor.jsp?TODO=NONE\" target=\"appliFrame\">Vendor</A></center></span></TD></tr>");
          out.print("<tr height=\"15\"><TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"logs.jsp?TODO=NONE\" target=\"appliFrame\">Access Logs</A></center></span></TD></tr>");
        }
        out.print("</table>");
        Conn.close();
      }
    %>
  </body>
</html>
