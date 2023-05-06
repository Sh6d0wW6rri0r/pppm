package fr.pppm;

public class PPPMTools {

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


public PPPMTools () {
}

public boolean checknum(String str) {
  
  boolean isok=true;

  if (str.length()>10) {
    
    isok=false;
      
  } else {
        
    for (int it=0; it <str.length();it++) {
      if ((str.charAt(it)!='0') && (str.charAt(it)!='1') && (str.charAt(it)!='2') && (str.charAt(it)!='3') && (str.charAt(it)!='4') && (str.charAt(it)!='5') && (str.charAt(it)!='6') && (str.charAt(it)!='7') && (str.charAt(it)!='8') && (str.charAt(it)!='9') && (str.charAt(it)!='.')) {
        isok=false;
      }
    }
 
  }
  return isok;
    
}
 


public String checkStr(String str) {
  
  String insertok="";
  
  for (int it=0; it <str.length();it++) {
    if ((str.charAt(it)>='a') && (str.charAt(it)<='z')) {
      insertok=insertok+str.charAt(it);
    }
    if ((str.charAt(it)>='A') && (str.charAt(it)<='Z')) {
      insertok=insertok+str.charAt(it);
    }
    if ((str.charAt(it)>='0') && (str.charAt(it)<='9')) {
      insertok=insertok+str.charAt(it);
    }
    if ((str.charAt(it)==' ')) {
      insertok=insertok+" ";
    } 
    if ((str.charAt(it)=='\n')) {
      insertok=insertok+"\\\n";
    } 
    if ((str.charAt(it)=='\'')) {
      insertok=insertok+"''";
    }
    if ((str.charAt(it)==133)) {
      insertok=insertok+"&agrave;";
    }
    if ((str.charAt(it)==130)) {
      insertok=insertok+"&eacute;";
    }
    if ((str.charAt(it)==138)) {
      insertok=insertok+"&egrave;";
    }
    if ((str.charAt(it)==151)) {
      insertok=insertok+"&ugrave;";
    }
    if ((str.charAt(it)==147)) {
      insertok=insertok+"&ocirc;";
    }
    if ((str.charAt(it)==136)) {
      insertok=insertok+"&ecirc;";
    }
    if ((str.charAt(it)==128)) {
      insertok=insertok+"&euro;";
    }
    if ((str.charAt(it)==135)) {
      insertok=insertok+"&ccedil;";
    }
    if ((str.charAt(it)=='&')) {
      insertok=insertok+"&amp;";
    }
    if ((str.charAt(it)=='\"')) {
      insertok=insertok+"&quot;";
    }
    if ((str.charAt(it)=='\\')) {
      insertok=insertok+"\\\\";
    }
    if ((str.charAt(it)=='$')) {
      insertok=insertok+"$";
    }
    if ((str.charAt(it)=='*')) {
      insertok=insertok+"*";
    }
    if ((str.charAt(it)=='%')) {
      insertok=insertok+"%";
    }
    if ((str.charAt(it)=='/')) {
      insertok=insertok+"/";
    }
    if ((str.charAt(it)=='.')) {
      insertok=insertok+".";
    }
    if ((str.charAt(it)=='?')) {
      insertok=insertok+"?";
    }
    if ((str.charAt(it)==',')) {
      insertok=insertok+",";
    }
    if ((str.charAt(it)==';')) {
      insertok=insertok+";";
    }
    if ((str.charAt(it)==':')) {
      insertok=insertok+":";
    }
    if ((str.charAt(it)=='!')) {
      insertok=insertok+"!";
    }
    if ((str.charAt(it)=='|')) {
      insertok=insertok+"|";
    }
    if ((str.charAt(it)=='{')) {
      insertok=insertok+"{";
    }
    if ((str.charAt(it)=='}')) {
      insertok=insertok+"}";
    }
    if ((str.charAt(it)=='(')) {
      insertok=insertok+"(";
    }
    if ((str.charAt(it)==')')) {
      insertok=insertok+")";
    }
    if ((str.charAt(it)=='[')) {
      insertok=insertok+"{";
    }
    if ((str.charAt(it)==']')) {
      insertok=insertok+"}";
    }
    if ((str.charAt(it)=='~')) {
      insertok=insertok+"~";
    }
    if ((str.charAt(it)=='#')) {
      insertok=insertok+"#";
    }
    if ((str.charAt(it)=='=')) {
      insertok=insertok+"=";
    }
    if ((str.charAt(it)=='@')) {
      insertok=insertok+"@";
    }
    if ((str.charAt(it)=='-')) {
      insertok=insertok+"-";
    }
    if ((str.charAt(it)=='_')) {
      insertok=insertok+"_";
    }
    if ((str.charAt(it)=='<')) {
      insertok=insertok+"&lt;";
    }
    if ((str.charAt(it)=='>')) {
      insertok=insertok+"&gt;";
    }
  }
  
  return insertok;

}


  

}
