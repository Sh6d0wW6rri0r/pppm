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
        out.print("<br>Populating PPM tables with demo data...");

        try {
          QU03="INSERT INTO USERS VALUES('jdoe','Doe','John','LOCAL','NO','john.doe@nowhere.net','jdoe')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : USERS - JDOE");
        }
        try {
          QU03="INSERT INTO USERS VALUES('tdoe','Doe','Tracy','LOCAL','NO','tracy.doe@nowhere.net','tdoe')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : USERS - TDOE");
        }
        try {
          QU03="INSERT INTO USERS VALUES('ldoe','Doe','Leonard','LOCAL','NO','leonard.doe@nowhere.net','ldoe')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : USERS - LDOE");
        }
        try {
          QU03="INSERT INTO GROUPS VALUES('ADM', 'Administrators')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUPS - ADM");
        }
        try {
          QU03="INSERT INTO GROUPS VALUES('PMO', 'Project Management Office')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUPS - PMO");
        }
        try {
          QU03="INSERT INTO GROUPS VALUES('PM1', 'Project Manager Team 1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUPS - PM1");
        }
        try {
          QU03="INSERT INTO GROUPS VALUES('RM1', 'Resource Manager Team 1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUPS - RM1");
        }
        try {
          QU03="INSERT INTO GROUP_USER VALUES('ADM','admin')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_USER - ADM - admin");
        }
        try {
          QU03="INSERT INTO GROUP_USER VALUES('PMO','jdoe')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_USER - PMO - jdoe");
        }
        try {
          QU03="INSERT INTO GROUP_USER VALUES('PM1','tdoe')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_USER - PM1 - tdoe");
        }
        try {
          QU03="INSERT INTO GROUP_USER VALUES('RM1','ldoe')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_USER - RM1 - ldoe");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','REQUEST')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - REQUEST");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','PROJECT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - PROJECT");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','HEALTH')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - HEALTH");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','BASELINE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - BASELINE");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','PROGRAM')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - PROGRAM");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','PORTCONF')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - PORTCONF");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','RESOURCE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - RESOURCE");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','RESCONF')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - RESCONF");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','CAPACITY')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - CAPACITY");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','SIMULATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - SIMULATION");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','VENDOR')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - VENDOR");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','REPORTING')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - REPORTING");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','ADMIN')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - ADMIN");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','PRODUCT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - PRODUCT");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('ADM','PRODUCTCONF')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - ADM - PRODUCTCONF");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','REQUEST')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - REQUEST");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','PROJECT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - PROJECT");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','HEALTH')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - HEALTH");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','BASELINE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - BASELINE");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','PROGRAM')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - PROGRAM");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','PORTCONF')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - PORTCONF");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','RESOURCE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - RESOURCE");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','RESCONF')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - RESCONF");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','CAPACITY')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - CAPACITY");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','SIMULATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - SIMULATION");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','VENDOR')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - VENDOR");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','REPORTING')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - REPORTING");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','PRODUCT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - PRODUCT");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PMO','PRODUCTCONF')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PMO - PRODUCTCONF");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PM1','PROJECT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PM1 - PROJECT");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PM1','BASELINE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PM1 - BASELINE");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PM1','PROGRAM')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PM1 - PROGRAM");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PM1','REPORTING')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PM1 - REPORTING");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('PM1','PRODUCT')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - PM1 - PRODUCT");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('RM1','RESOURCE')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - RM1 - RESOURCE");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('RM1','CAPACITY')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - RM1 - CAPACITY");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('RM1','SIMULATION')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - RM1 - SIMULATION");
        }
        try {
          QU03="INSERT INTO GROUP_RIGHT VALUES('RM1','REPORTING')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GROUP_RIGHT - RM1 - REPORTING");
        } 
        try {
          QU03="INSERT INTO `GRPPOR` VALUES ('ADM','PRT1'),('PMO','PRT1'),('PM1','PRT1'),('RM1','PRT1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : GRPPOR");
        }
        try {
          QU03="DELETE FROM INDX";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO `INDX` VALUES ('EMPLOYEE',4),('GROUP',1),('PROJECT',9),('PRODUCT',2),('PROGRAM',2),('PORTFOLIO',2),('TEAM',1),('SOFTWARE',1),('ACTIVITY',1),('VERSION',1),('VENDOR',1),('OS',1),('SP',1),('SERVICE',1),('PLUG',1),('PDU',1),('INCIDENT',1),('CONTRACT',1)";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : INDX");
        }
        try {
          QU03="INSERT INTO `LOCATION` VALUES ('SIT001','La Defense Site','DIV001','EMP3'),('SIT002','New York Site','DIV002','EMP2')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : LOCATION");
        }
        try {
          QU03="INSERT INTO `OU` VALUES ('ENT','ENTEPRISE','ROOT',''),('IT001','IT Department','ENT',''),('FI001','Finance','ENT',''),('RD001','Research and Development','ENT',''),('SA001','Sales','ENT',''),('MA001','Manufacturing','ENT','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : OU");
        }
        try {
          QU03="INSERT INTO `PGMBPO` VALUES ('EMP1','PGM1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PGMBPO");
        }
        try {
          QU03="INSERT INTO `PGMPM` VALUES ('EMP2','PGM1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PGMPM");
        }
        try {
          QU03="INSERT INTO `PGMPOR` VALUES ('PGM1','PRT1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PGMPOR");
        }
        try {
          QU03="INSERT INTO `PORTFOLIO` VALUES ('PRT1','Enterprise Portfolio','Enterprise Portfolio')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PORTFOLIO");
        }
        try {
          QU03="INSERT INTO `PRDBPO` VALUES ('EMP1','PRD1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRDBPO");
        }
        try {
          QU03="INSERT INTO `PRDDIV` VALUES ('PRD1','DIV002')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRDDIV");
        }
        try {
          QU03="INSERT INTO `PRDLOC` VALUES ('PRD1','SIT002')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRDLOC");
        }
        try {
          QU03="INSERT INTO `PRDPM` VALUES ('EMP2','PRD1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRDPM");
        }
        try {
          QU03="INSERT INTO `PRDPOR` VALUES ('PRD1','PRT1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRDPOR");
        }
        try {
          QU03="INSERT INTO `PRDSI` VALUES ('PRD1','SI003')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRDSI");
        }
        try {
          QU03="INSERT INTO `PRJAT` VALUES ('PRJ1','ERP')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRJAT");
        }
        try {
          QU03="INSERT INTO `PRJBPO` VALUES ('EMP1','PRJ1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRJBPO");
        }
        try {
          QU03="INSERT INTO `PRJDIV` VALUES ('PRJ1','DIV001')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRJDIV");
        }
        try {
          QU03="INSERT INTO `PRJLOC` VALUES ('PRJ1','SIT001')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRJLOC");
        }
        try {
          QU03="INSERT INTO `PRJPGM` VALUES ('PRJ2','PGM1'),('PRJ3','PGM1'),('PRJ4','PGM1'),('PRJ5','PGM1'),('PRJ6','PGM1'),('PRJ7','PGM1'),('PRJ8','PGM1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRJPGM");
        }
        try {
          QU03="INSERT INTO `PRJPM` VALUES ('EMP2','PRJ1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRJPM");
        }
        try {
          QU03="INSERT INTO `PRJPOR` VALUES ('PRJ1','PRT1'),('PRJ2','PRT1'),('PRJ3','PRT1'),('PRJ4','PRT1'),('PRJ5','PRT1'),('PRJ6','PRT1'),('PRJ7','PRT1'),('PRJ8','PRT1')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRJPOR");
        }
        try {
          QU03="INSERT INTO `PRJSI` VALUES ('PRJ1','SI001')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRJSI");
        }
        try {
          QU03="INSERT INTO `PRODUCT` VALUES ('PRD1','Vortex product','Vortex demo product',0,'RAD','2016-04-07','2017-01-27','DISCOVERY','N','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRODUCT");
        }
        try {
          QU03="INSERT INTO `PRODUCT_ACTIVITY` VALUES ('PRD1',0,0,'DISCOVERY','ROOT','2016-04-07','2017-01-27',0,211,'0','NONE','N'),('PRD1',1,1,'PLANNING','ROOT','2016-04-07','2017-01-27',0,211,'1','NONE','N'),('PRD1',2,2,'EXECUTION','ROOT','2016-04-07','2017-01-27',0,211,'2','NONE','N'),('PRD1',3,3,'DEPLOYMENT','ROOT','2016-04-07','2017-01-27',0,211,'3','NONE','N'),('PRD1',4,4,'CLOSE','ROOT','2016-04-07','2017-01-27',0,211,'4','NONE','N')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRODUCT_ACTIVITY");
        }
        try {
          QU03="INSERT INTO `PRODUCT_ACTIVITY_LINK` VALUES ('PRD1',0,1,'EB'),('PRD1',1,2,'EB'),('PRD1',2,3,'EB'),('PRD1',3,4,'EB')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PRODUCT_ACTIVITY_LINK");
        }
        try {
          QU03="INSERT INTO `PROGRAM` VALUES ('PGM1','Solar system','Solar system demo program','LOD','2016-02-08','2017-05-12','PROGRAM','N')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROGRAM");
        }
        try {
          QU03="INSERT INTO `PROJECT` VALUES ('PRJ1','Pulsar Project','Pulsar Demo Project',NULL,'ITE','2016-03-01','2016-06-30','DISCOVERY','L','N','N','PMBOK',''),('PRJ2','Venus project','Venus project',NULL,'LOD','2016-03-01','2016-05-13','DISCOVERY','L','N','N','PMBOK',''),('PRJ3','Mars project','Mars project',NULL,'LOD','2016-06-09','2016-09-16','DISCOVERY','L','N','N','PMBOK',''),('PRJ4','Earth project','Earth project',NULL,'LOD','2016-05-19','2016-09-16','DISCOVERY','L','N','N','PMBOK',''),('PRJ5','Jupiter project','Jupiter project',NULL,'LOD','2016-07-05','2016-10-21','DISCOVERY','L','N','N','PMBOK',''),('PRJ6','Saturn project','Saturn project',NULL,'LOD','2016-08-10','2017-02-09','DISCOVERY','L','N','N','PMBOK',''),('PRJ7','Neptun project','Neptun project',NULL,'LOD','2016-06-14','2016-11-24','DISCOVERY','L','N','N','PMBOK',''),('PRJ8','Uranus project','Uranus project',NULL,'LOD','2016-10-12','2017-01-19','DISCOVERY','L','N','N','PMBOK','')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROJECT");
        }
        try {
          QU03="INSERT INTO `PROJECT_ACTIVITY` VALUES ('PRJ1',0,0,'DISCOVERY','ROOT','2016-03-01','2016-06-30',0,87,'0','NONE','N'),('PRJ1',1,1,'PLANNING','ROOT','2016-03-01','2016-06-30',0,87,'1','NONE','N'),('PRJ1',2,2,'EXECUTION','ROOT','2016-03-01','2016-06-30',0,87,'2','NONE','N'),('PRJ1',3,3,'DEPLOYMENT','ROOT','2016-03-01','2016-06-30',0,87,'3','NONE','N'),('PRJ1',4,4,'CLOSE','ROOT','2016-03-01','2016-06-30',0,87,'4','NONE','N'),('PRJ2',0,0,'DISCOVERY','ROOT','2016-03-01','2016-05-13',0,53,'0','NONE','N'),('PRJ2',1,1,'PLANNING','ROOT','2016-03-01','2016-05-13',0,53,'1','NONE','N'),('PRJ2',2,2,'EXECUTION','ROOT','2016-03-01','2016-05-13',0,53,'2','NONE','N'),('PRJ2',3,3,'DEPLOYMENT','ROOT','2016-03-01','2016-05-13',0,53,'3','NONE','N'),('PRJ2',4,4,'CLOSE','ROOT','2016-03-01','2016-05-13',0,53,'4','NONE','N'),('PRJ3',0,0,'DISCOVERY','ROOT','2016-06-09','2016-09-16',0,72,'0','NONE','N'),('PRJ3',1,1,'PLANNING','ROOT','2016-06-09','2016-09-16',0,72,'1','NONE','N'),('PRJ3',2,2,'EXECUTION','ROOT','2016-06-09','2016-09-16',0,72,'2','NONE','N'),('PRJ3',3,3,'DEPLOYMENT','ROOT','2016-06-09','2016-09-16',0,72,'3','NONE','N'),('PRJ3',4,4,'CLOSE','ROOT','2016-06-09','2016-09-16',0,72,'4','NONE','N'),('PRJ4',0,0,'DISCOVERY','ROOT','2016-05-19','2016-09-16',0,87,'0','NONE','N'),('PRJ4',1,1,'PLANNING','ROOT','2016-05-19','2016-09-16',0,87,'1','NONE','N'),('PRJ4',2,2,'EXECUTION','ROOT','2016-05-19','2016-09-16',0,87,'2','NONE','N'),('PRJ4',3,3,'DEPLOYMENT','ROOT','2016-05-19','2016-09-16',0,87,'3','NONE','N'),('PRJ4',4,4,'CLOSE','ROOT','2016-05-19','2016-09-16',0,87,'4','NONE','N'),('PRJ5',0,0,'DISCOVERY','ROOT','2016-07-05','2016-10-21',0,79,'0','NONE','N'),('PRJ5',1,1,'PLANNING','ROOT','2016-07-05','2016-10-21',0,79,'1','NONE','N'),('PRJ5',2,2,'EXECUTION','ROOT','2016-07-05','2016-10-21',0,79,'2','NONE','N'),('PRJ5',3,3,'DEPLOYMENT','ROOT','2016-07-05','2016-10-21',0,79,'3','NONE','N'),('PRJ5',4,4,'CLOSE','ROOT','2016-07-05','2016-10-21',0,79,'4','NONE','N'),('PRJ6',0,0,'DISCOVERY','ROOT','2016-08-10','2017-02-09',0,131,'0','NONE','N'),('PRJ6',1,1,'PLANNING','ROOT','2016-08-10','2017-02-09',0,131,'1','NONE','N'),('PRJ6',2,2,'EXECUTION','ROOT','2016-08-10','2017-02-09',0,131,'2','NONE','N'),('PRJ6',3,3,'DEPLOYMENT','ROOT','2016-08-10','2017-02-09',0,131,'3','NONE','N'),('PRJ6',4,4,'CLOSE','ROOT','2016-08-10','2017-02-09',0,131,'4','NONE','N'),('PRJ7',0,0,'DISCOVERY','ROOT','2016-06-14','2016-11-24',0,117,'0','NONE','N'),('PRJ7',1,1,'PLANNING','ROOT','2016-06-14','2016-11-24',0,117,'1','NONE','N'),('PRJ7',2,2,'EXECUTION','ROOT','2016-06-14','2016-11-24',0,117,'2','NONE','N'),('PRJ7',3,3,'DEPLOYMENT','ROOT','2016-06-14','2016-11-24',0,117,'3','NONE','N'),('PRJ7',4,4,'CLOSE','ROOT','2016-06-14','2016-11-24',0,117,'4','NONE','N'),('PRJ8',0,0,'DISCOVERY','ROOT','2016-10-12','2017-01-19',0,71,'0','NONE','N'),('PRJ8',1,1,'PLANNING','ROOT','2016-10-12','2017-01-19',0,71,'1','NONE','N'),('PRJ8',2,2,'EXECUTION','ROOT','2016-10-12','2017-01-19',0,71,'2','NONE','N'),('PRJ8',3,3,'DEPLOYMENT','ROOT','2016-10-12','2017-01-19',0,71,'3','NONE','N'),('PRJ8',4,4,'CLOSE','ROOT','2016-10-12','2017-01-19',0,71,'4','NONE','N')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROJECT_ACTIVITY");
        }
        try {
          QU03="INSERT INTO `PROJECT_ACTIVITY_LINK` VALUES ('PRJ1',0,1,'EB'),('PRJ1',1,2,'EB'),('PRJ1',2,3,'EB'),('PRJ1',3,4,'EB'),('PRJ2',0,1,'EB'),('PRJ2',1,2,'EB'),('PRJ2',2,3,'EB'),('PRJ2',3,4,'EB'),('PRJ3',0,1,'EB'),('PRJ3',1,2,'EB'),('PRJ3',2,3,'EB'),('PRJ3',3,4,'EB'),('PRJ4',0,1,'EB'),('PRJ4',1,2,'EB'),('PRJ4',2,3,'EB'),('PRJ4',3,4,'EB'),('PRJ5',0,1,'EB'),('PRJ5',1,2,'EB'),('PRJ5',2,3,'EB'),('PRJ5',3,4,'EB'),('PRJ6',0,1,'EB'),('PRJ6',1,2,'EB'),('PRJ6',2,3,'EB'),('PRJ6',3,4,'EB'),('PRJ7',0,1,'EB'),('PRJ7',1,2,'EB'),('PRJ7',2,3,'EB'),('PRJ7',3,4,'EB'),('PRJ8',0,1,'EB'),('PRJ8',1,2,'EB'),('PRJ8',2,3,'EB'),('PRJ8',3,4,'EB')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : PROJECT_ACTIVITY_LINK");
        }
        try {
          QU03="INSERT INTO `SCORING_GROUP` VALUES ('QG001','Increase Revenue'),('QG002','Improve Quality'),('QG003','Attract new customers')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : SCORING_GROUP");
        }
        try {
          QU03="INSERT INTO `SCORING_QUESTION` VALUES ('QS001','Expected Benefits from this project',1,'QG001','Indicate how this project benefits will impact the P&L of the company.'),('QS002','Payback duration',1,'QG001','How quick will be the payback for this project'),('QS003','Innovation',1,'QG003','How innovative is this project'),('QS004','First pass',1,'QG002','Improve the first pass rate of our project/product')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : SCORING_QUESTION");
        }
        try {
          QU03="INSERT INTO `SCORING_QUESTION_ANSWER` VALUES ('QR001','Less than 100 K dollars',1,'QS001'),('QR002','Between 100 K dollars and 1 M dollars',2,'QS001'),('QR003','Over 1 M dollars',3,'QS001'),('QR004','Less than 1 year',3,'QS002'),('QR005','Between 1 and 2 years',2,'QS002'),('QR006','More than 2 years',1,'QS002'),('QR007','New for the market',3,'QS003'),('QR008','New for our company',2,'QS003'),('QR009','Not new',1,'QS003'),('QR010','Do not improve first pass',1,'QS004'),('QR011','Improve first pass by up to 20 %',2,'QS004'),('QR012','Improve first pass by more than 20 %',3,'QS004')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : SCORING_QUESTION_ANSWER");
        }
        try {
          QU03="INSERT INTO `STRATEGICINITIATIVE` VALUES ('SI001','Increase Revenue'),('SI002','Improve Quality'),('SI003','Attract new customers')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : STRATEGICINITIATIVE");
        }
        try {
          QU03="INSERT INTO `VENDOR` VALUES ('VEN001','Consulting Inc','New-York.'),('VEN002','Research Inc','New-York'),('VEN003','Hardware Inc','Paris'),('VEN004','Software Inc','Paris')";
          STU03.executeUpdate(QU03);
        } catch (Exception e) {
          out.print("<br>Error populating : VENDOR");
        }

        out.print("<br>PPM Demo data populated.");
        STU03.close();
        Conn.close();
      }
    %>
  </body>
</html>
