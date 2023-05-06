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

public class ApplicationList {

Connection applicationConnection;
String query;
Vector applist = new Vector();

public ApplicationList (Connection Conn,String q) throws Exception {
  applicationConnection=Conn;
  applist= new Vector();
  query = q;
  this.refresh();
}

public void refresh() throws Exception {
  applist=new Vector();
  Statement st12 = applicationConnection.createStatement();
  ResultSet r12 = st12.executeQuery(query);
  while (r12.next()) {
    applist.add(new Application(applicationConnection,r12.getString("ID"))); 
  }
  st12.close();
}

public Vector getApplicationList() {
  return applist;
}

public Application getApplicationItem(int i) {
  return (Application)applist.elementAt(i);
}

public int length() {
  return applist.size();
}
}
