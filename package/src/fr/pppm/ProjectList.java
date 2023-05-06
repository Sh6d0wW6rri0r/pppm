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

public class ProjectList {

Connection projectConnection;
String query;
Vector prjlist = new Vector();

public ProjectList (Connection Conn,String q) throws Exception {
  projectConnection=Conn;
  prjlist= new Vector();
  query = q;
  this.refresh();
}

public void refresh() throws Exception {
  prjlist=new Vector();
  Statement st12 = projectConnection.createStatement();
  ResultSet r12 = st12.executeQuery(query);
  while (r12.next()) {
    prjlist.add(new Project(projectConnection,r12.getString("ID"))); 
  }
  st12.close();
}

public Vector getProjectList() {
  return prjlist;
}

public Project getProjectItem(int i) {
  return (Project)prjlist.elementAt(i);
}

public int length() {
  return prjlist.size();
}
}
