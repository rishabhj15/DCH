<%-- 
    Document   : datetest
    Created on : Oct 15, 2011, 3:02:45 PM
    Author     : Rishabh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
function ask(){

valid=true;
var r=confirm("Are you sure!");
if (r==true)
  {
  valid=true;
  }
else
  {
  valid=false;
  }
return valid;
}
    
            
        </script>
    </head>
    <body>
        <h1>Hello World!</h1>
<%java.util.Date d=new java.util.Date();
String date=d.toString();

%>
<a href="http://www.google.com" onclick="return ask()">Google</a>

    </body>
</html>
