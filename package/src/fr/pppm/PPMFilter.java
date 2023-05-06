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

public class PPMFilter {

Connection filterConnection;

public PPMFilter (Connection Conn) {
  filterConnection=Conn;
}


public String getFilterValue(String filter,String login) throws Exception {
  Statement st = filterConnection.createStatement();
  String q = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+login+"' AND FILTERNAME='"+filter+"'";
  ResultSet r = st.executeQuery(q);
  if (r.next()) {
    return(r.getString("FILTERVALUE"));
  } else {
    return null;
  }
}

public void setFilterValue(String filter,String login,String filtervalue) throws Exception {
  Statement st = filterConnection.createStatement();
  String q = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+login+"' AND FILTERNAME='"+filter+"'";
  ResultSet r = st.executeQuery(q);
  if (r.next()) {
    Statement sti = filterConnection.createStatement();
    String i = "UPDATE FILTER SET FILTERVALUE='"+filtervalue+"' WHERE LOGIN='"+login+"' AND FILTERNAME='"+filter+"'";
    sti.executeUpdate(i);
    sti.close();
  } else { 
    Statement sti = filterConnection.createStatement();
    String i = "INSERT INTO FILTER VALUES('"+login+"','"+filter+"','"+filtervalue+"')";
    sti.executeUpdate(i);
    sti.close();
  }
}

}
