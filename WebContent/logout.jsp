<%--
    Document   : logout
    Created on : Aug 24, 2010, 2:28:18 AM
    Author     : Rishabh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="session.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Log Out.</title>
    </head>
    <body >
        <%
        session.invalidate();
        response.sendRedirect("index.jsp");
        %>
        <p align="center">
        <h2 align="center" style="font-family: verdana; color: dodgerblue;">Session Ended. Please Login Again.</h2>
        <h3 align="center"><a href="index.jsp">Home</a></h3>
    </body>
</html>
