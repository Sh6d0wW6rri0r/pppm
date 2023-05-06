<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>IT-REP v1.0 - IT Repository System</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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



<%String Userlogin = (String)session.getAttribute("LOGIN");
  if (Userlogin==null) {  
    out.print("<frameset rows=\"60,*\" frameborder=\"NO\" border=\"0\" framespacing=\"0\">");
    out.print("<frame src=\"menu_appli.jsp\" name=\"menuappliframe\" scrolling=\"NO\" noresize >");
    out.print("<frame src=\"login.jsp\" name=\"appliFrame\">");
    out.print("</frameset>");
    out.print("<noframes>");
  } else {
    out.print("<frameset rows=\"128,*\" frameborder=\"NO\" border=\"0\" framespacing=\"0\">");
    out.print("<frame src=\"menu_appli.jsp\" name=\"menuappliframe\" scrolling=\"NO\" noresize >");
    out.print("<frame src=\"accueil.jsp?TODO=NONE\" name=\"appliFrame\" scrolling=\"AUTO\">");
    out.print("</frameset>");
    out.print("<noframes>");
  }
%>
<body>

</body></noframes>
</html>
