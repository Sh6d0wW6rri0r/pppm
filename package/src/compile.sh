echo Compiling the package for PPPM.FR
echo Project class
/usr/bin/javac -cp ../../WEB-INF/lib/jdom.jar -d ../class ./fr/pppm/Project.java
echo Product class
/usr/bin/javac -cp ../../WEB-INF/lib/jdom.jar -d ../class ./fr/pppm/Product.java
echo PPMTools class
/usr/bin/javac -d ../class ./fr/pppm/PPPMTools.java
echo Program class
/usr/bin/javac -d ../class ./fr/pppm/Program.java
echo PPM Filter class
/usr/bin/javac -d ../class ./fr/pppm/PPMFilter.java
echo Group class
/usr/bin/javac -d ../class ./fr/pppm/Group.java
echo GroupList class
/usr/bin/javac -d ../class ./fr/pppm/GroupList.java
echo Portfolio class
/usr/bin/javac -d ../class ./fr/pppm/Portfolio.java
echo ProjectList class
/usr/bin/javac -cp ../../WEB-INF/lib/jdom.jar:. -d ../class ./fr/pppm/ProjectList.java
echo ProductList class
/usr/bin/javac -cp ../../WEB-INF/lib/jdom.jar:. -d ../class ./fr/pppm/ProductList.java
echo User class
/usr/bin/javac -d ../class ./fr/pppm/User.java
echo Employee class
/usr/bin/javac -d ../class ./fr/pppm/Employee.java
echo EmployeeList class
/usr/bin/javac -d ../class ./fr/pppm/EmployeeList.java
echo ProjectRiskAction class
/usr/bin/javac -d ../class ./fr/pppm/ProjectRiskAction.java
echo ProjectRiskActionList class
/usr/bin/javac -d ../class ./fr/pppm/ProjectRiskActionList.java
echo Application class
/usr/bin/javac -cp ../../WEB-INF/lib/jdom.jar:. -d ../class ./fr/pppm/Application.java
echo ApplicationList class
/usr/bin/javac -cp ../../WEB-INF/lib/jdom.jar:. -d ../class ./fr/pppm/ApplicationList.java
cd ../class
jar cvf pppmfr.jar fr/* 
cp pppmfr.jar ../../WEB-INF/lib  
cd ../src
