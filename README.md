# PPPM
PPPM system, open-source
<br>This project was started a long time ago and the goal was to create a PPM system, the work there is huge, but the system is working and already covering a lot of PPM aspects.
<br>If you are interrested to work on it, please contact me, as I don't have time right now to work on it.
<br>Releasing as GNU Public License.
<br>In order to install it :
<br>Install tomcat and mysql on your server
<br>copy all the files in the tomcat webapps/pppm folder
<br>create a database and user in mysql
<br>copy the SQL/pppm.xml file in your tomcat/config folder, tweak it to reflect the user / database you have created on mysql
<br>connect to the following pages with your browser : 
<br>http://<your tomcat server>/pppm/createddb.jsp - to create the database structure
<br>http://<your tomcat server>/pppm/loaddemo.jsp - to fill some demo data
<br>You can then connect to your server using http://<your tomcat server>/pppm
<br>the default admin user is : user:admin / password:admin
<br>
<br>Enjoy :)
