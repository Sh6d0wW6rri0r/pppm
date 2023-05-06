<html>

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
  <%@ page import = "java.util.HashMap" %>   
  <%@ page import = "java.util.Hashtable" %>  
  <%@ page import = "java.util.Map" %>   
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>
  <%@ page import = "fr.pppm.*" %>
  
  <body background="images/fond.gif">
    <%
      String POOLNAME=(String)session.getAttribute("POOLNAME");

      // database connection
      Context initCtx = new InitialContext();
      DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
      Connection Conn = ds.getConnection();
      PPPMTools pmt = new PPPMTools();
      // JSP parameterts
      String UserLogin = pmt.checkStr(request.getParameter("UserLogin"));
      String UserPassword = pmt.checkStr(request.getParameter("UserPassword"));
      
      User us = new User(Conn);
  
      
      session.setAttribute("ISLOCAL","YES");
      if (us.isAuthenticated(UserLogin,UserPassword)) {
        if (us.isDisabled(UserLogin)) {
          Calendar rn= Calendar.getInstance();
          int DDAY=rn.get(Calendar.DATE);
          int DMONTH=rn.get(Calendar.MONTH)+1;
          int DYEAR=rn.get(Calendar.YEAR);
          int DHOUR=rn.get(Calendar.HOUR);
          int DMINUTE=rn.get(Calendar.MINUTE);   
          int DAM_PM=rn.get(Calendar.AM_PM);
          Statement STU03 = Conn.createStatement();
          String QU03 = "INSERT INTO LOGS VALUES('"+UserLogin+"','','','"+DMONTH+"/"+DDAY+"/"+DYEAR+" - "+DHOUR+"."+DMINUTE+" ("+DAM_PM+")','LOGIN DISABLED')";
          STU03.executeUpdate(QU03);
          STU03.close();      
          session.setAttribute("ERROR_LOGIN","DISABLED");
        } else {
          session.setAttribute("LOGIN",UserLogin);
          Calendar rn= Calendar.getInstance();
          int DDAY=rn.get(Calendar.DATE);
          int DMONTH=rn.get(Calendar.MONTH)+1;
          int DYEAR=rn.get(Calendar.YEAR);
          int DHOUR=rn.get(Calendar.HOUR);
          int DMINUTE=rn.get(Calendar.MINUTE);   
          int DAM_PM=rn.get(Calendar.AM_PM);
          Statement STU03 = Conn.createStatement();
          String QU03 = "INSERT INTO LOGS VALUES('"+UserLogin+"','','','"+DMONTH+"/"+DDAY+"/"+DYEAR+" - "+DHOUR+"."+DMINUTE+" ("+DAM_PM+")','LOGIN SUCCESSFULL')";
          STU03.executeUpdate(QU03);
          STU03.close();      
        }
      } else {
        session.setAttribute("ERROR_LOGIN","NOLDAP");
      }
    response.sendRedirect("index.jsp");
    Conn.close();
  %>
  </body>
</html>
