<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css"> 
body { color: black; font-family: arial; font-size: 12px}
h1 { color: black; font-family: arial; font-size: 18px}
.onblack a { color: #FFFFFF; text-decoration: none; font-family: arial; font-size: 18px }
.ongrey a { color: #000000; text-decoration: none; font-family: arial; font-size: 18px }
.subonblack a { color: #FFFFFF; text-decoration: none; font-family: arial; font-size: 14px }
.bigonblack a { color: #FFFFFF; text-decoration: none; font-size: 20px }

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



<body bgcolor=#FFFFFF leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<% String Userlogin = (String)session.getAttribute("LOGIN");
   String UserADM = "YES";
   String UserROLE = (String)session.getAttribute("ROLE");
   String act = request.getParameter("TODO");
   if (act==null) {
     act="1";
   }
   if (Userlogin==null) {
     out.print("<table width=\"100%\" border=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">");
     out.print("<TR height=\"60\" bgcolor=#8FA9C4>");
     out.print("<td style=\"background-repeat: no-repeat;\" background=\"itrep/images/bandeau.jpg\" width=\"100%\"><span class=\"bigonblack\"><A HREF=\"index.jsp\">IT Repository System</a></span></td>");
     out.print("</tr>");
     out.print("</table>");
   } else {
     out.print("<table width=\"100%\" border=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">");
     out.print("<TR height=\"60\" bgcolor=#8FA9C4>");
     out.print("<td style=\"background-repeat: no-repeat;\" background=\"itrep/images/bandeau.jpg\" width=\"100%\"><span class=\"bigonblack\"><A HREF=\"index.jsp\">IT Repository System</a></span></td>");
     out.print("</tr>");
     out.print("</table>");
     out.print("<table width=\"100%\" border=\"0\" CELLSPACING=\"0\" CELLPADDING=\"0\">" );
       out.print("<TR height=\"38\">");
       out.print("<td width=\"16%\"");
       if (act.equals("1")) {
         out.print(" background=\"images/fond_menu_haut_noir.jpg\"> <span class=\"onblack\"");
       } else {
         out.print(" background=\"images/fond_menu_haut_gris.jpg\"> <span class=\"ongrey\" ");
       }
       out.print("><center><A HREF=\"menu_appli.jsp?TODO=1\" target=\"menuappliframe\">Facilities</A></center></span></td>");
       out.print("<td width=\"16%\"");
       if (act.equals("2")) {
         out.print(" background=\"images/fond_menu_haut_noir.jpg\"> <span class=\"onblack\"");
       } else {
         out.print(" background=\"images/fond_menu_haut_gris.jpg\"> <span class=\"ongrey\" ");
       }
       out.print("><center><A HREF=\"menu_appli.jsp?TODO=2\" target=\"menuappliframe\">Server</A></center></span></td>");
       out.print("<td width=\"16%\"");
       if (act.equals("3")) {
         out.print(" background=\"images/fond_menu_haut_noir.jpg\"> <span class=\"onblack\"");
       } else {
         out.print(" background=\"images/fond_menu_haut_gris.jpg\"> <span class=\"ongrey\" ");
       }
       out.print("><center><A HREF=\"menu_appli.jsp?TODO=3\" target=\"menuappliframe\">Software</A></center></span></td>");
       out.print("<td width=\"16%\"");
       if (act.equals("4")) {
         out.print(" background=\"images/fond_menu_haut_noir.jpg\"> <span class=\"onblack\"");
       } else {
         out.print(" background=\"images/fond_menu_haut_gris.jpg\"> <span class=\"ongrey\" ");
       }
       out.print("><center><A HREF=\"menu_appli.jsp?TODO=4\" target=\"menuappliframe\">Backups</A></center></span></td>");
       out.print("<td width=\"16%\"");
       if (act.equals("5")) {
         out.print(" background=\"images/fond_menu_haut_noir.jpg\"> <span class=\"onblack\"");
       } else {
         out.print(" background=\"images/fond_menu_haut_gris.jpg\"> <span class=\"ongrey\" ");
       }
       out.print("><center><A HREF=\"menu_appli.jsp?TODO=5\" target=\"menuappliframe\">Management</A></center></span></td>");
       if (UserADM.equals("YES")) {
         out.print("<td width=\"16%\"");
         if (act.equals("6")) {
           out.print(" background=\"images/fond_menu_haut_noir.jpg\"> <span class=\"onblack\"");
         } else {
           out.print(" background=\"images/fond_menu_haut_gris.jpg\"> <span class=\"ongrey\" ");
         }
         out.print("><center><A HREF=\"menu_appli.jsp?TODO=6\" target=\"menuappliframe\">Administrator</A></center></span></td>");
       }
       out.print("</tr>");
     out.print("</table>");
     out.print("<table width=\"100%\" border=\"0\" CELLSPACING=\"0\">");
       out.print("<TR height=\"30\">");
       if (act.equals("1")) {
         out.print("<TD width=\"16%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"room.jsp?TODO=NONE\" target=\"appliFrame\">Room</A></center></span></TD>");
         out.print("<TD width=\"16%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"rack.jsp?TODO=NONE\" target=\"appliFrame\">Rack</A></center></span></TD>");
         out.print("<TD width=\"16%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"switch.jsp?TODO=NONE\" target=\"appliFrame\">Switch</A></center></span></TD>");
         out.print("<TD width=\"16%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"san.jsp?TODO=NONE\" target=\"appliFrame\">San</A></center></span></TD>");
         out.print("<TD width=\"16%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"backup.jsp?TODO=NONE\" target=\"appliFrame\">Backup</A></center></span></TD>");
         out.print("<TD width=\"16%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"other.jsp?TODO=NONE\" target=\"appliFrame\">Other</A></center></span></TD>");
         out.print("<script language=\"JavaScript\">");
         out.print("top.appliFrame.location='accueil.jsp';");
         out.print("</script>");
       }
       if (act.equals("2")) {
         out.print("<TD width=\"33%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"server.jsp?TODO=NONE\" target=\"appliFrame\">Server</A></center></span></TD>");
         out.print("<TD width=\"33%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"serverapp.jsp?TODO=NONE\" target=\"appliFrame\">Software/Server</A></center></span></TD>");
         out.print("<TD width=\"33%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"activity.jsp?TODO=NONE\" target=\"appliFrame\">Activity</A></center></span></TD>");
         out.print("<script language=\"JavaScript\">");
         out.print("top.appliFrame.location='accueil.jsp';");
         out.print("</script>");
       }
       if (act.equals("3")) {
         out.print("<TD width=\"20%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"software.jsp?TODO=NONE\" target=\"appliFrame\">Software</A></center></span></TD>");
         out.print("<TD width=\"20%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"versions.jsp?TODO=NONE\" target=\"appliFrame\">Versions</A></center></span></TD>");
         out.print("<TD width=\"20%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"documents.jsp?TODO=NONE\" target=\"appliFrame\">Documents</A></center></span></TD>");
         out.print("<TD width=\"20%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"appserver.jsp?TODO=NONE\" target=\"appliFrame\">Installed server</A></center></span></TD>");
         out.print("<TD width=\"20%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"incident.jsp?TODO=NONE\" target=\"appliFrame\">Knowledge Base</A></center></span></TD>");
         out.print("<script language=\"JavaScript\">");
         out.print("top.appliFrame.location='accueil.jsp';");
         out.print("</script>");
       }
       if (act.equals("4")) {
         out.print("<TD width=\"50%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"chkbackup.jsp?TODO=NONE\" target=\"appliFrame\">Check Backups</A></center></span></TD>");
         out.print("<TD width=\"50%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"appbackup.jsp?TODO=NONE\" target=\"appliFrame\">Backups History</A></center></span></TD>");
         out.print("<script language=\"JavaScript\">");
         out.print("top.appliFrame.location='accueil.jsp';");
         out.print("</script>");
       }
       if (act.equals("5")) {
         out.print("<TD width=\"33%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"vendor.jsp?TODO=NONE\" target=\"appliFrame\">Vendor/contract management</A></center></span></TD>");
         out.print("<TD width=\"33%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"service.jsp?TODO=NONE\" target=\"appliFrame\">Services</A></center></span></TD>");
         out.print("<TD width=\"33%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"os.jsp?TODO=NONE\" target=\"appliFrame\">Operating Systems</A></center></span></TD>");
         out.print("<script language=\"JavaScript\">");
         out.print("top.appliFrame.location='accueil.jsp';");
         out.print("</script>");
       }
       if (act.equals("6")) {
         out.print("<TD width=\"50%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"user.jsp?TODO=NONE\" target=\"appliFrame\">User management</A></center></span></TD>");
         out.print("<TD width=\"50%\" background=\"images/fond_menu_bas_noir.jpg\"><center><span class=\"subonblack\"><A HREF=\"delete.jsp?TODO=NONE\" target=\"appliFrame\">Delete request</A></center></span></TD>");
         out.print("<script language=\"JavaScript\">");
         out.print("top.appliFrame.location='accueil.jsp';");
         out.print("</script>");
       }
       out.print("</TR>");
     out.print("</table>");
   }
%>
<body>

</body></noframes>

</body>
</html>
