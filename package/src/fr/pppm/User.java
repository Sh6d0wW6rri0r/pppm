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

public class User {

  Connection userConnection;

  public User (Connection Conn) {
    userConnection=Conn;
  }

  public boolean isAuthenticated (String user,String passwd) throws Exception {
    Statement STR02 = userConnection.createStatement();
    String QR02 = "SELECT * FROM USERS WHERE LOGIN='"+user+"'";
    ResultSet R02 = STR02.executeQuery(QR02);
    boolean is_auth_local = false;
    String UserDIS = "";
    if (R02.next()) {
      if (R02.getString("LDAPLOGIN").equals("LOCAL")) {
        if (passwd.equals(R02.getString("PWD"))) {
          is_auth_local=true;
          UserDIS=R02.getString("DISABLED");
        }
      }
    }
    STR02.close();
    return is_auth_local;
  }

  public boolean isDisabled (String user) throws Exception {
    Statement STR02 = userConnection.createStatement();
    String QR02 = "SELECT * FROM USERS WHERE LOGIN='"+user+"'";
    ResultSet R02 = STR02.executeQuery(QR02);
    String UserDIS = "";
    if (R02.next()) {
      UserDIS=R02.getString("DISABLED");
    }
    STR02.close();
    boolean isdis = false;
    if (UserDIS.equals("Y")) {
      isdis=true;
    }
    return isdis;
  }

  public boolean hasRole(String user, String right) throws Exception {
    boolean isok=false;
    Statement st130 = userConnection.createStatement();
    String q130 = "SELECT LOGIN FROM USER_RIGHT WHERE LOGIN='"+user+"' AND USERRIGHT='"+right+"'"; 
    ResultSet r130 = st130.executeQuery(q130);
    if (r130.next()) {
      isok=true;
    }
    st130.close();
    if (!isok) {
      Statement st131 = userConnection.createStatement();
      String q131 = "SELECT GROUPID FROM GROUP_RIGHT WHERE GROUPID IN (SELECT GROUPID FROM GROUP_USER WHERE LOGIN='"+user+"') AND USERRIGHT='"+right+"'";
      ResultSet r131 = st131.executeQuery(q131);
      if (r131.next()) {
        isok=true;
      }
      st131.close(); 
    }
    return isok;
  }
 
  public boolean hasPortfolioAccess(String user,String portid) throws Exception {
    boolean isok=false;
    Statement st130 = userConnection.createStatement();
    String q130 = "SELECT LOGIN FROM USRPOR WHERE LOGIN='"+user+"' AND PORTFOLIOID='"+portid+"'";
    ResultSet r130 = st130.executeQuery(q130);
    if (r130.next()) {
      isok=true;
    }
    st130.close();
    if (!isok) {
      Statement st131 = userConnection.createStatement();
      String q131 = "SELECT GROUPID FROM GRPPOR WHERE GROUPID IN (SELECT GROUPID FROM GROUP_USER WHERE LOGIN='"+user+"') AND PORTFOLIOID='"+portid+"'";
      ResultSet r131 = st131.executeQuery(q131);
      if (r131.next()) {
        isok=true;
      }
      st131.close();
    }
    return isok;
  }

  public boolean hasProjectAccess(String user,String projectid) throws Exception {
    boolean isok=false;
    Statement st130 = userConnection.createStatement();
    String q130 = "SELECT LOGIN FROM USRPOR WHERE LOGIN='"+user+"' AND PORTFOLIOID IN (SELECT PORTFOLIOID FROM PRJPOR WHERE PROJECTID='"+projectid+"')";
    ResultSet r130 = st130.executeQuery(q130);
    if (r130.next()) {
      isok=true;
    }
    st130.close();
    if (!isok) {
      Statement st131 = userConnection.createStatement();
      String q131 = "SELECT GROUPID FROM GRPPOR WHERE GROUPID IN (SELECT GROUPID FROM GROUP_USER WHERE LOGIN='"+user+"') AND PORTFOLIOID IN (SELECT PORTFOLIOID FROM PRJPOR WHERE PROJECTID='"+projectid+"')";
      ResultSet r131 = st131.executeQuery(q131);
      if (r131.next()) {
        isok=true;
      }
      st131.close();
    }
    return isok;
  }

  public boolean hasProductAccess(String user,String productid) throws Exception {
    boolean isok=false;
    Statement st130 = userConnection.createStatement();
    String q130 = "SELECT LOGIN FROM USRPOR WHERE LOGIN='"+user+"' AND PORTFOLIOID IN (SELECT PORTFOLIOID FROM PRDPOR WHERE PRODUCTID='"+productid+"')";
    ResultSet r130 = st130.executeQuery(q130);
    if (r130.next()) {
      isok=true;
    }
    st130.close();
    if (!isok) {
      Statement st131 = userConnection.createStatement();
      String q131 = "SELECT GROUPID FROM GRPPOR WHERE GROUPID IN (SELECT GROUPID FROM GROUP_USER WHERE LOGIN='"+user+"') AND PORTFOLIOID IN (SELECT PORTFOLIOID FROM PRDPOR WHERE PRODUCTID='"+productid+"')";
      ResultSet r131 = st131.executeQuery(q131);
      if (r131.next()) {
        isok=true;
      }
      st131.close();
    }
    return isok;
  }
  public boolean hasApplicationAccess(String user,String applicationid) throws Exception {
    boolean isok=false;
    Statement st130 = userConnection.createStatement();
    String q130 = "SELECT LOGIN FROM USRPOR WHERE LOGIN='"+user+"' AND PORTFOLIOID IN (SELECT PORTFOLIOID FROM APPPOR WHERE APPLICATIONID='"+applicationid+"')";
    ResultSet r130 = st130.executeQuery(q130);
    if (r130.next()) {
      isok=true;
    }
    st130.close();
    if (!isok) {
      Statement st131 = userConnection.createStatement();
      String q131 = "SELECT GROUPID FROM GRPPOR WHERE GROUPID IN (SELECT GROUPID FROM GROUP_USER WHERE LOGIN='"+user+"') AND PORTFOLIOID IN (SELECT PORTFOLIOID FROM APPPOR WHERE APPLICATIONID='"+applicationid+"')";
      ResultSet r131 = st131.executeQuery(q131);
      if (r131.next()) {
        isok=true;
      }
      st131.close();
    }
    return isok;
  }

  public boolean hasProgramAccess(String user,String programid) throws Exception {
    boolean isok=false;
    Statement st130 = userConnection.createStatement();
    String q130 = "SELECT LOGIN FROM USRPOR WHERE LOGIN='"+user+"' AND PORTFOLIOID IN (SELECT PORTFOLIOID FROM PGMPOR WHERE PROGRAMID='"+programid+"')";
    ResultSet r130 = st130.executeQuery(q130);
    if (r130.next()) {
      isok=true;
    }
    st130.close();
    if (!isok) {
      Statement st131 = userConnection.createStatement();
      String q131 = "SELECT GROUPID FROM GRPPOR WHERE GROUPID IN (SELECT GROUPID FROM GROUP_USER WHERE LOGIN='"+user+"') AND PORTFOLIOID IN (SELECT PORTFOLIOID FROM PGMPOR WHERE PROGRAMID='"+programid+"')";
      ResultSet r131 = st131.executeQuery(q131);
      if (r131.next()) {
        isok=true;
      }
      st131.close();
    }
    return isok;
  }


  public void addUser(String login,String name,String forname,String ldaplogin,String disabled,String mail) throws Exception {
    Statement sti2 = userConnection.createStatement();
    String i2 = "INSERT INTO USERS VALUES('"+login+"','"+name+"','"+forname+"','"+ldaplogin+"','"+disabled+"','"+mail+"','')";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  public void modifyUser(String login,String name,String forname,String ldaplogin,String disabled,String mail) throws Exception {
    Statement sti2 = userConnection.createStatement();
    String i2 = "UPDATE USERS SET NAME='"+name+"',FORNAME='"+forname+"',LDAPLOGIN='"+ldaplogin+"',DISABLED='"+disabled+"',MAIL='"+mail+"' WHERE LOGIN='"+login+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  public int profileNB(String login) throws Exception{
    int nbprofile = 0;
    Statement st131 = userConnection.createStatement();
    String q131 = "SELECT COUNT(USERRIGHT) FROM USER_RIGHT WHERE LOGIN='"+login+"'";
    ResultSet r131 = st131.executeQuery(q131);
    if (r131.next()) {
      nbprofile=r131.getInt("COUNT(USERRIGHT)");
    }
    st131.close();
    return(nbprofile);
  }

  public int groupNB(String login) throws Exception {
    int nbgroup = 0;
    Statement st132 = userConnection.createStatement();
    String q132 = "SELECT COUNT(GROUPID) FROM GROUP_USER WHERE LOGIN='"+login+"'";
    ResultSet r132 = st132.executeQuery(q132);
    if (r132.next()) {
      nbgroup=r132.getInt("COUNT(GROUPID)");
    }
    st132.close();
    return (nbgroup);
  }

  public void addGroup(String login, String groupid) throws Exception{
    Statement sti2 = userConnection.createStatement();
    String i2 = "INSERT INTO GROUP_USER VALUES ('"+groupid+"','"+login+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  }
 
  public void deleteGroup(String login, String groupid) throws Exception {
    Statement sti2 = userConnection.createStatement();
    String i2 = "DELETE FROM GROUP_USER WHERE GROUPID='"+groupid+"' AND LOGIN='"+login+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  public void addRight(String login, String right) throws Exception {
    Statement sti2 = userConnection.createStatement();
    String i2 = "INSERT INTO USER_RIGHT VALUES ('"+login+"','"+right+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  public void deleteRight(String login, String right) throws Exception {
    Statement sti2 = userConnection.createStatement();
    String i2 = "DELETE FROM USER_RIGHT WHERE USERRIGHT='"+right+"' AND LOGIN='"+login+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }
 
}
