
<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

        <%
        
        String product=request.getParameter("product");
        int q=Integer.parseInt(request.getParameter("q"));

        String p=request.getParameter("p");

        try {            
            Item_1 I=new Item_1(product,q);
            Cart_1 temp=(Cart_1)session.getAttribute("ordercart");
            if(temp==null){
            Cart_1 c =new Cart_1(I,p);
            session.setAttribute("ordercart", c);
            }else{
            temp.updateParty(p);
            temp.add(I);
            }
        }
   catch(NumberFormatException ex){
                        out.print("<h2 align='center' style='background-color: firebrick; color: white;'>Invalid Input</h2>");
                        }catch (Exception ex) {
                            out.print(ex);
                        }
        
        %>
        <jsp:include page="displaycart.jsp"></jsp:include>