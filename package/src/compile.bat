@echo off
echo Compiling the package for PPPM.FR
cd C:\Users\omoulin\Coding\ThorPPM\package\src
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -cp ..\..\WEB-INF\lib\jdom.jar -d ..\class .\fr\pppm\Planning.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -cp ..\..\WEB-INF\lib\jdom.jar -d ..\class .\fr\pppm\ProductPlanning.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\PPPMTools.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\Program.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\PPMFilter.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\Group.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\Portfolio.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\Project.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\ProjectList.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\Product.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\ProductList.java
"C:\Program Files"\Java\jdk1.7.0_51\bin\javac -d ..\class .\fr\pppm\User.java
cd C:\Users\omoulin\Coding\ThorPPM\package\class
"c:\Program Files\7-Zip"\7z a pppmfr.zip fr
move pppmfr.zip pppmfr.jar
copy pppmfr.jar C:\Users\omoulin\Coding\ThorPPM\WEB-INF\lib
pause