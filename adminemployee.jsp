
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
        String pagtmp = request.getParameter("PAGE");
        int currentpage = Integer.parseInt(pagtmp);
      	PPPMTools pt = new PPPMTools();
        if (act.equals("ADD")) {
          String CONTRACTOR="N";
          if (request.getParameter("CONTRACTOR")!=null) {
            CONTRACTOR = "Y";
          }
          String profileidtmp = request.getParameter("PROFILEID");
          String PROFILEID = profileidtmp.substring(0,profileidtmp.indexOf("-")-1);
          Statement st1230 = Conn.createStatement();
          String q1230 = "SELECT RATE FROM PROFILE WHERE ID='"+PROFILEID+"'";
          ResultSet r1230 = st1230.executeQuery(q1230);
          String rate="0";
          if (r1230.next()) {
            rate=""+r1230.getInt("RATE");
          }
          st1230.close();
          Employee emp= new Employee(Conn);
          emp.setName(pt.checkStr(request.getParameter("NAME")));
          emp.setForname(pt.checkStr(request.getParameter("FORNAME")));
          emp.setOuid(pt.checkStr(request.getParameter("OUID")));
          emp.setContractor(CONTRACTOR);
          emp.setSiteid(pt.checkStr(request.getParameter("SITEID")));
          emp.setProfileid(PROFILEID);
          emp.setSkill(0);
          emp.setCapacity("160");
          emp.setRate(rate);
        }
        if (act.equals("MOD")) {
          String EID=request.getParameter("EID");
          Employee emp = new Employee(Conn,EID);          
          String CONTRACTOR="N";
          if (request.getParameter("CONTRACTOR")!=null) {
            CONTRACTOR = "Y";
          }
          String profileidtmp = request.getParameter("PROFILEID");
          String PROFILEID = profileidtmp.substring(0,profileidtmp.indexOf("-")-1);
          emp.setName(pt.checkStr(request.getParameter("NAME")));
          emp.setForname(pt.checkStr(request.getParameter("FORNAME")));
          emp.setOuid(pt.checkStr(request.getParameter("OUID")));
          emp.setContractor(CONTRACTOR);
          emp.setSiteid(pt.checkStr(request.getParameter("SITEID")));
          emp.setProfileid(PROFILEID);
          emp.setCapacity(request.getParameter("CAPACITY"));
          emp.setRate(request.getParameter("RATE"));
        }
        out.print("<center><strong><h1>Employee management</h1></strong></center><hr>");
        out.print("<Table><tr><td>You are here : Administration \\ Manage employee</td><td><A HREF=\"adminemployee.jsp?TODO=NONE&PAGE="+currentpage+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Employees</strong></h2></center></td>");
        EmployeeList empl = new EmployeeList(Conn,"SELECT ID FROM EMPLOYEE");   
        int nbpage=empl.length()/10;

        out.print("<td><A HREF=\"addemployee.jsp?TODO=ADD&PAGE="+currentpage+"\"><img border=0 src=\"icons/addsmall.png\"></A></td><td>Page : </td>");
        for (int i=0; i<=nbpage;i++) {
          out.print("<td><A HREF=\"adminemployee.jsp?TODO=NONE&PAGE="+i+"\">"+i+"</A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Forname</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>OU</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Contractor</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Site</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Profile</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Skill</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Capacity</center></td>");
        out.print("</tr>");
        empl.refresh();
        int nbrow = 0;
        while(nbrow<empl.length()) {
          if (nbrow >= currentpage*10 && nbrow <(currentpage+1)*10) {
            out.print("<tr>");
            out.print("<td bgcolor=#FFFFFF><center><table><tr><td>"+empl.getEmployeeItem(nbrow).getId()+"</td><td><td><A HREF=\"addemployee.jsp?TODO=MOD&EID="+empl.getEmployeeItem(nbrow).getId()+"&PAGE="+currentpage+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
            out.print("<td bgcolor=#FFFFFF><center>"+empl.getEmployeeItem(nbrow).getName()+"</center></td>");
            out.print("<td bgcolor=#FFFFFF><center>"+empl.getEmployeeItem(nbrow).getForname()+"</center></td>");
            out.print("<td bgcolor=#FFFFFF><center>"+empl.getEmployeeItem(nbrow).getOuid()+"</center></td>");
            out.print("<td bgcolor=#FFFFFF><center>"+empl.getEmployeeItem(nbrow).getContractor()+"</center></td>");
            out.print("<td bgcolor=#FFFFFF><center>"+empl.getEmployeeItem(nbrow).getSiteid()+"</center></td>");
            out.print("<td bgcolor=#FFFFFF><center>"+empl.getEmployeeItem(nbrow).getProfileid()+"</center></td>");
            out.print("<td bgcolor=#FFFFFF><center>"+empl.getEmployeeItem(nbrow).getSkill()+"</center></td>");
            out.print("<td bgcolor=#FFFFFF><center>"+empl.getEmployeeItem(nbrow).getCapacity()+"</center></td>");
            out.print("</tr>");
          }
          nbrow++;
        }
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
