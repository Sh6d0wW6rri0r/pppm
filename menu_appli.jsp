<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: x-small}
      h1 { color: white; font-family: arial; font-size: large}
      .menuonblack a { color: #FFFFFF; text-decoration: none; font-family: arial; font-size: 12px }
      .menuongrey a { color: #000000; text-decoration: none; font-family: arial; font-size: 12px }
      .submenuonblack a { color: #FFFFFF; text-decoration: none; font-family: arial; font-size: 10px }
      .bigonblack a { color: #FFFFFF; text-decoration: none; font-family: arial; font-size: 14px }
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
  <script language="JavaScript" src="javascript/showmodaldialog.js"></script>
    <script>
    function showModalADDREQUEST()
    {
    	window.showModalDialog('addrequest.jsp?TODO=ADD','','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='request.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalADDAPPLICATION()
    {
    	window.showModalDialog('addapplication.jsp?TODO=ADD','','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='applicationportfolio.jsp?TODO=NONE';
    }
    </script>

  <%
    // session attributes
    String Userlogin = (String)session.getAttribute("LOGIN");
    String POOLNAME=(String)session.getAttribute("POOLNAME");
      // database connection
    Context initCtx = new InitialContext();
    DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
    Connection Conn = ds.getConnection();
      // JSP parameters
    String act = request.getParameter("TODO");
    boolean req = false;
    boolean portfolio = false;
    boolean resource = false;
    boolean vendor = false;
    boolean cmdb = true;
    boolean service = true;
    boolean apm = true;
    boolean reporting = false;
    boolean admin=false;
    if (Userlogin==null) {
    } else {
      User us = new User(Conn);
      if (us.hasRole(Userlogin,"REQUEST")) {
        req=true;
      }
      if (us.hasRole(Userlogin,"PROJECT") ||us.hasRole(Userlogin,"PROGRAM") ||us.hasRole(Userlogin,"PRODUCT")) {
         portfolio=true;
      }
      if (us.hasRole(Userlogin,"RESOURCE")) {
         resource=true;
      }
      if (us.hasRole(Userlogin,"VENDOR")) {
        vendor= true;
      }             
      if (us.hasRole(Userlogin,"CMDB")) {
        cmdb = true;
      }             
      if (us.hasRole(Userlogin,"APPLICATION")) {
        apm = true;
      } 
      if (us.hasRole(Userlogin,"REPORTING")) {
        reporting = true;
      }      
      if (us.hasRole(Userlogin,"ADMIN")) {
        admin = true;
      }      

      int fa = 0;
      if (act==null) {
        if (req) { 
          fa=0;
        } else {
          if (portfolio) {
            fa=1;
          } else {
            if (resource) {
              fa=2;
            } else {
              if (vendor) {
                fa=3;
              } else {
                if (cmdb) {
                  fa=4;
                } else {
                  if (service) {
                    fa=5;
                  } else {
                    if (apm) {
                      fa=6;
                    } else {
                      if (reporting) {
                        fa=7;
                      }
                    }
                  }
                }
              }              
            }
          }
        }
        act=""+fa;
      }
      out.print("<table width=\"100%\" border=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">");
      out.print("<TR height=\"50\">");
      out.print("<td background=\"images/banner.jpg\" width=\"100%\" height=\"50\"><H1>&nbsp&nbsp&nbspPPPM.ORG</H1></td>");      
      out.print("</td></tr></table>");
      out.print("<table width=\"100%\" border=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">");
      out.print("<tr height=\"25\">");
      if (req) { 
        out.print("<td width=\"12%\"");
        if (act.equals("0")) {
          out.print(" bgcolor=\"#8B17FF\"> <span class=\"menuonblack\"");
        } else {
          out.print(" bgcolor=\"#EEEEEE\"> <span class=\"menuongrey\" ");
        }
        out.print("><center><A HREF=\"menu_appli.jsp?TODO=0\" target=\"menuappliframe\"><strong>Requests</strong></A></center></span></td>"); 
      }
      if (portfolio) {
        out.print("<td width=\"12%\"");
        if (act.equals("1")) {
          out.print(" bgcolor=\"#8B17FF\"> <span class=\"menuonblack\"");
        } else {
          out.print(" bgcolor=\"#EEEEEE\"> <span class=\"menuongrey\" ");
        }
        out.print("><center><A HREF=\"menu_appli.jsp?TODO=1\" target=\"menuappliframe\"><strong>Portfolios</strong></A></center></span></td>");
      }
      if (resource) {
        out.print("<td width=\"12%\"");
        if (act.equals("2")) {
          out.print(" bgcolor=\"#8B17FF\"> <span class=\"menuonblack\"");
        } else {
          out.print(" bgcolor=\"#EEEEEE\"> <span class=\"menuongrey\" ");
        }
        out.print("><center><A HREF=\"menu_appli.jsp?TODO=2\" target=\"menuappliframe\"><strong>Resources</strong></A></center></span></td>");
      }
      if (vendor) {
        out.print("<td width=\"12%\"");
        if (act.equals("3")) {
          out.print(" bgcolor=\"#8B17FF\"> <span class=\"menuonblack\"");
        } else {
          out.print(" bgcolor=\"#EEEEEE\"> <span class=\"menuongrey\" ");
        }
        out.print("><center><A HREF=\"menu_appli.jsp?TODO=3\" target=\"menuappliframe\"><strong>Vendors</strong></A></center></span></td>");
      }
      if (cmdb) {
        out.print("<td width=\"12%\"");
        if (act.equals("4")) {
          out.print(" bgcolor=\"#8B17FF\"> <span class=\"menuonblack\"");
        } else {
          out.print(" bgcolor=\"#EEEEEE\"> <span class=\"menuongrey\" ");
        }
        out.print("><center><A HREF=\"menu_appli.jsp?TODO=4\" target=\"menuappliframe\"><strong>CMDB</strong></A></center></span></td>");
      }    
      if (apm) {
        out.print("<td width=\"12%\"");
        if (act.equals("5")) {
          out.print(" bgcolor=\"#8B17FF\"> <span class=\"menuonblack\"");
        } else {
          out.print(" bgcolor=\"#EEEEEE\"> <span class=\"menuongrey\" ");
        }
        out.print("><center><A HREF=\"menu_appli.jsp?TODO=5\" target=\"menuappliframe\"><strong>Applications</strong></A></center></span></td>");
      }   
      if (reporting) {
        out.print("<td width=\"12%\"");
        if (act.equals("6")) {
          out.print(" bgcolor=\"#8B17FF\"> <span class=\"menuonblack\"");
        } else {
          out.print(" bgcolor=\"#EEEEEE\"> <span class=\"menuongrey\" ");
        }
        out.print("><center><A HREF=\"menu_appli.jsp?TODO=6\" target=\"menuappliframe\"><strong>Reporting</strong></A></center></span></td>");
      }
      if (admin) {
        out.print("<td width=\"12%\"");
        if (act.equals("7")) {
          out.print(" bgcolor=\"#8B17FF\"> <span class=\"menuonblack\"");
        } else {
          out.print(" bgcolor=\"#EEEEEE\"> <span class=\"menuongrey\" ");
        }
        out.print("><center><A HREF=\"menu_appli.jsp?TODO=7\" target=\"menuappliframe\"><strong>Admin.</strong></A></center></span></td>");
      }
      out.print("</tr>");
      out.print("</table>");
      out.print("<table width=\"100%\" border=\"0\" CELLSPACING=\"0\">");
      out.print("<TR height=\"20\">");
      if (act.equals("0")) {
        out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"#\" onclick=\"showModalADDREQUEST();\">New request</A></center></span></TD>");
        out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"request.jsp?TODO=NONE\" target=\"appliFrame\">Request list</A></center></span></TD>");       
      } 
      if (act.equals("1")) {
        if (us.hasRole(Userlogin,"PROJECT")) {
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\">Projects</A></center></span></TD>");
        }
        if (us.hasRole(Userlogin,"PROGRAM")) {
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"program.jsp?TODO=NONE\" target=\"appliFrame\">Programs</A></center></span></TD>");
        }
        if (us.hasRole(Userlogin,"PRODUCT")) {
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"productportfolio.jsp?TODO=NONE\" target=\"appliFrame\">Products</A></center></span></TD>");
        }
        if (us.hasRole(Userlogin,"PORTCONF") || us.hasRole(Userlogin,"PRODUCTCONF")) {
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"portconfig.jsp?TODO=NONE\" target=\"appliFrame\">Configure</A></center></span></TD>");
        }
      }
      if (act.equals("2")) {
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"resource.jsp?TODO=NONE\" target=\"appliFrame\">Manage resources</A></center></span></TD>");
          if (us.hasRole(Userlogin,"RESCONF")) {
            out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"resconfig.jsp?TODO=NONE\" target=\"appliFrame\">Configure</A></center></span></TD>");
          }      }
      if (act.equals("3")) {
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"vendor.jsp?TODO=NONE\" target=\"appliFrame\">Vendors</A></center></span></TD>");
      }
      if (act.equals("4")) {
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/room.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Room</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/rack.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Rack</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/switch.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Switch</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/san.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">SAN</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/backup.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Backup</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/other.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Other</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/server.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Server</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/os.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">OS</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/software.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Software</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/versions.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Versions</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/serverapp.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Software/Server</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/activity.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Activity</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"cmdb/incident.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Software Incident</A></center></span></TD>");
      }
      if (act.equals("5")) {
        out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"#\" onclick=\"showModalADDAPPLICATION();\">New application</A></center></span></TD>");
      	out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"applicationportfolio.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Portfolio</A></center></span></TD>");
      }
      if (act.equals("6")) {
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"reportcustom.jsp?TODO=NONE\" target=\"appliFrame\">Custom</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"reportcapacity.jsp?TODO=NONE\" target=\"appliFrame\">Capacity</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"reportpmogroup.jsp?TODO=NONE\" target=\"appliFrame\">PMO</A></center></span></TD>");
      }

      if (act.equals("7")) {
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"group.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Group mgt.</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"user.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">User mgt.</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminscoring.jsp?TODO=NONE\" target=\"appliFrame\">Scoring</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminstrategicinitiative.jsp?TODO=NONE\" target=\"appliFrame\">Stategic initiatives</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminlocation.jsp?TODO=NONE\" target=\"appliFrame\">Divs & Sites</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminorganization.jsp?TODO=NONE\" target=\"appliFrame\">Organization</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminemployee.jsp?TODO=NONE&PAGE=0\" target=\"appliFrame\">Employee</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"admincmdbtype.jsp?TODO=NONE\" target=\"appliFrame\">CMDB types</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminrecurringactivity.jsp?TODO=NONE\" target=\"appliFrame\">Recurring activities</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"adminphasetemplate.jsp?TODO=NONE\" target=\"appliFrame\">Phase templates</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"vendor.jsp?TODO=NONE\" target=\"appliFrame\">Vendor</A></center></span></TD>");
          out.print("<TD bgcolor=\"#FFFFFF\"><center><span class=\"menuongrey\"><A HREF=\"logs.jsp?TODO=NONE\" target=\"appliFrame\">Access Logs</A></center></span></TD>");
      }                               
      out.print("</TR>");
      out.print("</table><hr>");
    }
    Conn.close();
  %>
  </body>
</html>
