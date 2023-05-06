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
  
<body background="fond_appli.jpg">
<%

//Creating Database Instanse
Connection Conn = null;
if (session.getAttribute("DBConnection")==null) {
      Context initCtx = new InitialContext();
      DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/PPPMORGPOOL");
      Conn = ds.getConnection();
      session.setAttribute("DBConnection", Conn);


} else {
  Conn = (Connection)session.getAttribute("DBConnection");
}

String UserLogin = request.getParameter("UserLogin");
String UserPassword = request.getParameter("UserPassword");

       
 Statement stmt2 = Conn.createStatement();
    String query2 = "SELECT * FROM USERS WHERE LOGIN='"+UserLogin+"'";
    ResultSet rs2 = stmt2.executeQuery(query2);
    boolean is_auth_local = false;
    String UserRole = "";
    String UserADM = "";
    String UserDIS = "";
    if (rs2.next()) {
        if (UserPassword.equals(rs2.getString("PWD"))) {
          is_auth_local=true;
        }
        session.setAttribute("LOGIN",UserLogin);
    }
    stmt2.close();
          
  response.sendRedirect("index.jsp");
%>

</body>
</html>
