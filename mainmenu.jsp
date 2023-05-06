
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>

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
  <%@ page import = "java.text.DateFormat" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>
  
  <body>
      <script language="JavaScript" src="javascript/showmodaldialog.js"></script>
      <script>
      function showModalADDREQUEST()
      {
        window.showModalDialog('/pppm/addrequest.jsp?TODO=ADD','','dialogHeight:400px;dialogWidth:800px;');
          top.appliFrame.location='/pppm/request.jsp?TODO=NONE';
      }
      </script>
      <script>
      function showModalADDAPPLICATION()
      {
        window.showModalDialog('/pppm/addapplication.jsp?TODO=ADD','','dialogHeight:400px;dialogWidth:800px;');
          top.appliFrame.location='/pppm/applicationportfolio.jsp?TODO=NONE';
      }
      </script>
  <%
  out.print("<div class=\"navbar\">");
        out.print("<a href=\"/pppm/index.jsp\">Home</a>");
        out.print("<div class=\"dropdown\">");
          out.print("<button class=\"dropbtn\" onclick=\"showRequestdropdown()\" id=\"RequestDropdownButton\">Request&nbsp&nbsp");
            out.print("<i class=\"fa fa-caret-down\"></i>");
          out.print("</button>");
          out.print("<div class=\"dropdown-content\" id=\"RequestDropdown\">");
            out.print("<a href=\"#\" onclick=\"showModalADDREQUEST()\">New request</a>");
            out.print("<a href=\"/pppm/request.jsp?TODO=NONE\">Request list</a>");
          out.print("</div>");
        out.print("</div>"); 
        out.print("<div class=\"dropdown\">");
          out.print("<button class=\"dropbtn\" onclick=\"showPortfoliodropdown()\" id=\"PortfolioDropdownButton\">Portfolio&nbsp&nbsp");
            out.print("<i class=\"fa fa-caret-down\"></i>");
          out.print("</button>");
          out.print("<div class=\"dropdown-content\" id=\"PortfolioDropdown\">");
            out.print("<a href=\"/pppm/portfolio.jsp?TODO=NONE\">Project</a>");
            out.print("<a href=\"/pppm/program.jsp?TODO=NONE\">Program</a>");
            out.print("<a href=\"/pppm/productportfolio.jsp?TODO=NONE\">Product</a>");
            out.print("<a href=\"/pppm/portconfig.jsp?TODO=NONE\">Configure</a>");                  
          out.print("</div>");
        out.print("</div>"); 
        out.print("<div class=\"dropdown\">");
          out.print("<button class=\"dropbtn\" onclick=\"showResourcesdropdown()\" id=\"ResourcesDropdownButton\">Resources&nbsp&nbsp");
            out.print("<i class=\"fa fa-caret-down\"></i>");
          out.print("</button>");
          out.print("<div class=\"dropdown-content\" id=\"ResourcesDropdown\">");
            out.print("<a href=\"/pppm/resource.jsp?TODO=NONE\">Manage</a>");
            out.print("<a href=\"/pppm/resconfig.jsp?TODO=NONE\">Configure</a>");
          out.print("</div>");
        out.print("</div>"); 
        out.print("<div class=\"dropdown\">");
          out.print("<button class=\"dropbtn\" onclick=\"showVendorsdropdown()\" id=\"VendorsDropdownButton\">Vendors&nbsp&nbsp");
            out.print("<i class=\"fa fa-caret-down\"></i>");
          out.print("</button>");
          out.print("<div class=\"dropdown-content\" id=\"VendorsDropdown\">");
            out.print("<a href=\"/pppm/vendor.jsp?TODO=NONE\">Manage</a>");
          out.print("</div>");
        out.print("</div>"); 
        out.print("<div class=\"dropdown\">");
          out.print("<button class=\"dropbtn\" onclick=\"showCMDBdropdown()\" id=\"CMDBDropdownButton\">CMDB&nbsp&nbsp");
            out.print("<i class=\"fa fa-caret-down\"></i>");
          out.print("</button>");
          out.print("<div class=\"dropdown-content\" id=\"CMDBDropdown\">");
            out.print("<a href=\"/pppm/cmdb/room.jsp?TODO=none\">Room</a>");
            out.print("<a href=\"/pppm/cmdb/rack.jsp?TODO=none\">Rack</a>");
            out.print("<a href=\"/pppm/cmdb/switch.jsp?TODO=none\">Switch</a>");
            out.print("<a href=\"/pppm/cmdb/san.jsp?TODO=none\">SAN</a>");
            out.print("<a href=\"/pppm/cmdb/backup.jsp?TODO=none\">Backup</a>");
            out.print("<a href=\"/pppm/cmdb/other.jsp?TODO=none\">Other</a>");
            out.print("<a href=\"/pppm/cmdb/server.jsp?TODO=none\">Server</a>");
            out.print("<a href=\"/pppm/cmdb/os.jsp?TODO=none\">OS</a>");
            out.print("<a href=\"/pppm/cmdb/software.jsp?TODO=none\">Software</a>");
            out.print("<a href=\"/pppm/cmdb/versions.jsp?TODO=none\">Versions</a>");
            out.print("<a href=\"/pppm/cmdb/serverapp.jsp?TODO=none\">Installations</a>");
            out.print("<a href=\"/pppm/cmdb/activity.jsp?TODO=none\">Activity</a>");
            out.print("<a href=\"/pppm/cmdb/incident.jsp?TODO=none\">Incident</a>");
          out.print("</div>");
        out.print("</div>"); 
        out.print("<div class=\"dropdown\">");
          out.print("<button class=\"dropbtn\" onclick=\"showApplicationsdropdown()\" id=\"ApplicationsDropdownButton\">Applications&nbsp&nbsp");
            out.print("<i class=\"fa fa-caret-down\"></i>");
          out.print("</button>");
          out.print("<div class=\"dropdown-content\" id=\"ApplicationsDropdown\">");
            out.print("<a href=\"#\" onclick=\"showModalADDAPPLICATION()\">New</a>");
            out.print("<a href=\"/pppm/applicationportfolio.jsp?TODO=NONE\">Portfolio</a>");
          out.print("</div>");
        out.print("</div>"); 
        out.print("<div class=\"dropdown\">");
          out.print("<button class=\"dropbtn\" onclick=\"showReportingdropdown()\" id=\"ReportingDropdownButton\">Reporting&nbsp&nbsp");
            out.print("<i class=\"fa fa-caret-down\"></i>");
          out.print("</button>");
          out.print("<div class=\"dropdown-content\" id=\"ReportingDropdown\">");
            out.print("<a href=\"/pppm/reportcustom.jsp?TODO=NONE\">Custom</a>");
            out.print("<a href=\"/pppm/reportcapacity.jsp?TODO=NONE\">Capacity</a>");
            out.print("<a href=\"/pppm/reportpmogroup.jsp?TODO=NONE\">PMO</a>");                    
          out.print("</div>");
        out.print("</div>"); 
        out.print("<div class=\"dropdown\">");
          out.print("<button class=\"dropbtn\" onclick=\"showAdmindropdown()\" id=\"AdminDropdownButton\">Admin&nbsp&nbsp");
            out.print("<i class=\"fa fa-caret-down\"></i>");
          out.print("</button>");
          out.print("<div class=\"dropdown-content\" id=\"AdminDropdown\">");
            out.print("<a href=\"/pppm/group.jsp?TODO=NONE&PAGE=0\">Group</a>");
            out.print("<a href=\"/pppm/user.jsp?TODO=NONE&PAGE=0\">User</a>");
            out.print("<a href=\"/pppm/adminscoring.jsp?TODO=NONE\">Scoring</a>");                    
            out.print("<a href=\"/pppm/adminstrategicinitiative.jsp?TODO=NONE\">Strategy</a>");
            out.print("<a href=\"/pppm/adminlocation.jsp?TODO=NONE\">Divisions and Sites</a>");
            out.print("<a href=\"/pppm/adminorganization.jsp?TODO=NONE\">Organization</a>");
            out.print("<a href=\"/pppm/adminemployee.jsp?TODO=NONE&PAGE=0\">Employees</a>");
            out.print("<a href=\"/pppm/admincmdbtype.jsp?TODO=NONE\">CMDB</a>");
            out.print("<a href=\"/pppm/adminrecurringactivity.jsp?TODO=NONE\">Activity</a>");
            out.print("<a href=\"/pppm/adminphasetemplate.jsp?TODO=NONE\">Project phases</a>");
            out.print("<a href=\"/pppm/logs.jsp?TODO=NONE\">Logs</a>");                    
          out.print("</div>");
        out.print("</div>");     
      out.print("</div>");    
      out.print("<script>");
      out.print("function showRequestdropdown() {");
        out.print("document.getElementById(\"RequestDropdown\").classList.toggle(\"show\");");
      out.print("}");
      out.print("function showPortfoliodropdown() {");
        out.print("document.getElementById(\"PortfolioDropdown\").classList.toggle(\"show\");");
      out.print("}");
      out.print("function showResourcesdropdown() {");
        out.print("document.getElementById(\"ResourcesDropdown\").classList.toggle(\"show\");");
      out.print("}");
      out.print("function showVendorsdropdown() {");
        out.print("document.getElementById(\"VendorsDropdown\").classList.toggle(\"show\");");
      out.print("}");
      out.print("function showCMDBdropdown() {");
        out.print("document.getElementById(\"CMDBDropdown\").classList.toggle(\"show\");");
      out.print("}");
      out.print("function showApplicationsdropdown() {");
        out.print("document.getElementById(\"ApplicationsDropdown\").classList.toggle(\"show\");");
      out.print("}");
      out.print("function showReportingdropdown() {");
        out.print("document.getElementById(\"ReportingDropdown\").classList.toggle(\"show\");");
      out.print("}");
      out.print("function showAdmindropdown() {");
        out.print("document.getElementById(\"AdminDropdown\").classList.toggle(\"show\");");
      out.print("}");
      out.print("window.onclick = function(e) {");
        out.print("if (e.target.id!='RequestDropdownButton') {");
          out.print("var myDropdown = document.getElementById(\"RequestDropdown\");");
          out.print("if (myDropdown.classList.contains('show')) {");
            out.print("myDropdown.classList.remove('show');");
          out.print("}");
        out.print("}");
        out.print("if (e.target.id!='PortfolioDropdownButton') {");
          out.print("var myDropdown = document.getElementById(\"PortfolioDropdown\");");
          out.print("if (myDropdown.classList.contains('show')) {");
            out.print("myDropdown.classList.remove('show');");
          out.print("}");
        out.print("}");
        out.print("if (e.target.id!='ResourcesDropdownButton') {");
          out.print("var myDropdown = document.getElementById(\"ResourcesDropdown\");");
          out.print("if (myDropdown.classList.contains('show')) {");
            out.print("myDropdown.classList.remove('show');");
          out.print("}");
        out.print("}");
        out.print("if (e.target.id!='VendorsDropdownButton') {");
          out.print("var myDropdown = document.getElementById(\"VendorsDropdown\");");
          out.print("if (myDropdown.classList.contains('show')) {");
            out.print("myDropdown.classList.remove('show');");
          out.print("}");
        out.print("}");
        out.print("if (e.target.id!='CMDBDropdownButton') {");
          out.print("var myDropdown = document.getElementById(\"CMDBDropdown\");");
          out.print("if (myDropdown.classList.contains('show')) {");
            out.print("myDropdown.classList.remove('show');");
          out.print("}");
        out.print("}");
        out.print("if (e.target.id!='ApplicationsDropdownButton') {");
          out.print("var myDropdown = document.getElementById(\"ApplicationsDropdown\");");
          out.print("if (myDropdown.classList.contains('show')) {");
            out.print("myDropdown.classList.remove('show');");
          out.print("}");
        out.print("}");
        out.print("if (e.target.id!='ReportingDropdownButton') {");
          out.print("var myDropdown = document.getElementById(\"ReportingDropdown\");");
          out.print("if (myDropdown.classList.contains('show')) {");
            out.print("myDropdown.classList.remove('show');");
          out.print("}");
        out.print("}");
        out.print("if (e.target.id!='AdminDropdownButton') {");
          out.print("var myDropdown = document.getElementById(\"AdminDropdown\");");
          out.print("if (myDropdown.classList.contains('show')) {");
            out.print("myDropdown.classList.remove('show');");
          out.print("}");
        out.print("}");
      out.print("}");
      out.print("</script>");
  %>
</body>
</html>

