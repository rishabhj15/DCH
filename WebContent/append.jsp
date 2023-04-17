 <%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

        <%
        String nb=request.getParameter("nb");
        String pro=request.getParameter("pro");
        String l=request.getParameter("l");
        String b=request.getParameter("b");
        String li=request.getParameter("li");
        String se=request.getParameter("se");
        String size=request.getParameter("size");
        
        try {
            int s=Integer.parseInt(b)*Integer.parseInt(size)+Integer.parseInt(l);
            Item I=new Item(se,nb,li,b,l,size,s,pro);
            Cart temp=(Cart)session.getAttribute("cart"+se);
            if(temp==null){
            Cart c =new Cart(I);
            session.setAttribute("cart"+se, c);
            }else{
            temp.add(I);
            }
        }
   catch(NumberFormatException ex){
                        out.print("<h2 align='center' style='background-color: firebrick; color: white;'>Invalid Input</h2>");
                        }catch (Exception ex) {
                            out.print(ex);
                        }
        
        %>
        <jsp:include page="display.jsp"><jsp:param name="se" value="<%=se%>"></jsp:param> </jsp:include>