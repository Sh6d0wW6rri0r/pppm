package fr.pppm;

// Vortex PPM, the OpenSource PPM (Portfolio, Project and Program management) system
// Copyright (C) 2012  Olivier Moulin

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3 of the License.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.


import java.util.*;
import java.sql.*;
import java.text.SimpleDateFormat;

public class Portfolio {

Connection portfolioConnection;
Vector out;

public Portfolio (Connection Conn) {
  portfolioConnection=Conn;
  out = new Vector();
}

public void addPortfolio(String name, String description) throws Exception {
  int ORD=0;
  Statement STR01 = portfolioConnection.createStatement();
  String QR01 = "SELECT ID,SEQ FROM INDX WHERE ID='PORTFOLIO'";
  ResultSet R01 = STR01.executeQuery(QR01);
  if (R01.next()) {
    ORD=R01.getInt("SEQ");
  }
  STR01.close();
  Statement STU01 = portfolioConnection.createStatement();
  String QU01 = "INSERT INTO PORTFOLIO VALUES('PRT"+ORD+"','"+name+"','"+description+"')";
  STU01.executeUpdate(QU01);
  STU01.close();
  Statement STU02 = portfolioConnection.createStatement();
  String QU02 = "UPDATE INDX SET SEQ="+(ORD+1)+" WHERE ID='PORTFOLIO'";
  STU02.executeUpdate(QU02);
  STU02.close();
}

public void modifyPortfolio(String portid, String name, String description) throws Exception {
  Statement STU03 = portfolioConnection.createStatement();
  String QU03 =  "UPDATE PORTFOLIO SET NAME='"+name+"', DESCRIPTION='"+description+"' WHERE ID='"+portid+"'";
  STU03.executeUpdate(QU03);
  STU03.close();
}

public void deletePortfolio(String portid) throws Exception {
  Statement STU04 = portfolioConnection.createStatement();
  String QU04 = "DELETE FROM PORTFOLIO WHERE ID='"+portid+"'";
  STU04.executeUpdate(QU04);
  STU04.close();
}

public void addUserPortfolio(String login, String portid) throws Exception {
  Statement STU01 = portfolioConnection.createStatement();
  String QU01 = "INSERT INTO USRPOR VALUES('"+login+"','"+portid+"')";
  STU01.executeUpdate(QU01);
  STU01.close();
}


public void deleteUserPortfolio(String login, String portid) throws Exception {
  Statement STU02 = portfolioConnection.createStatement();
  String QU02 = "DELETE FROM USRPOR WHERE PORTFOLIOID='"+portid+"' AND LOGIN='"+login+"'";
  STU02.executeUpdate(QU02);
  STU02.close();
}

public void addProjectPortfolio(String projectid,String portid) throws Exception {
  Statement STU01 = portfolioConnection.createStatement();
  String QU01 = "INSERT INTO PRJPOR VALUES('"+projectid+"','"+portid+"')";
  STU01.executeUpdate(QU01);
  STU01.close();
}

public void deleteProjectPortfolio(String projectid, String portid) throws Exception {
  Statement STU02 = portfolioConnection.createStatement();
  String QU02 = "DELETE FROM PRJPOR WHERE PORTFOLIOID='"+portid+"' AND PROJECTID='"+projectid+"'";
  STU02.executeUpdate(QU02);
  STU02.close();
}

public void addProgramPortfolio(String programid, String portid) throws Exception {
  Statement STU01 = portfolioConnection.createStatement();
  String QU01 = "INSERT INTO PGMPOR VALUES('"+programid+"','"+portid+"')";
  STU01.executeUpdate(QU01);
  STU01.close();
}

public void deleteProgramPortfolio(String programid, String portid) throws Exception {
  Statement STU02 = portfolioConnection.createStatement();
  String QU02 = "DELETE FROM PGMPOR WHERE PORTFOLIOID='"+portid+"' AND PROGRAMID='"+programid+"'";
  STU02.executeUpdate(QU02);
  STU02.close();
}

public void addProductPortfolio(String productid, String portid) throws Exception {
  Statement STU01 = portfolioConnection.createStatement();
  String QU01 = "INSERT INTO PRDPOR VALUES('"+productid+"','"+portid+"')";
  STU01.executeUpdate(QU01);
  STU01.close();
}

public void deleteProductPortfolio(String productid, String portid) throws Exception {
  Statement STU02 = portfolioConnection.createStatement();
  String QU02 = "DELETE FROM PRDPOR WHERE PORTFOLIOID='"+portid+"' AND PRODUCTID='"+productid+"'";
  STU02.executeUpdate(QU02);
  STU02.close();
}

public void addGroupPortfolio(String groupid, String portid) throws Exception {
  Statement STU01 = portfolioConnection.createStatement();
  String QU01 = "INSERT INTO GRPPOR VALUES('"+groupid+"','"+portid+"')";
  STU01.executeUpdate(QU01);
  STU01.close();
}

public void deleteGroupPortfolio(String groupid, String portid) throws Exception {
  Statement STU02 = portfolioConnection.createStatement();
  String QU02 = "DELETE FROM GRPPOR WHERE PORTFOLIOID='"+portid+"' AND GROUPID='"+groupid+"'";
  STU02.executeUpdate(QU02);
  STU02.close();
}


public int projectNB (String portid) throws Exception {
  int nbproject=0;
  Statement STR03 = portfolioConnection.createStatement();
  String QR03 = "SELECT COUNT(PROJECTID) FROM PRJPOR WHERE PORTFOLIOID='"+portid+"'";
  ResultSet R03 = STR03.executeQuery(QR03);
  if (R03.next()) {
    nbproject=R03.getInt("COUNT(PROJECTID)");
  }
  STR03.close();
  return(nbproject);
}

public int programNB (String portid) throws Exception {
  int nbprogram=0;
  Statement STR04 = portfolioConnection.createStatement();
  String QR04 = "SELECT COUNT(PROGRAMID) FROM PGMPOR WHERE PORTFOLIOID='"+portid+"'";
  ResultSet R04 = STR04.executeQuery(QR04);
  if (R04.next()) {
    nbprogram=R04.getInt("COUNT(PROGRAMID)");
  }
  STR04.close();
  return(nbprogram);
}

public int productNB (String portid) throws Exception {
  int nbproduct=0;
  Statement STR04 = portfolioConnection.createStatement();
  String QR04 = "SELECT COUNT(PRODUCTID) FROM PRDPOR WHERE PORTFOLIOID='"+portid+"'";
  ResultSet R04 = STR04.executeQuery(QR04);
  if (R04.next()) {
    nbproduct=R04.getInt("COUNT(PRODUCTID)");
  }
  STR04.close();
  return(nbproduct);
}

public int userNB (String portid) throws Exception {
  int nbaccess=0;
  Statement STR05 = portfolioConnection.createStatement();
  String QR05 = "SELECT COUNT(LOGIN) FROM USRPOR WHERE PORTFOLIOID='"+portid+"'";
  ResultSet R05 = STR05.executeQuery(QR05);
  if (R05.next()) {
    nbaccess=R05.getInt("COUNT(LOGIN)");
  }
  STR05.close();
  return(nbaccess);
}

public int groupNB (String portid) throws Exception {
  int nbgroup=0;
  Statement STR05 = portfolioConnection.createStatement();
  String QR05 = "SELECT COUNT(GROUPID) FROM GRPPOR WHERE PORTFOLIOID='"+portid+"'";
  ResultSet R05 = STR05.executeQuery(QR05);
  if (R05.next()) {
    nbgroup=R05.getInt("COUNT(GROUPID)");
  }
  STR05.close();
  return(nbgroup);
}


   
}
 
