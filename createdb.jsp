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
      String POOLNAME="PPPMPOOL";
      Boolean dberror = false;
      // database connection
      Connection Conn = null;
      try {
      Context initCtx = new InitialContext();
      DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
      Conn = ds.getConnection();
      } catch (Exception e) {
        out.print("The database is not accessible, have you properly setup Tomcat server and create the database ?");
        dberror=true;
      }
      PPPMTools pmt = new PPPMTools();
      // JSP parameterts
      
      if(!dberror) {
        Statement STU03 = Conn.createStatement();
        String QU03= "";
        out.print("<br>Removing exiting PPM tables ...");
        try {
          QU03="DROP TABLE USERS";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE GROUPS";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE GROUP_USER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE GROUP_RIGHT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE FILTER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROJECT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATION";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE DIVISION";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE LOGS";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE LOCATION";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJDIV";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJLOC";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRDDIV";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRDLOC";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPDIV";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLOC";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE EMPLOYEE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJBPO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJPM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRDBPO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRDPM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPBPO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPPM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE OU";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROJECT_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROJECT_ACTIVITY_WORKLOAD";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROJECT_ACTIVITY_LINK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_BUDGET";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_EXPENSE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_ACTIVITY_LINK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATION_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATION_BUDGET";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATION_EXPENSE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATION_ACTIVITY_LINK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_RESOURCE_USER_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_RESOURCE_PROFILE_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_ACTIVITY_WORKLOAD";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE INDX";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE RESOURCE_USER_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE RESOURCE_PROFILE_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROFILE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE TIMESHEET";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PHASE_TEMPLATE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PHASE_TEMPLATE_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE STRATEGICINITIATIVE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJSI";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRDSI";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPSI";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATIONTYPE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJAT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE INFRASTRUCTURETYPE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJIT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE FOWNER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE SCORING_QUESTION";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE SCORING_QUESTION_ANSWER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJANS";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE SCORING_GROUP";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE SCORING_GROUP_PORTFOLIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROJECT_RISK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROJECT_RISK_ACTION";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_RISK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_RISK_ACTION";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATION_RISK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATION_RISK_ACTION";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROGRAM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJPGM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PORTFOLIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRJPOR";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRDPOR";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPPOR";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PGMPOR";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE USRPOR";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE GRPPOR";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE GRPTM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PGMBPO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PGMPM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE TEAM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE RESTM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE EMPTM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE EMPPRF";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE EMPREC";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE RECURRING";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROJECT_BUDGET";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROJECT_EXPENSE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE USER_RIGHT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE EMPLOYEE_RECURRING_WORKLOAD";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROJECT_HEALTH";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE HEALTH_QUESTION";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE HEALTH_ANSWER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE BASELINE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE BASELINE_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROGRAM_BASELINE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PROGRAM_BASELINE_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_BASELINE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE PRODUCT_BASELINE_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATION_BASELINE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE APPLICATION_BASELINE_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE VENDOR";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE VENDOR_CONTACT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE VENDOR_AUDIT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE WEEK_DAY_OFF";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE OTHER_DAY_OFF";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE HOLLIDAY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE SKILL";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE RIGHTLIST";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE REPORT_TABLES";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE REPORT_TABLES_FIELDS";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CUSTOM_REPORT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CUSTOM_REPORT_FIELDS";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        out.print("<br>PPM Tables removed.");
        out.print("<br>Removing existing CMDB tables...");
        try {
          QU03="DROP TABLE CMDB_SOFTWARE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SOFTWARE_VERSION";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SOFTWARE_INSTANCE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SOFTWARE_INCIDENT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER_MEMORY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER_DISK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER_PROC";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER_NETWORK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER_ACTIVITY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER_POWER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER_SAN";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_FIBERCABLE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER_FIBER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try { 
          QU03="DROP TABLE CMDB_BACKUP_CHECK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_RACK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_ROOM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_VENDOR_CONTRACT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_OS";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SP";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVICE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SERVER_SERVICE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SWITCH";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SWITCH_POWER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_BACKUP";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_BACKUP_POWER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_BACKUP_NETWORK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_OTHER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_OTHER_POWER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_OTHER_NETWORK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SAN";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SAN_NETWORK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SAN_POWER";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SAN_DISK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_SAN_VOLUME";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_NETCABLE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_POWERCABLE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_PDU";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE CMDB_PLUG";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        out.print("<br>CMDB Tables removed.");
        out.print("<br>Removing ESTIMATION tables ...");
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_STRUCTURE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_TYPE";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_PLANNING_FEEDBACK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_EXECUTION_FEEDBACK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_MANAGEMENT_FEEDBACK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_DEPL_FEEDBACK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_TRAIN_FEEDBACK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_RISK_RATIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_PLANNING_RATIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_EXECUTION_RATIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_MANAGEMENT_RATIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_DEPL_RATIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_CLOSE_RATIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_TRAIN_RATIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_TECHNOLOGY_TASK";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_TECHNOLOGY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_TECHNOLOGY";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_DEPLOYMENT";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }

        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_TRAINING";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }

        try {
          QU03="DROP TABLE ESTIMATION_TECHNOLOGY_TASK_RATIO";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        try {
          QU03="DROP TABLE ESTIMATION_PROJECT_REQUIREMENTS";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
        }
        out.print("<br>ESTIMATION Tables removed.");
        out.print("<br>Creating PPPM tables ...");
        try {
          QU03="CREATE TABLE USERS(LOGIN char(20),NAME char(50),FORNAME char(30),LDAPLOGIN char(40),DISABLED char(20),MAIL char(200),PWD char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : USERS");
        }
        try {
          QU03="CREATE INDEX LOGIN_INDX on USERS (LOGIN)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : USERS");
        }
        try {
          QU03="CREATE TABLE GROUPS(ID char(20), NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : GROUPS");
        }
        try {
          QU03="CREATE INDEX GROUPS_INDX on GROUPS(ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : GROUPS");
        }
        try {
          QU03="CREATE TABLE GROUP_USER(GROUPID char(20),LOGIN char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : GROUP_USER");
        }
        try {
          QU03="CREATE INDEX GROUPUSER_INDX on GROUP_USER(GROUPID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : GROUP_USER");
        }
        try {
          QU03="CREATE INDEX GROUPUSERBIS_INDX on GROUP_USER(LOGIN)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : GROUP_USER");
        }
        try {
          QU03="CREATE TABLE GROUP_RIGHT(GROUPID char(20),USERRIGHT char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : GROUP_RIGHT");
        }
        try {
          QU03="CREATE INDEX GROUPRIGHT_INDX on GROUP_RIGHT(GROUPID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : GROUP_RIGHT");
        }
        try {
          QU03="CREATE TABLE USER_RIGHT(LOGIN char(20),USERRIGHT char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : USER_RIGHT");
        }
        try {
          QU03="CREATE INDEX RIGHTS_INDX on USER_RIGHT (LOGIN)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : USER_RIGHT");
        }
        try {
          QU03="CREATE TABLE PROJECT(ID char(20),NAME char(254),DESCRIPTION text,SCORE int,FOWNERID char(20),DATE_START date,DATE_END date,STATUS char(50),CAPACITYTRIANGLE char(1),ONHOLD char(1),CLOSED char(1),TEMPLATE char(50),SCORING_GROUPID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT");
        }
        try {
          QU03="CREATE INDEX PROJECT_INDX on PROJECT (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT");
        }
        try {
          QU03="CREATE TABLE PRODUCT(ID char(20),NAME char(254),DESCRIPTION text,SCORE int,FOWNERID char(20),DATE_START date,DATE_END date,STATUS char(50),CLOSED char(1),SCORING_GROUPID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT");
        }
        try {
          QU03="CREATE INDEX PRODUCT_INDX on PRODUCT (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT");
        }
        try {
          QU03="CREATE TABLE APPLICATION(ID char(20),NAME char(254),DESCRIPTION text,SCORE int,FOWNERID char(20),DATE_START date,DATE_END date,STATUS char(50),CLOSED char(1),SCORING_GROUPID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPLICATION");
        }
        try {
          QU03="CREATE INDEX APPLICATION_INDX on APPLICATION (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION");
        }
        try {
          QU03="CREATE TABLE PROGRAM(ID char(20),NAME char(254),DESCRIPTION text,FOWNERID char(20),DATE_START date,DATE_END date,STATUS char(50),CLOSED char(1))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROGRAM");
        }
        try {
          QU03="CREATE INDEX PROGRAM_INDX on PROGRAM (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROGRAM");
        }
        try {
          QU03="CREATE TABLE VENDOR(ID char(20), NAME char(254), ADDRESS text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : VENDOR");
        } 
        try {
          QU03="CREATE INDEX VENDOR_INDX on VENDOR (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : VENDOR");
        }
        try {
          QU03="CREATE TABLE VENDOR_CONTACT(VENDORID char(20),ID int,NAME char(50),FORNAME char(50),ADDRESS text,MAIL char(254),PHONE char(50),MOBILE char(50),TITLE char(254),DESCRIPTION text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : VENDOR_CONTACT");
        }
        try {
          QU03="CREATE INDEX VENDOR_CONTACT_INDX on VENDOR_CONTACT (VENDORID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : VENDOR_CONTACT");
        }
        try {
          QU03="CREATE TABLE VENDOR_AUDIT(VENDORID char(20), ID int, DATEAUDIT date,COMMENT text, RESULT char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : VENDOR_AUDIT");
        }
        try {
          QU03="CREATE INDEX VENDOR_AUDIT_INDX on VENDOR_AUDIT (VENDORID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : VENDOR_AUDIT");
        }
        try {
          QU03="CREATE TABLE PRJPGM(PROJECTID char(20),PROGRAMID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRJPGM");
        }
        try {
          QU03="CREATE INDEX PRJPGM_INDX on PRJPGM (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJPGM");
        }
        try {
          QU03="CREATE INDEX PRJPGMBIS_INDX on PRJPGM (PROGRAMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJPGM");
        }
        try {
          QU03="CREATE TABLE PORTFOLIO (ID char(20),NAME char(254), DESCRIPTION text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PORTFOLIO");
        }
        try {
          QU03="CREATE INDEX PORTFOLIO_INDX on PORTFOLIO (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PORTFOLIO");
        }
        try {
          QU03="CREATE TABLE PRJPOR(PROJECTID char(20),PORTFOLIOID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRJPOR");
        }
        try {
          QU03="CREATE INDEX PRJPOR_INDX on PRJPOR (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJPOR");
        }
        try {
          QU03="CREATE INDEX PRJPORBIS_INDX on PRJPOR (PORTFOLIOID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJPOR");
        }
        try {
          QU03="CREATE TABLE PRDPOR(PRODUCTID char(20),PORTFOLIOID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRDPOR");
        }
        try {
          QU03="CREATE INDEX PRDPOR_INDX on PRDPOR (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDPOR");
        }
        try {
          QU03="CREATE INDEX PRDPORBIS_INDX on PRDPOR (PORTFOLIOID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDPOR");
        }
        try {
          QU03="CREATE TABLE APPPOR(APPLICATIONID char(20),PORTFOLIOID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPPOR");
        }
        try {
          QU03="CREATE INDEX APPPOR_INDX on APPPOR (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPPOR");
        }
        try {
          QU03="CREATE INDEX APPPORBIS_INDX on APPPOR (PORTFOLIOID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPPOR");
        }        
        try {
          QU03="CREATE TABLE PGMPOR(PROGRAMID char(20),PORTFOLIOID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PGMPOR");
        }
        try {
          QU03="CREATE INDEX PGMPOR_INDX on PGMPOR (PROGRAMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PGMPOR");
        }
        try {
          QU03="CREATE INDEX PGMPORBIS_INDX on PGMPOR (PORTFOLIOID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PGMPOR");
        }
        try {
          QU03="CREATE TABLE USRPOR(LOGIN char(20),PORTFOLIOID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : USRPOR");
        }
        try {
          QU03="CREATE INDEX USRPOR_INDX on USRPOR (LOGIN)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : USRPOR");
        }
        try {
          QU03="CREATE INDEX USRPORBIS_INDX on USRPOR (PORTFOLIOID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : USRPOR");
        }
        try {
          QU03="CREATE TABLE GRPPOR(GROUPID char(20), PORTFOLIOID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : GRPPOR");
        }
        try {
          QU03="CREATE INDEX GRPPOR_INDX on GRPPOR (GROUPID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : GRPPOR");
        }
        try {
          QU03="CREATE INDEX GRPPORBIS_INDX on GRPPOR(PORTFOLIOID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : GRPPOR");
        }
        try {
          QU03="CREATE TABLE PROJECT_BUDGET(PROJECTID char(20),ID int, DESCRIPTION text, TYPE char(1), AMOUNT int,CER char(50),DATEBUD date)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT_BUDGET");
        }
        try {
          QU03="CREATE INDEX PROJECT_BUDGET_INDX on PROJECT_BUDGET (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_BUDGET");
        }
        try {
          QU03="CREATE INDEX PROJECT_BUDGETBIS_INDX on PROJECT_BUDGET (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_BUDGET");
        }
        try {
          QU03="CREATE TABLE PRODUCT_BUDGET(PRODUCTID char(20),ID int, DESCRIPTION text, TYPE char(1), AMOUNT int,CER char(50),DATEBUD date)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT_BUDGET");
        }
        try {
          QU03="CREATE INDEX PRODUCT_BUDGET_INDX on PRODUCT_BUDGET (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_BUDGET");
        }
        try {
          QU03="CREATE INDEX PRODUCT_BUDGETBIS_INDX on PRODUCT_BUDGET (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_BUDGET");
        }
        try {
          QU03="CREATE TABLE APPLICATION_BUDGET(APPLICATIONID char(20),ID int, DESCRIPTION text, TYPE char(1), AMOUNT int,CER char(50),DATEBUD date)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPLICATION_BUDGET");
        }
        try {
          QU03="CREATE INDEX APPLICATION_BUDGET_INDX on APPLICATION_BUDGET (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_BUDGET");
        }
        try {
          QU03="CREATE INDEX APPLICATION_BUDGETBIS_INDX on APPLICATION_BUDGET (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_BUDGET");
        }
        try {
          QU03="CREATE TABLE PROJECT_HEALTH(PROJECTID char(20),DATE_HEALTH date, HEALTH_QUESTIONID char(20),RESULT int,PHASE char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT_HEALTH");
        }
        try {
          QU03="CREATE INDEX PROJECT_HEALTH_INDX on PROJECT_HEALTH (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_HEALTH");
        }
        try {
          QU03="CREATE TABLE HEALTH_QUESTION(ID char(20),NAME char(250),ORD int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : HEALTH_QUESTION");
        }
        try {
          QU03="CREATE INDEX HEALTH_QUESTION_INDX on HEALTH_QUESTION (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : HEALTH_QUESTION");
        }
        try {
          QU03="CREATE TABLE HEALTH_ANSWER(QUESTIONID char(20),ID char(20),ANSWER text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : HEALTH_ANSWER");
        }
        try {
          QU03="CREATE INDEX HEALTH_ANSWER_INDX on HEALTH_ANSWER (QUESTIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : HEALTH_ANSWER");
        }
        try {
          QU03="CREATE INDEX HEALTH_ANSWERBIS_INDX on HEALTH_ANSWER (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : HEALTH_ANSWER");
        }
        try {
          QU03="CREATE TABLE PROJECT_EXPENSE(PROJECTID char(20),ID int, DESCRIPTION text, TYPE char(1), AMOUNT int,DATEEXP date,VENDORID char(20),INVOICE char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT_EXPENSE");
        }
        try {
          QU03="CREATE INDEX PROJECT_EXPENSE_INDX on PROJECT_EXPENSE (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_EXPENSE");
        }
        try {
          QU03="CREATE INDEX PROJECT_EXPENSEBIS_INDX on PROJECT_EXPENSE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_EXPENSE");
        } 
        try {
          QU03="CREATE TABLE PRODUCT_EXPENSE(PRODUCTID char(20),ID int, DESCRIPTION text, TYPE char(1), AMOUNT int,DATEEXP date,VENDORID char(20),INVOICE char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT_EXPENSE");
        }
        try {
          QU03="CREATE INDEX PRODUCT_EXPENSE_INDX on PRODUCT_EXPENSE (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_EXPENSE");
        }
        try {
          QU03="CREATE INDEX PRODUCT_EXPENSEBIS_INDX on PRODUCT_EXPENSE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_EXPENSE");
        }
        try {
          QU03="CREATE TABLE APPLICATION_EXPENSE(APPLICATIONID char(20),ID int, DESCRIPTION text, TYPE char(1), AMOUNT int,DATEEXP date,VENDORID char(20),INVOICE char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPLICATION_EXPENSE");
        }
        try {
          QU03="CREATE INDEX APPLICATION_EXPENSE_INDX on APPLICATION_EXPENSE (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_EXPENSE");
        }
        try {
          QU03="CREATE INDEX APPLICATION_EXPENSEBIS_INDX on APPLICATION_EXPENSE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_EXPENSE");
        }        
        try {
          QU03="CREATE TABLE TEAM (ID char(20),NAME char(254), DESCRIPTION text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : TEAM");
        }
        try {
          QU03="CREATE INDEX TEAM_INDX on TEAM (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : TEAM");
        }
        try {
          QU03="CREATE TABLE RESTM(EMPLOYEEID char(20),TEAMID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : RESTM");
        }
        try {
          QU03="CREATE INDEX RESTM_INDX on RESTM (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : RESTM");
        }
        try {
          QU03="CREATE INDEX RESTMBIS_INDX on RESTM (TEAMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : RESTM");
        }
        try {
          QU03="CREATE TABLE EMPTM(EMPLOYEEID char(20),TEAMID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : EMPTM");
        }
        try {
          QU03="CREATE INDEX EMPTM_INDX on EMPTM (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPTM");
        }
        try {
          QU03="CREATE INDEX EMPTMBIS_INDX on EMPTM (TEAMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPTM");
        }
        try {
          QU03="CREATE TABLE GRPTM(GROUPID char(20),TEAMID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : GRPTM");
        }
        try {
          QU03="CREATE INDEX GRPTM_INDX on GRPTM (GROUPID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : GRPTM");
        }
        try {
          QU03="CREATE INDEX GRPTMBIS_INDX on GRPTM (TEAMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : GRPTM");
        }
        try {
          QU03="CREATE TABLE SCORING_GROUP_PORTFOLIO(GROUPID char(20),PORTFOLIOID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SCORING_GROUP_PORTFOLIO");
        }
        try {
          QU03="CREATE TABLE SCORING_GROUP(ID char(20), NAME char(254))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SCORING_GROUP");
        }
        try {
          QU03="CREATE TABLE SCORING_QUESTION(ID char(20), NAME char(254),WEIGHT int,GROUPID char(20),DESCRIPTION text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SCORING_QUESTION");
        }
        try {
          QU03="CREATE TABLE SCORING_QUESTION_ANSWER(ID char(20), NAME char(254), SCORE int,QUESTIONID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SCORING_QUESTION_ANSWER");
        }
        try {
          QU03="CREATE TABLE PRJANS (PROJECTID char(20),QUESTIONID char(20), ANSWERID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRJANS");
        }
        try {
          QU03="CREATE TABLE FOWNER(ID char(20),NAME char(254))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : FOWNER");
        }
        try {
          QU03="CREATE INDEX FOWNER_INDX on FOWNER (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : FOWNER");
        }
        try {
          QU03="CREATE TABLE STRATEGICINITIATIVE (ID char(20), NAME char(254))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : STRATEGICINITIATIVE");
        }
        try {
          QU03="CREATE INDEX STRATEGICINITIATIVE_INDX on STRATEGICINITIATIVE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : STRATEGICINITIATIVE");
        }
        try {
          QU03="CREATE TABLE PRJSI(PROJECTID char(20),SIID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : RPJSI");
        }
        try {
          QU03="CREATE INDEX PRJSI_INDX on PRJSI (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJSI");
        }
        try {
          QU03="CREATE INDEX PRJSIBIS_INDX on PRJSI (SIID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJSI");
        }
        try {
          QU03="CREATE TABLE PRDSI(PRODUCTID char(20),SIID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRDSI");
        }
        try {
          QU03="CREATE INDEX PRDSI_INDX on PRDSI (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDSI");
        }
        try {
          QU03="CREATE INDEX PRDSIBIS_INDX on PRDSI (SIID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDSI");
        }
        try {
          QU03="CREATE TABLE APPSI(APPLICATIONID char(20),SIID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPSI");
        }
        try {
          QU03="CREATE INDEX APPSI_INDX on APPSI (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPSI");
        }
        try {
          QU03="CREATE INDEX APPSIBIS_INDX on APPSI (SIID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPSI");
        }        
        try {
          QU03="CREATE TABLE APPLICATIONTYPE (ID char(20), NAME char(254))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPLICATIONTYPE");
        }
        try {
          QU03="CREATE INDEX APPLICATIONTYPE_INDX on APPLICATIONTYPE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATIONTYPE");
        }
        try {
          QU03="CREATE TABLE PRJAT(PROJECTID char(20),ATID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRJAT");
        }
        try {
          QU03="CREATE INDEX PRJAT_INDX on PRJAT (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJAT");
        }
        try {
          QU03="CREATE INDEX PRJATBIS_INDX on PRJAT (ATID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJAT");
        }
        try {
          QU03="CREATE TABLE INFRASTRUCTURETYPE (ID char(20), NAME char(254))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : INFRASTRUCTURETYPE");
        }
        try {
          QU03="CREATE INDEX INFRASTRUCTURETYPE_INDX on INFRASTRUCTURETYPE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : INFRASTRUCTURETYPE");
        }
        try {
          QU03="CREATE TABLE PRJIT(PROJECTID char(20),ITID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRJIT");
        }
        try {
          QU03="CREATE INDEX PRJIT_INDX on PRJIT (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJIT");
        }
        try {
          QU03="CREATE INDEX PRJITBIS_INDX on PRJIT (ITID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJIT");
        }
        try {
          QU03="CREATE TABLE LOCATION(ID char(20),NAME char(254),DIVISIONID char(20),BITLID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : LOCATION");
        }
        try {
          QU03="CREATE INDEX LOCATION_INDX on LOCATION (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : LOCATION");
        }
        try {
          QU03="CREATE TABLE DIVISION(ID char(20),NAME char(254))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : DIVISION");
        }
        try {
          QU03="CREATE INDEX DIVISION_INDX on DIVISION (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : DIVISION");
        }
        try {
          QU03="CREATE TABLE PRJDIV(PROJECTID char(20),DIVISIONID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRJDIV");
        }
        try {
          QU03="CREATE INDEX PRJDIV_INDX on PRJDIV (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJDIV");
        }
        try {
          QU03="CREATE INDEX PRJDIVBIS_INDX on PRJDIV (DIVISIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJDIV");
        }
        try {
          QU03="CREATE TABLE PRJLOC(PROJECTID char(20),LOCATIONID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRJLOC");
        }
        try {
          QU03="CREATE INDEX PRJLOC_INDX on PRJLOC (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJLOC");
        }
        try {
          QU03="CREATE INDEX PRJLOCBIS_INDX on PRJLOC (LOCATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJLOC");
        }
        try {
          QU03="CREATE TABLE PRDDIV(PRODUCTID char(20),DIVISIONID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRDDIV");
        }
        try {
          QU03="CREATE INDEX PRDDIV_INDX on PRDDIV (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDDIV");
        }
        try {
          QU03="CREATE INDEX PRDDIVBIS_INDX on PRDDIV (DIVISIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDDIV");
        }
        try {
          QU03="CREATE TABLE PRDLOC(PRODUCTID char(20),LOCATIONID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRDLOC");
        }
        try {
          QU03="CREATE INDEX PRDLOC_INDX on PRDLOC (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDLOC");
        }
        try {
          QU03="CREATE INDEX PRDLOCBIS_INDX on PRDLOC (LOCATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDLOC");
        }
        try {
          QU03="CREATE TABLE APPDIV(APPLICATIONID char(20),DIVISIONID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPDIV");
        }
        try {
          QU03="CREATE INDEX APPDIV_INDX on APPDIV (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPDIV");
        }
        try {
          QU03="CREATE INDEX APPDIVBIS_INDX on APPDIV (DIVISIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPDIV");
        }
        try {
          QU03="CREATE TABLE APPLOC(APPLICATIONID char(20),LOCATIONID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPLOC");
        }
        try {
          QU03="CREATE INDEX APPLOC_INDX on APPLOC (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLOC");
        }
        try {
          QU03="CREATE INDEX APPLOCBIS_INDX on APPLOC (LOCATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLOC");
        }        
        try {
          QU03="CREATE TABLE EMPLOYEE(ID char(20),NAME char(50),FORNAME char(30),OUID char(20),CONTRACTOR char(1),SITEID char(20),PROFILEID char(20), SKILL int,CAPACITY int,FULLTEXT (NAME,FORNAME),RATE int) ENGINE=MYISAM";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : EMPLOYEE");
        }
        try {
          QU03="CREATE INDEX EMPLOYEE_INDX on EMPLOYEE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPLOYEE");
        }
        try {
          QU03="CREATE TABLE OU(ID char(20),NAME char(50),FATHER char(20),EMPLOYEEID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : OU");
        }
        try {
          QU03="CREATE INDEX OU_INDX on OU(ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : OU");
        }
        try {
          QU03="CREATE INDEX OUBIS_INDX on OU(FATHER)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : OU");
        }
        try {
          QU03="CREATE INDEX OUTER_INDX on OU(EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : OU");
        }
        try {
          QU03="CREATE TABLE EMPPRF(EMPLOYEEID char(20),PROFILEID char(20),SKILL int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : EMPPRF");
        }
        try {
          QU03="CREATE INDEX EMPPRF_INDX on EMPPRF (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPPRF");
        }
        try {
          QU03="CREATE INDEX EMPPRFBIS_INDX on EMPPRF (PROFILEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPPRF");
        }
        try {
          QU03="CREATE TABLE EMPREC(ORD int,EMPLOYEEID char(20),RECURRINGID char(20),WORKLOAD int,DATE_START date,DATE_END date)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : EMPREC");
        }
        try {
          QU03="CREATE INDEX EMPREC_INDX on EMPREC (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPREC");
        }
        try {
          QU03="CREATE INDEX EMPRECBIS_INDX on EMPREC (RECURRINGID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPREC");
        }
        try {
          QU03="CREATE TABLE EMPLOYEE_RECURRING_WORKLOAD(EMPLOYEEID char(20),RECURRINGID char(20),ORD int,YEAR int,MONTH int,WORKLOAD int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : EMPLOYEE_RECURRING_WORKLOAD");
        }
        try {
          QU03="CREATE INDEX EMPLOYEE_RECURRING_WORKLOAD_INDX on EMPLOYEE_RECURRING_WORKLOAD (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPLOYEE_RECURRING_WORKLOAD");
        }
        try {
          QU03="CREATE INDEX EMPLOYEE_RECURRING_WORKLOADBIS_INDX on EMPLOYEE_RECURRING_WORKLOAD (EMPLOYEEID,RECURRINGID,ORD)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPLOYEE_RECURRING_WORKLOAD");
        }
        try {
          QU03="CREATE INDEX EMPLOYEE_RECURRING_WORKLOADTER_INDX on EMPLOYEE_RECURRING_WORKLOAD (EMPLOYEEID,YEAR,MONTH)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : EMPLOYEE_RECURRING_WORKLOAD");
        }
        try {
          QU03="CREATE TABLE PRJBPO(EMPLOYEEID char(20),PROJECTID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRJBPO");
        }
        try {
          QU03="CREATE INDEX PRJBPO_INDX on PRJBPO (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJBPO");
        }
        try {
          QU03="CREATE INDEX PRJBPOBIS_INDX on PRJBPO (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJBPO");
        }
        try {
          QU03="CREATE TABLE PRJPM(EMPLOYEEID char(20),PROJECTID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRJPM");
        }
        try { 
          QU03="CREATE INDEX PRJPM_INDX on PRJPM (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJPM");
        }  
        try {
          QU03="CREATE INDEX PRJPMBIS_INDX on PRJPM (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRJPM");
        }
        try {
          QU03="CREATE TABLE PRDBPO(EMPLOYEEID char(20),PRODUCTID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRDBPO");
        }
        try {
          QU03="CREATE INDEX PRDBPO_INDX on PRDBPO (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDBPO");
        }   
        try {
          QU03="CREATE INDEX PRDBPOBIS_INDX on PRDBPO (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDBPO");
        }
        try {
          QU03="CREATE TABLE PRDPM(EMPLOYEEID char(20),PRODUCTID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRDPM");
        }
        try {
          QU03="CREATE INDEX PRDPM_INDX on PRDPM (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDPM");
        }
        try {
          QU03="CREATE INDEX PRDPMBIS_INDX on PRDPM (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRDPM");
        }
        try {
          QU03="CREATE TABLE APPBPO(EMPLOYEEID char(20),APPLICATIONID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPBPO");
        }
        try {
          QU03="CREATE INDEX APPBPO_INDX on APPBPO (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPBPO");
        }   
        try {
          QU03="CREATE INDEX APPBPOBIS_INDX on APPBPO (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPBPO");
        }
        try {
          QU03="CREATE TABLE APPPM(EMPLOYEEID char(20),APPLICATIONID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPPM");
        }
        try {
          QU03="CREATE INDEX APPPM_INDX on APPPM (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPPM");
        }
        try {
          QU03="CREATE INDEX APPPMBIS_INDX on APPPM (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPPM");
        }        
        try {
          QU03="CREATE TABLE PGMBPO(EMPLOYEEID char(20),PROGRAMID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PGMBPO");
        }
        try {
          QU03="CREATE INDEX PGMBPO_INDX on PGMBPO (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PGMBPO");
        }
        try {
          QU03="CREATE INDEX PGMBPOBIS_INDX on PGMBPO (PROGRAMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PGMBPO");
        }
        try {
          QU03="CREATE TABLE PGMPM(EMPLOYEEID char(20),PROGRAMID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PGMPM");
        }
        try { 
          QU03="CREATE INDEX PGMPM_INDX on PGMPM (EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PGMPM");
        }
        try {
          QU03="CREATE INDEX PGMPMBIS_INDX on PGMPM (PROGRAMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PGMPM");
        }
        try {
          QU03="CREATE TABLE FILTER(LOGIN char(20),FILTERNAME char(200),FILTERVALUE char(200))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : FILTER");
        }
        try {
          QU03="CREATE TABLE PROJECT_ACTIVITY(PROJECTID char(20),ID int,ORD int,NAME char(50),FATHER char(20),DATE_START date,DATE_END date,WORKLOAD int,DURATION int,WBS char(20),TEMPLATELINK text,DOCLINK text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PROJECT_ACTIVITY_INDX on PROJECT_ACTIVITY (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE PRODUCT_ACTIVITY(PRODUCTID char(20),ID int,ORD int,NAME char(50),FATHER char(20),DATE_START date,DATE_END date,WORKLOAD int,DURATION int,WBS char(20),TEMPLATELINK text,DOCLINK text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PRODUCT_ACTIVITY_INDX on PRODUCT_ACTIVITY (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE APPLICATION_ACTIVITY(APPLICATIONID char(20),ID int,ORD int,NAME char(50),FATHER char(20),DATE_START date,DATE_END date,WORKLOAD int,DURATION int,WBS char(20),TEMPLATELINK text,DOCLINK text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPLICATION_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX APPLICATION_ACTIVITY_INDX on APPLICATION_ACTIVITY (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE BASELINE (ID int,PROJECTID char(20),DATE_START date,DATE_END date,DATE_BASELINE date,NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : BASELINE");
        }
        try {
          QU03="CREATE INDEX BASELINE_INDX on BASELINE (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : BASELINE");
        }
        try {
          QU03="CREATE INDEX BASELINEBIS_INDX on BASELINE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : BASELINE");
        }
        try {
          QU03="CREATE TABLE BASELINE_ACTIVITY(BASELINEID int,PROJECTID char(20),ACTIVITYID int,DATE_START date,DATE_END date,WORKLOAD int,DURATION int,WBS char(20),NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX BASELINE_ACTIVITY_INDX on BASELINE_ACTIVITY (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX BASELINE_ACTIVITYBIS_INDX on BASELINE_ACTIVITY (BASELINEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE PROGRAM_BASELINE (ID int,PROGRAMID char(20),DATE_START date,DATE_END date,DATE_BASELINE date,NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROGRAM_BASELINE");
        }
        try {
          QU03="CREATE INDEX PROGRAM_BASELINE_INDX on PROGRAM_BASELINE (PROGRAMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROGRAM_BASELINE");
        }
        try {
          QU03="CREATE INDEX PROGRAM_BASELINEBIS_INDX on PROGRAM_BASELINE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROGRAM_BASELINE");
        }
        try {
          QU03="CREATE TABLE PROGRAM_BASELINE_ACTIVITY(BASELINEID int,PROGRAMID char(20),PROJECTID char(20),ACTIVITYID int,DATE_START date,DATE_END date,WORKLOAD int,DURATION int,WBS char(20),NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROGRAM_BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PROGRAM_BASELINE_ACTIVITY_INDX on PROGRAM_BASELINE_ACTIVITY (PROGRAMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROGRAM_BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PROGRAM_BASELINE_ACTIVITYBIS_INDX on PROGRAM_BASELINE_ACTIVITY (BASELINEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROGRAM_BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE PRODUCT_BASELINE (ID int,PRODUCTID char(20),DATE_START date,DATE_END date,DATE_BASELINE date,NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT_BASELINE");
        }
        try {
          QU03="CREATE INDEX PRODUCT_BASELINE_INDX on PRODUCT_BASELINE (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_BASELINE");
        }
        try {
          QU03="CREATE INDEX PRODUCT_BASELINEBIS_INDX on PRODUCT_BASELINE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_BASELINE");
        }
        try {
          QU03="CREATE TABLE PRODUCT_BASELINE_ACTIVITY(BASELINEID int,PRODUCTID char(20),ACTIVITYID int,DATE_START date,DATE_END date,WORKLOAD int,DURATION int,WBS char(20),NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT_BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PRODUCT_BASELINE_ACTIVITY_INDX on PRODUCT_BASELINE_ACTIVITY (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PRODUCT_BASELINE_ACTIVITYBIS_INDX on PRODUCT_BASELINE_ACTIVITY (BASELINEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE APPLICATION_BASELINE (ID int,APPLICATIONID char(20),DATE_START date,DATE_END date,DATE_BASELINE date,NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPLICATION_BASELINE");
        }
        try {
          QU03="CREATE INDEX APPLICATION_BASELINE_INDX on APPLICATION_BASELINE (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_BASELINE");
        }
        try {
          QU03="CREATE INDEX APPLICATION_BASELINEBIS_INDX on APPLICATION_BASELINE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_BASELINE");
        }
        try {
          QU03="CREATE TABLE APPLICATION_BASELINE_ACTIVITY(BASELINEID int,APPLICATIONID char(20),ACTIVITYID int,DATE_START date,DATE_END date,WORKLOAD int,DURATION int,WBS char(20),NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPLICATION_BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX APPLICATION_BASELINE_ACTIVITY_INDX on APPLICATION_BASELINE_ACTIVITY (APPLICATIONID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX APPLICATION_BASELINE_ACTIVITYBIS_INDX on APPLICATION_BASELINE_ACTIVITY (BASELINEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_BASELINE_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE PROJECT_ACTIVITY_LINK(PROJECTID char(20),FROMID int,TOID int,TYPE char(2))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT_ACTIVITY_LINK");
        }
        try {
          QU03="CREATE INDEX PROJECT_ACTIVITY_LINK_INDX on PROJECT_ACTIVITY_LINK (PROJECTID, FROMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT_ACTIVITY_LINK");
        }
        try {
          QU03="CREATE INDEX PROJECT_ACTIVITY_LINKBIS_INDX on PROJECT_ACTIVITY_LINK (PROJECTID, TOID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_ACTIVITY_LINK");
        }
        try {
          QU03="CREATE TABLE PRODUCT_ACTIVITY_LINK(PRODUCTID char(20),FROMID int,TOID int,TYPE char(2))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT_ACTIVITY_LINK");
        }
        try {
          QU03="CREATE INDEX PRODUCT_ACTIVITY_LINK_INDX on PRODUCT_ACTIVITY_LINK (PRODUCTID, FROMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_ACTIVITY_LINK");
        }
        try {
          QU03="CREATE INDEX PRODUCT_ACTIVITY_LINKBIS_INDX on PRODUCT_ACTIVITY_LINK (PRODUCTID, TOID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_ACTIVITY_LINK");
        }
        try {
          QU03="CREATE TABLE APPLICATION_ACTIVITY_LINK(APPLICATIONID char(20),FROMID int,TOID int,TYPE char(2))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : APPLICATION_ACTIVITY_LINK");
        }
        try {
          QU03="CREATE INDEX APPLICATION_ACTIVITY_LINK_INDX on APPLICATION_ACTIVITY_LINK (APPLICATIONID, FROMID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_ACTIVITY_LINK");
        }
        try {
          QU03="CREATE INDEX APPLICATION_ACTIVITY_LINKBIS_INDX on APPLICATION_ACTIVITY_LINK (APPLICATIONID, TOID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : APPLICATION_ACTIVITY_LINK");
        }
        try {
        	QU03="CREATE TABLE PROJECT_ACTIVITY_WORKLOAD(PROJECTID char(20),ACTIVITYID int,YEAR int,MONTH int,DAY int,WORKLOAD int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT_ACTIVITY_WORKLOAD");
        }
        try {
          QU03="CREATE INDEX PROJECT_ACTIVITY_WORKLOAD_INDX on PROJECT_ACTIVITY_WORKLOAD (PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_ACTIVITY_WORKLOAD");
        }
        try {
          QU03="CREATE INDEX PROJECT_ACTIVITY_WORKLOADBIS_INDX on PROJECT_ACTIVITY_WORKLOAD (PROJECTID,ACTIVITYID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_ACTIVITY_WORKLOAD");
        }
        try {
          QU03="CREATE INDEX PROJECT_ACTIVITY_WORKLOADTER_INDX on PROJECT_ACTIVITY_WORKLOAD (PROJECTID,YEAR,MONTH,DAY)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_ACTIVITY_WORKLOAD");
        }
        try {
          QU03="CREATE TABLE RESOURCE_PROFILE_ACTIVITY(PROJECTID char(20),ACTIVITYID int,PROFILEID char(20),PERCENTAGE int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : RESOURCE_PROFILE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX RESOURCE_PROFILE_ACTIVITY_INDX on RESOURCE_PROFILE_ACTIVITY(PROJECTID,ACTIVITYID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : RESOURCE_PROFILE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX RESOURCE_PROFILE_ACTIVITY_INDX2 on RESOURCE_PROFILE_ACTIVITY(PROFILEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : RESOURCE_PROFILE_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE RESOURCE_USER_ACTIVITY(PROJECTID char(20),ACTIVITYID int,EMPLOYEEID char(20),PERCENTAGE int,PROFILEID char(20),APPROVED char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : RESOURCE_USER_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX RESOURCE_USER_ACTIVITY_INDX on RESOURCE_USER_ACTIVITY(PROJECTID,ACTIVITYID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : RESOURCE_USER_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX RESOURCE_USER_ACTIVITY_INDX2 on RESOURCE_USER_ACTIVITY(EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : RESOURCE_USER_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE PRODUCT_ACTIVITY_WORKLOAD(PRODUCTID char(20),ACTIVITYID int,YEAR int,MONTH int,DAY int,WORKLOAD int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT_ACTIVITY_WORKLOAD");
        }
        try {
          QU03="CREATE INDEX PRODUCT_ACTIVITY_WORKLOAD_INDX on PRODUCT_ACTIVITY_WORKLOAD (PRODUCTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_ACTIVITY_WORKLOAD");
        }
        try {
          QU03="CREATE INDEX PRODUCT_ACTIVITY_WORKLOADBIS_INDX on PRODUCT_ACTIVITY_WORKLOAD (PRODUCTID,ACTIVITYID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_ACTIVITY_WORKLOAD");
        }
        try {
          QU03="CREATE INDEX PRODUCT_ACTIVITY_WORKLOADTER_INDX on PRODUCT_ACTIVITY_WORKLOAD (PRODUCTID,YEAR,MONTH,DAY)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_ACTIVITY_WORKLOAD");
        }
        try {
          QU03="CREATE TABLE PRODUCT_RESOURCE_PROFILE_ACTIVITY(PRODUCTID char(20),ACTIVITYID int,PROFILEID char(20),PERCENTAGE int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT_RESOURCE_PROFILE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PRODUCT_RESOURCE_PROFILE_ACTIVITY_INDX on PRODUCT_RESOURCE_PROFILE_ACTIVITY(PRODUCTID,ACTIVITYID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_RESOURCE_PROFILE_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PRODUCT_RESOURCE_PROFILE_ACTIVITY_INDX2 on PRODUCT_RESOURCE_PROFILE_ACTIVITY(PROFILEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_RESOURCE_PROFILE_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE PRODUCT_RESOURCE_USER_ACTIVITY(PRODUCTID char(20),ACTIVITYID int,EMPLOYEEID char(20),PERCENTAGE int,PROFILEID char(20),APPROVED char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PRODUCT_RESOURCE_USER_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PRODUCT_RESOURCE_USER_ACTIVITY_INDX on PRODUCT_RESOURCE_USER_ACTIVITY(PRODUCTID,ACTIVITYID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_RESOURCE_USER_ACTIVITY");
        }
        try {
          QU03="CREATE INDEX PRODUCT_RESOURCE_USER_ACTIVITY_INDX2 on PRODUCT_RESOURCE_USER_ACTIVITY(EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PRODUCT_RESOURCE_USER_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE PROFILE(ID char(20),NAME char(50),RATE int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROFILE");
        }
        try {
          QU03="CREATE INDEX PROFILE_INDX on PROFILE (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROFILE");
        }
        try {
          QU03="CREATE TABLE SKILL(ID char(20),NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SKILL");
        }
        try {
          QU03="CREATE INDEX SKILL_INDX on SKILL (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : SKILL");
        }
        try {
          QU03="CREATE TABLE RIGHTLIST(ID char(20),NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : RIGHTLIST");
        }
        try {
          QU03="CREATE INDEX RIGHTLIST_INDX on RIGHTLIST (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : RIGHTLIST");
        }
        try {
          QU03="CREATE TABLE RECURRING(ID char(20),NAME char(50),CAPACITYTRIANGLE char(1))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : RECURRING");
        }
        try {
          QU03="CREATE INDEX RECURRING_INDX on RECURRING (ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : RECURRING");
        }
        try {
          QU03="CREATE TABLE INDX(ID char(20),SEQ int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : INDX");
        }
        try {
          QU03="CREATE INDEX INDX_ID_INDX on INDX(ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : INDX");
        }
        try {
          QU03="CREATE TABLE TIMESHEET(PROJECTID char(20),PHASEID char(20),WDATE date,LOGIN char(20),MONDAY int,THUESDAY int, WEDNESDAY int,THURSDAY int,FRIDAY int, SATURDAY int,SUNDAY int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : TIMESHEET");
        }
        try {
          QU03="CREATE INDEX TIMESHEET_INDX on TIMESHEET (PROJECTID,PHASEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : TIMESHEET");
        }
        try {
          QU03="CREATE TABLE LOGS(LOGIN char(20),NAME char(50),FORNAME char(50),TIME char(50),STATE char(200))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : LOGS");
        }
        try {
          QU03="CREATE TABLE PHASE_TEMPLATE(TEMPLATE char(50),ORD int,NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PHASE_TEMPLATE");
        }
        try {
          QU03="CREATE TABLE PHASE_TEMPLATE_ACTIVITY(TEMPLATE char(50),ORD int,NAME char(50),WORKLOAD int,DOCLINK text,ACTORD int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PHASE_TEMPLATE_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE PROJECT_RISK(PROJECTID char(20),ID int,NAME char(50),DESCRIPTION text,DATE_DISCOVER date,DATE_CLOSING date,EMPLOYEEID char(20),IMPACT int,LIKELIHOOD int,ESCALATE char(1),CLOSED char(1))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT_RISK");
        }
        try {
          QU03="CREATE INDEX PROJECT_RISK_INDX on PROJECT_RISK(PROJECTID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_RISK");
        }
        try {
          QU03="CREATE TABLE PROJECT_RISK_ACTION(PROJECTID char(20),RISKID int,ID int,NAME char(50),DESCRIPTION text,DATE_CREATION date,DATE_CLOSING date,STATUS text,EMPLOYEEID char(20),IMPACT int,LIKELIHOOD int,IMPLEMENT char(20),CLOSED char(1),STRATEGY char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PROJECT_RISK_ACTION");
        }
        try {
          QU03="CREATE INDEX PROJECT_RISK_ACTION_INDX on PROJECT_RISK_ACTION(PROJECTID,RISKID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : PROJECT_RISK_ACTION");
        }
        try {
            QU03="CREATE TABLE PRODUCT_RISK(PRODUCTID char(20),ID int,NAME char(50),DESCRIPTION text,DATE_DISCOVER date,DATE_CLOSING date,EMPLOYEEID char(20),IMPACT int,LIKELIHOOD int,ESCALATE char(1),CLOSED char(1))";
            STU03.executeUpdate(QU03);
          } catch (Exception e) {
            out.print("<br>Error creating table : PRODUCT_RISK");
          }
          try {
            QU03="CREATE INDEX PRODUCT_RISK_INDX on PRODUCT_RISK(PRODUCTID)";
            STU03.executeUpdate(QU03);
          } catch (Exception e) {
            out.print("<br>Error creating table index : PRODUCT_RISK");
          }
          try {
            QU03="CREATE TABLE PRODUCT_RISK_ACTION(PRODUCTID char(20),RISKID int,ID int,NAME char(50),DESCRIPTION text,DATE_CREATION date,DATE_CLOSING date,STATUS text,EMPLOYEEID char(20),IMPACT int,LIKELIHOOD int,IMPLEMENT char(20),CLOSED char(1),STRATEGY char(20))";
            STU03.executeUpdate(QU03);
          } catch (Exception e) {
            out.print("<br>Error creating table : PRODUCT_RISK_ACTION");
          }
          try {
            QU03="CREATE INDEX PRODUCT_RISK_ACTION_INDX on PRODUCT_RISK_ACTION(PRODUCTID,RISKID)";
            STU03.executeUpdate(QU03);
          } catch (Exception e) {
            out.print("<br>Error creating table index : PRODUCT_RISK_ACTION");
          }
          try {
            QU03="CREATE TABLE APPLICATION_RISK(APPLICATIONID char(20),ID int,NAME char(50),DESCRIPTION text,DATE_DISCOVER date,DATE_CLOSING date,EMPLOYEEID char(20),IMPACT int,LIKELIHOOD int,ESCALATE char(1),CLOSED char(1))";
            STU03.executeUpdate(QU03);
          } catch (Exception e) {
            out.print("<br>Error creating table : APPLICATION_RISK");
          }
          try {
            QU03="CREATE INDEX APPLICATION_RISK_INDX on APPLICATION_RISK(APPLICATIONID)";
            STU03.executeUpdate(QU03);
          } catch (Exception e) {
            out.print("<br>Error creating table index : APPLICATION_RISK");
          }
          try {
            QU03="CREATE TABLE APPLICATION_RISK_ACTION(APPLICATIONID char(20),RISKID int,ID int,NAME char(50),DESCRIPTION text,DATE_CREATION date,DATE_CLOSING date,STATUS text,EMPLOYEEID char(20),IMPACT int,LIKELIHOOD int,IMPLEMENT char(20),CLOSED char(1),STRATEGY char(20))";
            STU03.executeUpdate(QU03);
          } catch (Exception e) {
            out.print("<br>Error creating table : APPLICATION_RISK_ACTION");
          }
          try {
            QU03="CREATE INDEX APPLICATION_RISK_ACTION_INDX on APPLICATION_RISK_ACTION(APPLICATIONID,RISKID)";
            STU03.executeUpdate(QU03);
          } catch (Exception e) {
            out.print("<br>Error creating table index : APPLICATION_RISK_ACTION");
          } 
        try {
          QU03="CREATE TABLE REPORT_TABLES (TABLE_NAME char(50),TABLE_DBNAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : REPORT_TABLES");
        }
        try {
          QU03="CREATE INDEX REPORT_TABLES_INDX on REPORT_TABLES(TABLE_NAME)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : REPORT_TABLES");
        }
        try {
          QU03="CREATE TABLE REPORT_TABLES_FIELDS(TABLE_DBNAME char(50),FIELD_NAME char(50),FIELD_DBNAME char(50), JOINT_TABLE char(1),JOINT_TABLE_DBNAME char(50),JOINT_TABLE_ID_DBFIELD char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : REPORT_TABLES_FIELDS");
        }
        try {  
          QU03="CREATE INDEX REPORT_TABLES_FIELDS_INDX on REPORT_TABLES_FIELDS(TABLE_DBNAME)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="CREATE TABLE CUSTOM_REPORT(REPORT_NAME char(50),TABLE_NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : CUSTOM_REPORT");
        }
        try {
          QU03="CREATE TABLE CUSTOM_REPORT_FIELDS(REPORT_NAME char(50),FIELD_NAME char(50))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : CUSTOM_REPORT_FIELDS");
        }
        try {
          QU03="CREATE TABLE WEEK_DAY_OFF (SITEID char(20),DAYOFF int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : WEEK_DAY_OFF");
        }
        try {
          QU03="CREATE INDEX WEEK_DAY_OFF_INDX on WEEK_DAY_OFF(SITEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="CREATE TABLE OTHER_DAY_OFF (SITEID char(20),DAYOFF date)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : OTHER_DAY_OFF");
        }
        try {
          QU03="CREATE INDEX OTHER_DAY_OFF_INDX on OTHER_DAY_OFF(SITEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : OTHER_DAY_OFF");
        }
        try {
          QU03="CREATE TABLE HOLLIDAY (EMPLOYEEID char(20),DAYOFF date)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : HOLLIDAY");
        }
        try {
          QU03="CREATE INDEX HOLLIDAY_INDX on HOLLIDAY(EMPLOYEEID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : HOLLIDAY");
        }
        out.print("<br>PPPM.ORG tables created.");
        out.print("<br>Populating basic configuration items ...");
        try {
          QU03="INSERT INTO REPORT_TABLES VALUES('PROJECT','PROJECT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES");
        }
        try {
          QU03="INSERT INTO REPORT_TABLES_FIELDS VALUES('PROJECT','PROJECT NAME','NAME','N','','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="INSERT INTO REPORT_TABLES_FIELDS VALUES('PROJECT','PROJECT DESCRIPTION','DESCRIPTION','N','','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="INSERT INTO REPORT_TABLES_FIELDS VALUES('PROJECT','PROJECT SCORE','SCORE','N','','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="INSERT INTO REPORT_TABLES_FIELDS VALUES('PROJECT','DATE START','DATE_START','N','','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="INSERT INTO REPORT_TABLES_FIELDS VALUES('PROJECT','DATE END','DATE_END','N','','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="INSERT INTO REPORT_TABLES_FIELDS VALUES('PROJECT','STATUS','STATUS','N','','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="INSERT INTO REPORT_TABLES_FIELDS VALUES('PROJECT','ON HOLD STATUS','ONHOLD','N','','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="INSERT INTO REPORT_TABLES_FIELDS VALUES('PROJECT','IS CLOSED','CLOSED','N','','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="INSERT INTO REPORT_TABLES_FIELDS VALUES('PROJECT','TEMPLATE','TEMPLATE','N','','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : REPORT_TABLES_FIELDS");
        }
        try {
          QU03="INSERT INTO OU VALUES('ENT','ENTEPRISE','ROOT','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : OU");
        }
        try {
          QU03="INSERT INTO PROFILE VALUES('PSP','PROJECT SPONSOR',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {
          QU03="INSERT INTO PROFILE VALUES('PMG','PROJECT MANAGER',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {
          QU03="INSERT INTO PROFILE VALUES('DEV','DEVELOPPER',40)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {
          QU03="INSERT INTO PROFILE VALUES('BAT','BUSINESS ANALYST',60)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {
          QU03="INSERT INTO PROFILE VALUES('SME','SUBJECT MATTER EXPERT',60)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {
          QU03="INSERT INTO PROFILE VALUES('BPO','BUSINESS PROCESS OWNER',120)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {
          QU03="INSERT INTO PROFILE VALUES('HTC','HELPDESK TECHNICIAN',30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {
          QU03="INSERT INTO PROFILE VALUES('TST','TESTER',40)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {  
          QU03="INSERT INTO PROFILE VALUES('TRN','TRAINER',90)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {
          QU03="INSERT INTO PROFILE VALUES('ITQ','QUALITY',60)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROFILE");
        }
        try {
          QU03="INSERT INTO SKILL VALUES('0','Not Defined')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : SKILL");
        }
        try {
          QU03="INSERT INTO SKILL VALUES('1','Beginner')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : SKILL");
        } 
        try {
          QU03="INSERT INTO SKILL VALUES('2','Junior')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : SKILL");
        }
        try {
          QU03="INSERT INTO SKILL VALUES('3','Senior')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : SKILL");
        }
        try {
          QU03="INSERT INTO SKILL VALUES('4','Expert')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : SKILL");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('REQUEST','REQUEST CREATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('REQAPP','REQUEST MANAGEMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('PROJECT','PROJECT MANAGEMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('HEALTH','HEALTH CHECK MANAGEMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('BASELINE','BASELINE MANAGEMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('PROGRAM','PROGRAM MANAGEMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('PORTCONF','PORTFOLIO CONFIGURATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('RESOURCE','RESOURCE MANAGEMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('RESCONF','RESOURCE CONFIGURATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('CAPACITY','CAPACITY MANAGEMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('SIMULATION','CAPACITY SIMULATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('VENDOR','VENDOR MANAGEMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('REPORTING','REPORTING')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try { 
          QU03="INSERT INTO RIGHTLIST VALUES('ADMIN','ADMINISTRATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }  
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('PRODUCT','PRODUCT MANAGEMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('PRODUCTCONF','PRODUCT CONFIGURATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('PRODUCT','APM')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO RIGHTLIST VALUES('PRODUCTCONF','APM CONFIGURATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RIGHTLIST");
        }
        try {
          QU03="INSERT INTO PHASE_TEMPLATE VALUES('PMBOK',0,'DISCOVERY')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PHASE_TEMPLATE");
        }
        try {
          QU03="INSERT INTO PHASE_TEMPLATE VALUES('PMBOK',1,'PLANNING')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PHASE_TEMPLATE");
        }
        try {
          QU03="INSERT INTO PHASE_TEMPLATE VALUES('PMBOK',2,'EXECUTION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PHASE_TEMPLATE");
        }
        try {
          QU03="INSERT INTO PHASE_TEMPLATE VALUES('PMBOK',3,'DEPLOYMENT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PHASE_TEMPLATE");
        }
        try {
          QU03="INSERT INTO PHASE_TEMPLATE VALUES('PMBOK',4,'CLOSE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PHASE_TEMPLATE");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('COM','Communications')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('FIN','Finance')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('HRE','Human Resources')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('ITE','Information Technology')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('LEC','Legal and Compliance')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('LOD','Logistics and Distribution')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('MAN','Manufacturing')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('RAQ','Quality')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('RAD','Research and Development')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO FOWNER VALUES('SAL','Sales')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : FOWNER");
        }
        try {
          QU03="INSERT INTO APPLICATIONTYPE VALUES('ERP','ERP')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : APPLICATIONTYPE");
        }
        try {
          QU03="INSERT INTO APPLICATIONTYPE VALUES('BIR','BI')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : APPLICATIONTYPE");
        }
        try {
          QU03="INSERT INTO APPLICATIONTYPE VALUES('CRM','CRM')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : APPLICATIONTYPE");
        }
        try {
          QU03="INSERT INTO APPLICATIONTYPE VALUES('SOA','SOA')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : APPLICATIONTYPE");
        }
        try {
          QU03="INSERT INTO APPLICATIONTYPE VALUES('PLM','PLM')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : APPLICATIONTYPE");
        }
        try {
          QU03="INSERT INTO APPLICATIONTYPE VALUES('WEB','Web')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : APPLICATIONTYPE");
        }
        try {
          QU03="INSERT INTO APPLICATIONTYPE VALUES('MOB','Mobile')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : APPLICATIONTYPE");
        }
        try {
          QU03="INSERT INTO INFRASTRUCTURETYPE VALUES('TEL','Telecom')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INFRASTRUCTURETYPE");
        }
        try {
          QU03="INSERT INTO INFRASTRUCTURETYPE VALUES('NET','Network')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INFRASTRUCTURETYPE");
        }
        try {
          QU03="INSERT INTO INFRASTRUCTURETYPE VALUES('MSV','Microsoft')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INFRASTRUCTURETYPE");
        }
        try {
          QU03="INSERT INTO INFRASTRUCTURETYPE VALUES('BST','Storage')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INFRASTRUCTURETYPE");
        }
        try {
          QU03="INSERT INTO INFRASTRUCTURETYPE VALUES('BSM','Unix')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INFRASTRUCTURETYPE");
        }
        try {
          QU03="INSERT INTO INFRASTRUCTURETYPE VALUES('DAT','Datacenter')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INFRASTRUCTURETYPE");
        }
        try {
          QU03="INSERT INTO INFRASTRUCTURETYPE VALUES('SEC','Security')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INFRASTRUCTURETYPE");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('EMPLOYEE',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
      try {
          QU03="INSERT INTO INDX VALUES ('GROUP',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }        
        try {
          QU03="INSERT INTO INDX VALUES ('PROJECT',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('PRODUCT',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('APPLICATION',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('PROGRAM',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('PORTFOLIO',1);";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('TEAM',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO RECURRING VALUES('NWK','NON-WORKING TIME','N')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RECURRING");
        }
        try {
          QU03="INSERT INTO RECURRING VALUES('SUP','SUPPORT','N')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RECURRING");
        }
        try {
          QU03="INSERT INTO RECURRING VALUES('HDK','HELPDESK','N')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RECURRING");
        }
        try {   
          QU03="INSERT INTO RECURRING VALUES('ADM','ADMINISTRATIVE ACTIVITY','N')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RECURRING");
        }
        try {
          QU03="INSERT INTO RECURRING VALUES('MGT','MANAGEMENT','N')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RECURRING");
        }
        try {
          QU03="INSERT INTO RECURRING VALUES('OTH','OTHER','N')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : RECURRING");
        }
        out.print("<br>Basic configuration items populated.");
        out.print("<br>Adding admin user ...");
        try {
          QU03="INSERT INTO USERS VALUES('admin','PPPM.ORG Admin','Admin','LOCAL','NO','admin@localhost','admin')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error adding Admin user");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','ADMIN')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','REQUEST')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','REQAPP')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','PROJECT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','PROGRAM')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','PORTCONF')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','RESOURCE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','RESCONF')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','CAPACITY')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','SIMULATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        try {
          QU03="INSERT INTO USER_RIGHT VALUES('admin','REPORTING')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error setting rights");
        }
        out.print("<br>Admin user added.");
        out.print("<br>Creating CMDB tables ...");
        try {
          QU03="CREATE TABLE CMDB_SOFTWARE(ID char(20),NAME char(200),DESCRIPTION TEXT,SITEID char(20),VENDORID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SOFTWARE");
        }
        try {
          QU03="CREATE TABLE CMDB_SOFTWARE_VERSION(ID char(20),SOFTWAREID char(20),VERSION char(20),DESCRIPTION TEXT,CCFORM char(20),GOLIVE char(20),SERVERID char(200),ACTIVE char(1),CONTRACTID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SOFTWARE_VERSION");
        }
        try {
          QU03="CREATE TABLE CMDB_SOFTWARE_INSTANCE(VERSIONID char(20),SERVERID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SOFTWARE_INSTANCE");
        }
        try {
          QU03="CREATE TABLE CMDB_SOFTWARE_INCIDENT(ID char(20),VERSIONID char(20),TITLE char(255),DESCRIPTION TEXT,ACTION TEXT,RESULT TEXT,CHECKED char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SOFTWARE_INCIDENT");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER(ID char(20),DESCRIPTION text,RACKID char(20),U char(20),USIZE char(20),ISVIRTUAL char(1),VIRTUALHOST char(200),CONTRACTID char(20),SITEID char(20),OSID char(20),SPID char(20),VENDORID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER");
        }
        try {
          QU03="CREATE TABLE CMDB_SWITCH(ID char(200),DESCRIPTION text,RACKID char(20),U char(20),USIZE char(20),NBPLUG char(20),CONTRACTID char(20),SITEID char(20),VENDORID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SWITCH");
        }
        try {
          QU03="CREATE TABLE CMDB_SWITCH_POWER(SWITCHID char(200),POWERTYPE char(200),POWERCAPACITY char(20),POWERID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SWITCH_POWER");
        }
        try {
          QU03="CREATE TABLE CMDB_BACKUP(ID char(200),DESCRIPTION text,RACKID char(20),U char(20),USIZE char(20),CONTRACTID char(20),SITEID char(20),VENDORID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : BACKUP");
        }
        try {
          QU03="CREATE TABLE CMDB_BACKUP_POWER(BACKUPID char(200),POWERTYPE char(200),POWERCAPACITY char(20),POWERID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : BACKUP_POWER");
        }
        try {
          QU03="CREATE TABLE CMDB_BACKUP_NETWORK(BACKUPID char(20),NETWORKTYPE char(200),NETWORKSPEED char(20),NETWORKADDRESS char(40),NETWORKMASK char(40),NETWORKGATEWAY char(40),NETWORKID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : BACKUP_NETWORK");
        }
        try {
          QU03="CREATE TABLE CMDB_OTHER(ID char(200),DESCRIPTION text,RACKID char(20),U char(20),USIZE char(20),CONTRACTID char(20),SITEID char(20),VENDORID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : OTHER");
        }
        try {
          QU03="CREATE TABLE CMDB_OTHER_POWER(OTHERID char(200),POWERTYPE char(200),POWERCAPACITY char(20),POWERID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : OTHER_POWER");
        }
        try {
          QU03="CREATE TABLE CMDB_OTHER_NETWORK(OTHERID char(20),NETWORKTYPE char(200),NETWORKSPEED char(20),NETWORKADDRESS char(40),NETWORKMASK char(40),NETWORKGATEWAY char(40),NETWORKID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : OTHER_NETWORK");
        }
        try {
          QU03="CREATE TABLE CMDB_SAN(ID char(200),DESCRIPTION text,RACKID char(20),U char(20),USIZE char(20),CONTRACTID char(20),SITEID char(20),VENDORID char(20),NBPLUG char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SAN");
        }
        try {
          QU03="CREATE TABLE CMDB_SAN_NETWORK(SANID char(20),NETWORKTYPE char(200),NETWORKSPEED char(20),NETWORKADDRESS char(40),NETWORKMASK char(40),NETWORKGATEWAY char(40),NETWORKID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SAN_NETWORK");
        }
        try {
          QU03="CREATE TABLE CMDB_SAN_POWER(SANID char(200),POWERTYPE char(200),POWERCAPACITY char(20),POWERID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SAN_POWER");
        }
        try {
          QU03="CREATE TABLE CMDB_SAN_DISK(SANID char(20),DISKTYPE char(200),DISKSIZE char(20),DISKID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SAN_DISK");
        }
        try {
          QU03="CREATE TABLE CMDB_SAN_VOLUME(SANID char(20),VOLUMENAME char(200),VOLUMESIZE char(20),VOLUMEID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SAN_VOLUME");
        }
        try {
          QU03="CREATE TABLE CMDB_NETCABLE(ELEMENTID char(200),ELEMENTTYPE char(20),SWITCHID char(200),PLUG char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : NETCABLE");
        }
        try {
          QU03="CREATE TABLE CMDB_POWERCABLE(ELEMENTID char(200),ELEMENTTYPE char(20),PDUID char(200),PLUG char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : POWERCABLE");
        }
        try {
          QU03="CREATE TABLE CMDB_PDU(ID char(200),DESCRIPTION text,PLUGID char(20),NBPLUG char(20),CAPACITY char(20),RACKID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PDU");
        }
        try {
          QU03="CREATE TABLE CMDB_PLUG(ID char(200),DESCRIPTION text,ROOMID char(20),CAPACITY char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : PLUG");
        }
        try {
          QU03="CREATE TABLE CMDB_RACK(ID char(200),DESCRIPTION text,ROOMID char(20),NBU char(20),VENDORID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : RACK");
        }
        try {
          QU03="CREATE TABLE CMDB_ROOM(ID char(200),DESCRIPTION text,SITEID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : ROOM");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER_MEMORY(SERVERID char(20),MEMORYTYPE char(200),MEMORYSIZE char(20),MEMORYID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER_MEMORY");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER_DISK(SERVERID char(20),DISKTYPE char(200),DISKSIZE char(20),DISKID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER_DISK");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER_POWER(SERVERID char(20),POWERTYPE char(200),POWERCAPACITY char(20),POWERID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER_POWER");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER_SAN(SERVERID char(20),SANID char(20),VOLUMEID char(200),SERVERSANID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER_SAN");
        }
        try {
          QU03="CREATE TABLE CMDB_FIBERCABLE(ELEMENTID char(200),ELEMENTTYPE char(20),SANID char(200),PLUG char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : FIBERCABLE");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER_PROC(SERVERID char(20),PROCTYPE char(200),PROCCORE char(20),PROCID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER_PROC");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER_NETWORK(SERVERID char(20),NETWORKTYPE char(200),NETWORKSPEED char(20),NETWORKADDRESS char(40),NETWORKMASK char(40),NETWORKGATEWAY char(40),NETWORKID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER_NETWORK");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER_FIBER(SERVERID char(20),FIBERTYPE char(200),FIBERID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER_FIBER");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER_ACTIVITY (SERVERID char(20),ID char(20),DESCRIPTION text,CCFORM char(20),DATEIMPL char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER_ACTIVITY");
        }
        try {
          QU03="CREATE TABLE CMDB_BACKUP_CHECK(BCKDATE char(20),SOFTWAREID char(20),DATAGEN char(1),DATATAPE char(1),REASON text,APPROVEDBY char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : BACKUP_CHECK");
        }
        try {
          QU03="CREATE TABLE CMDB_VENDOR_CONTRACT(ID char(20),VENDORID char(20),REFERENCE char(50),DESCRIPTION text,DDAY int,DMONTH int,DYEAR int,EDAY int,EMONTH int,EYEAR int,PRICE int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : VENDOR_CONTRACT");
        }
        try {
          QU03="CREATE INDEX CMDB_CONTRACT_ID_INDX on CMDB_VENDOR_CONTRACT(ID)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table index : VENDOR_CONTRACT");
        }
        try {
          QU03="CREATE TABLE CMDB_OS(ID char(20),NAME char(200),VENDORID char(20),ESDAY int,ESMONTH int,ESYEAR int,VERSION char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : OS");
        }
        try {
          QU03="CREATE TABLE CMDB_SP(ID char(20),OSID char(20),NAME char(200),RDAY int,RMONTH int,RYEAR int,ALLOWED char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SP");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVICE(ID char(20),NAME char(200),DESCRIPTION text,VENDORID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVICE");
        }
        try {
          QU03="CREATE TABLE CMDB_SERVER_SERVICE(SERVERID char(20),SERVICEID char(20),PORT char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating table : SERVER_SERVICE");
        }
        out.print("<br>CMDB tables created.");
        out.print("<br>Populating CMDB Basic configuration items ...");
        try {
          QU03="INSERT INTO INDX VALUES ('SOFTWARE',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('ACTIVITY',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('VERSION',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('VENDOR',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('OS',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('SP',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('SERVICE',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('PLUG',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('PDU',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('INCIDENT',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO INDX VALUES ('CONTRACT',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        out.print("<br>CMDB Basic configuration items populated.");
        out.print("<br>Creating ESTIMATION tables ...");
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_STRUCTURE(ID char(20),NAME char(254),DESCRIPTION text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_STRUCTURE");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_TYPE(ID char(20), NAME char(254),DESCRIPTION text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_TYPE");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_PLANNING_FEEDBACK(PROJECTID char(20),EASY_HOURS int,STANDARD_HOURS int,COMPLEX_HOURS int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_PLANNING_FEEDBACK");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_EXECUTION_FEEDBACK(PROJECTID char(20),DEV_HOURS int,TESTING_HOURS int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_EXECUTION_FEEDBACK");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_MANAGEMENT_FEEDBACK(PROJECTID char(20),IDRATIO char(20),HOURS int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_MANAGEMENT_FEEDBACK");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_DEPL_FEEDBACK(PROJECTID char(20),HOURS int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_DEPL_FEEDBACK");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_TRAIN_FEEDBACK(PROJECTID char(20),HOURS int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_TRAIN_FEEDBACK");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_RISK_RATIO(PROJECTTYPEID char(20),EASY_RATIO int,STANDARD_RATIO int,COMPLEX_RATIO int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_RISK_RATIO");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_PLANNING_RATIO(PROJECTTYPEID char(20),EASY_HOURS int,STANDARD_HOURS int,COMPLEX_HOURS int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_PLANNING_RATIO");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_EXECUTION_RATIO(PROJECTTYPEID char(20),DEV_RATIO int,TESTING_RATIO int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_EXECUTION_RATIO");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_MANAGEMENT_RATIO(PROJECTTYPEID char(20),IDRATIO char(20),RATIO int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_DEPL_RATIO(PROJECTTYPEID char(20),EASY_RATIO int,STANDARD_RATIO int,COMPLEX_RATIO int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_DEPL_RATIO");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_TRAIN_RATIO(PROJECTTYPEID char(20),EASY_RATIO int,STANDARD_RATIO int,COMPLEX_RATIO int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_TRAIN_RATIO");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_CLOSE_RATIO(PROJECTTYPEID char(20), RATIO int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_CLOSE_RATIO");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_TECHNOLOGY_TASK(PROJECTID char(20),TECHNOLOGYID char(20),TASKID char(20),NBEASY int,NBSTANDARD int, NBCOMPLEX int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_TECHNOLOGY_TASK");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_TECHNOLOGY(PROJECTID char(20),TECHNOLOGYID char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_TECHNOLOGY");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_TECHNOLOGY(ID char(20),NAME char(254),DESCRIPTION text)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_TECHNOLOGY_TASK_RATIO(TECHNOLOGYID char(20),TASKID char(20),NAME char(254),DESCRIPTION text,EASY_DEV_HOURS int,STANDARD_DEV_HOURS int,COMPLEX_DEV_HOURS int,EASY_TEST_HOURS int,STANDARD_TEST_HOURS int,COMPLEX_TEST_HOURS int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_TECHNOLOGY_TASK_RATIO");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_REQUIREMENTS(PROJECTID char(20),NBEASY int,NBSTANDARD int,NBCOMPLEX int)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_REQUIREMENTS");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_DEPLOYMENT(PROJECTID char(20),COMPLEXITY char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_DEPLOYMENT");
        }
        try {
          QU03="CREATE TABLE ESTIMATION_PROJECT_TRAINING(PROJECTID char(20),COMPLEXITY char(20))";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error creating : ESTIMATION_PROJECT_TRAINING");
        }
        out.print("<br>ESTIMATION tables created.");
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_STRUCTURE VALUES('VCY','V-CYLE TYPE PROJECT','Project using the V-Cycle methodology for its execution')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_STRUCTURE");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_STRUCTURE VALUES('AGI','AGILE TYPE PROJECT','Project using the Agile methodology for its execution')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_STRUCTURE");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TYPE VALUES('ENT','ENTERPRISE PROJECT','Project covering a lot of technology')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TYPE");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TYPE VALUES('ERP','ERP PROJECT','Project mostly focussed on ERP')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TYPE");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TYPE VALUES('PLM','PLM PROJECT','Project mostly focussed on PLM')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TYPE");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TYPE VALUES('WEB','WEBAPPS PROJECT','Project mostly focussed on WEBAPPS')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TYPE");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TYPE VALUES('MOB','MOBILE PROJECT','Project mostly focussed on MOBILE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TYPE");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TYPE VALUES('CRM','CRM PROJECT','Project mostly focussed on CRM')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TYPE");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TYPE VALUES('INF','INFRA PROJECT','Project mostly focussed on INFRASTRUCTURE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TYPE");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_RISK_RATIO VALUES('ENT',90,100,120)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_RISK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_RISK_RATIO VALUES('ERP',90,100,120)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_RISK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_RISK_RATIO VALUES('PLM',90,100,120)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_RISK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_RISK_RATIO VALUES('WEB',90,100,120)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_RISK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_RISK_RATIO VALUES('MOB',90,100,120)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_RISK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_RISK_RATIO VALUES('CRM',90,100,120)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_RISK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_RISK_RATIO VALUES('INF',90,100,120)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_RISK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_PLANNING_RATIO VALUES('ENT',4,8,16)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_PLANNING_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_PLANNING_RATIO VALUES('ERP',4,8,16)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_PLANNING_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_PLANNING_RATIO VALUES('PLM',4,8,16)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_PLANNING_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_PLANNING_RATIO VALUES('WEB',4,8,16)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_PLANNING_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_PLANNING_RATIO VALUES('MOB',4,8,16)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_PLANNING_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_PLANNING_RATIO VALUES('CRM',4,8,16)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_PLANNING_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_PLANNING_RATIO VALUES('INF',4,8,16)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_PLANNING_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_EXECUTION_RATIO VALUES('ENT',100,100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_EXECUTION_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_EXECUTION_RATIO VALUES('ERP',100,100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_EXECUTION_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_EXECUTION_RATIO VALUES('PLM',100,100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_EXECUTION_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_EXECUTION_RATIO VALUES('WEB',100,100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_EXECUTION_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_EXECUTION_RATIO VALUES('MOB',100,100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_EXECUTION_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_EXECUTION_RATIO VALUES('CRM',100,100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_EXECUTION_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_EXECUTION_RATIO VALUES('INF',100,100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_EXECUTION_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ENT','PL-PM',20)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ENT','PL-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ENT','EX-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ENT','EX-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ENT','DP-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ENT','DP-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ENT','CL-PM',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ENT','CL-QA',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ERP','PL-PM',20)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ERP','PL-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ERP','EX-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ERP','EX-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ERP','DP-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ERP','DP-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ERP','CL-PM',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('ERP','CL-QA',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('PLM','PL-PM',20)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('PLM','PL-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('PLM','EX-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('PLM','EX-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('PLM','DP-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('PLM','DP-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('PLM','CL-PM',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('PLM','CL-QA',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('WEB','PL-PM',20)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('WEB','PL-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('WEB','EX-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('WEB','EX-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('WEB','DP-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('WEB','DP-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('WEB','CL-PM',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('WEB','CL-QA',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('MOB','PL-PM',20)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('MOB','PL-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('MOB','EX-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('MOB','EX-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('MOB','DP-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('MOB','DP-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('MOB','CL-PM',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('MOB','CL-QA',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('CRM','PL-PM',20)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('CRM','PL-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('CRM','EX-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('CRM','EX-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('CRM','DP-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('CRM','DP-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('CRM','CL-PM',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('CRM','CL-QA',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('INF','PL-PM',20)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('INF','PL-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('INF','EX-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('INF','EX-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('INF','DP-PM',15)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('INF','DP-QA',10)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('INF','CL-PM',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_MANAGEMENT_RATIO VALUES('INF','CL-QA',100)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_MANAGEMENT_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_DEPL_RATIO VALUES('ENT',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_DEPL_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_DEPL_RATIO VALUES('ERP',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_DEPL_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_DEPL_RATIO VALUES('PLM',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_DEPL_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_DEPL_RATIO VALUES('WEB',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_DEPL_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_DEPL_RATIO VALUES('MOB',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_DEPL_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_DEPL_RATIO VALUES('CRM',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_DEPL_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_DEPL_RATIO VALUES('INF',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_DEPL_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TRAIN_RATIO VALUES('ENT',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TRAIN_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TRAIN_RATIO VALUES('ERP',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TRAIN_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TRAIN_RATIO VALUES('PLM',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TRAIN_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TRAIN_RATIO VALUES('WEB',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TRAIN_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TRAIN_RATIO VALUES('MOB',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TRAIN_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TRAIN_RATIO VALUES('CRM',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TRAIN_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_TRAIN_RATIO VALUES('INF',15,20,30)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_TRAIN_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_CLOSE_RATIO VALUES('ENT',2)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_CLOSE_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_CLOSE_RATIO VALUES('ERP',2)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_CLOSE_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_CLOSE_RATIO VALUES('PLM',2)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_CLOSE_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_CLOSE_RATIO VALUES('WEB',2)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_CLOSE_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_CLOSE_RATIO VALUES('MOB',2)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_CLOSE_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_CLOSE_RATIO VALUES('CRM',2)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_CLOSE_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_PROJECT_CLOSE_RATIO VALUES('INF',2)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_PROJECT_CLOSE_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('CPP','C++','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('JAV','JAVA','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('PHP','PHP','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('DBA','Database','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('ORA','ORACLE Application','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('JDE','JD Edwards','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('MFG','MFG-PRO','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('SAP','SAP','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('WCH','Windchill','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('GEN','Generic','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('BIM','Microsoft BI','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('BIC','Cognos BI','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('MOB','Mobile','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('SRV','Server infrastructure','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('SAN','SAN infrastructure','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('NET','Network infrastructure','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('SEC','Security','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY VALUES('AS4','AS/400 infrastructure','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY_TASK_RATIO VALUES('JAV','001','Create web-page','',4,8,16,2,4,8)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY_TASK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY_TASK_RATIO VALUES('JAV','002','Create data connectors','',4,8,16,2,4,8)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY_TASK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY_TASK_RATIO VALUES('JAV','003','Configure web-site','',8,12,20,4,5,8)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY_TASK_RATIO");
        }
        try {
          QU03="INSERT INTO ESTIMATION_TECHNOLOGY_TASK_RATIO VALUES('JAV','004','Deploy web-site','',1,2,3,1,2,3)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating: ESTIMATION_TECHNOLOGY_TASK_RATIO");
        }
        out.print("<br>ESTIMATION Tables populated.");
        STU03.close();
        Conn.close();
      }
    %>
  </body>
</html>
