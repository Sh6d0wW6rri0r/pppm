
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css"> 
body { color: black; font-family: arial; font-size: 12px}
h1 { color: black; font-family: arial; font-size: 18px}

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



<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "javax.mail.*" %>
<%@ page import = "javax.mail.internet.*" %>
<%@ page import = "java.util.*" %> 
<%@ page import="javax.activation.*" %>
<%@ page import = "java.util.HashMap" %>   
<%@ page import = "java.util.Hashtable" %>  
<%@ page import = "java.util.Map" %>   
<%@ page import = "javax.naming.Context" %>   
<%@ page import = "javax.naming.NamingEnumeration" %>   
<%@ page import = "javax.naming.NamingException" %>   
<%@ page import = "javax.naming.directory.Attribute" %>   
<%@ page import = "javax.naming.directory.Attributes" %>   
<%@ page import = "javax.naming.directory.SearchControls" %>   
<%@ page import = "javax.naming.directory.SearchResult" %>   
<%@ page import = "javax.naming.ldap.InitialLdapContext" %> 
<%@ page import = "javax.naming.ldap.LdapContext" %>

<%!String checkstr(String str) {
  String insertok="";
  for (int it=0; it <str.length();it++) {
    if ((str.charAt(it)>='a') && (str.charAt(it)<='z')) {
      insertok=insertok+str.charAt(it);
    }
    if ((str.charAt(it)>='A') && (str.charAt(it)<='Z')) {
      insertok=insertok+str.charAt(it);
    }
    if ((str.charAt(it)>='0') && (str.charAt(it)<='9')) {
      insertok=insertok+str.charAt(it);
    }
    if ((str.charAt(it)==' ')) {
      insertok=insertok+" ";
    } 
    if ((str.charAt(it)=='\n')) {
      insertok=insertok+"\\\n";
    } 
    if ((str.charAt(it)=='\'')) {
      insertok=insertok+"''";
    }
    if ((str.charAt(it)=='�')) {
      insertok=insertok+"&agrave;";
    }
    if ((str.charAt(it)=='�')) {
      insertok=insertok+"&eacute;";
    }
    if ((str.charAt(it)=='�')) {
      insertok=insertok+"&egrave;";
    }
    if ((str.charAt(it)=='�')) {
      insertok=insertok+"&ugrave;";
    }
    if ((str.charAt(it)=='�')) {
      insertok=insertok+"&ocirc;";
    }
    if ((str.charAt(it)=='�')) {
      insertok=insertok+"&ecirc;";
    }
    if ((str.charAt(it)=='�')) {
      insertok=insertok+"&euro;";
    }
    if ((str.charAt(it)=='�')) {
      insertok=insertok+"&ccedil;";
    }
    if ((str.charAt(it)=='&')) {
      insertok=insertok+"&amp;";
    }
    if ((str.charAt(it)=='\"')) {
      insertok=insertok+"&quot;";
    }
    if ((str.charAt(it)=='\\')) {
      insertok=insertok+"\\";
    }
    if ((str.charAt(it)=='$')) {
      insertok=insertok+"$";
    }
    if ((str.charAt(it)=='*')) {
      insertok=insertok+"*";
    }
    if ((str.charAt(it)=='%')) {
      insertok=insertok+"%";
    }
    if ((str.charAt(it)=='/')) {
      insertok=insertok+"/";
    }
    if ((str.charAt(it)=='.')) {
      insertok=insertok+".";
    }
    if ((str.charAt(it)=='?')) {
      insertok=insertok+"?";
    }
    if ((str.charAt(it)==',')) {
      insertok=insertok+",";
    }
    if ((str.charAt(it)==';')) {
      insertok=insertok+";";
    }
    if ((str.charAt(it)==':')) {
      insertok=insertok+":";
    }
    if ((str.charAt(it)=='!')) {
      insertok=insertok+"!";
    }
    if ((str.charAt(it)=='|')) {
      insertok=insertok+"|";
    }
    if ((str.charAt(it)=='{')) {
      insertok=insertok+"{";
    }
    if ((str.charAt(it)=='}')) {
      insertok=insertok+"}";
    }
    if ((str.charAt(it)=='(')) {
      insertok=insertok+"(";
    }
    if ((str.charAt(it)==')')) {
      insertok=insertok+")";
    }
    if ((str.charAt(it)=='[')) {
      insertok=insertok+"{";
    }
    if ((str.charAt(it)==']')) {
      insertok=insertok+"}";
    }
    if ((str.charAt(it)=='~')) {
      insertok=insertok+"~";
    }
    if ((str.charAt(it)=='#')) {
      insertok=insertok+"#";
    }
    if ((str.charAt(it)=='=')) {
      insertok=insertok+"=";
    }
    if ((str.charAt(it)=='@')) {
      insertok=insertok+"@";
    }
    if ((str.charAt(it)=='-')) {
      insertok=insertok+"-";
    }
    if ((str.charAt(it)=='_')) {
      insertok=insertok+"_";
    }
    if ((str.charAt(it)=='<')) {
      insertok=insertok+"&lt;";
    }
    if ((str.charAt(it)=='>')) {
      insertok=insertok+"&gt;";
    }
  }
  return insertok;
}
%>
<body background="images/comp023.gif">

<%String Userlogin = (String)session.getAttribute("LOGIN");
  Connection Conn = (Connection)session.getAttribute("DBConnection");
  String act = request.getParameter("TODO");
  String ID = request.getParameter("ID");
  String STEP = request.getParameter("STEP");


  Calendar trnb = Calendar.getInstance();
  String TTD=(trnb.get(Calendar.MONTH)+1)+"/"+trnb.get(Calendar.DAY_OF_MONTH)+"/"+trnb.get(Calendar.YEAR);
  Statement st30 = Conn.createStatement();
  String q30 = "SELECT * FROM BACKUP_CHECK WHERE (DATATAPE='N' or DATAGEN='N') AND BCKDATE='"+TTD+"' ORDER BY SOFTWAREID ";
  ResultSet r30 = st30.executeQuery(q30);
  int nbreason=0;
  while(r30.next()) {
    if (request.getParameter("REASON"+r30.getString("SOFTWAREID"))!=null) {
      if (request.getParameter("REASON"+r30.getString("SOFTWAREID")).equals("NONE") ||request.getParameter("REASON"+r30.getString("SOFTWAREID")).equals("")) {
        nbreason++;
      } else {
        Statement sti2 = Conn.createStatement();
        String i2 = "UPDATE BACKUP_CHECK SET REASON='"+checkstr(request.getParameter("REASON"+r30.getString("SOFTWAREID")))+"' WHERE SOFTWAREID='"+r30.getString("SOFTWAREID")+"' AND BCKDATE='"+TTD+"'";
        sti2.executeUpdate(i2);
        sti2.close();
      }
    } else {
      nbreason++;
    }
  }
  st30.close();
  if (nbreason>0) {
    out.print("<script language=\"JavaScript\">");
    out.print("top.appliFrame.location='reasonbck.jsp?TODO=ERRORFILL';");
    out.print("</script>");
  }


  out.print("<center><strong><h1>Do you approve the Backup check ?</h1></strong></center><hr>");

  out.print("<form name=\"formFILTER\" method=\"post\" action=\"chkbackup.jsp?TODO=DEF\" target=\"appliFrame\">");

  out.print("<link href=\"substancesCSS.css\" rel=\"stylesheet\" type=\"text/css\">");
  out.print("<p>&nbsp;</p>");
  out.print("<p align=\"center\">&nbsp;</p>");
  out.print("<div align=\"center\">");
  out.print("<table width=\"60%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\">");
  out.print("<tr>");
  out.print("<td background=\"fond_windows.gif\">");
  out.print("<p align=\"center\">Please enter your password to sign your decision.</p>");
  out.print("<table width=\"80%\" border=\"0\" align=\"center\">");  
  out.print("<tr>");
  out.print("<td width=\"40%\">Login :</td>");
  out.print("<td width=\"60%\">"+Userlogin+"</td></tr>");  
  out.print("<tr>");
  out.print("<td>Password:</td>");
  out.print("<td><input type=\"password\" name=\"UserPassword\"></td>");
  out.print("</tr>");
  out.print("<tr>");
  out.print("<td>&nbsp;</td>");
  out.print("<td>&nbsp;</td>");
  out.print("</tr>");
  out.print("</table>");
  out.print("</td>");
  out.print("</tr>");
  out.print("</table>");
  out.print("</div>");
  out.print("<br>");

  out.print("<center><input type=\"submit\" name=\"Save\" value=\"I approve\"></center>");
  out.print("</form>");



%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
