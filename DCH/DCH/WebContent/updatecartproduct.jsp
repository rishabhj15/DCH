
<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

        <%

        String product=request.getParameter("product");
        int q=Integer.parseInt(request.getParameter("q"));
        //int l=Integer.parseInt(request.getParameter("l"));
        String p=request.getParameter("p");

        //out.print("<td id='dispatch'>"+li+"</td><td id='dispatch'>"+nb+"</td><td id='dispatch'>"+b+"</td><td>"+l+"</td>");
        try {
            Item_1 I=new Item_1(product,q);
            Cart_1 temp=(Cart_1)session.getAttribute("ordercart");
            temp.update(I);
            out.print("Cart updated successfully.");
        }

                           // ResultSet rs = st.executeQuery("Select B.name,R.type from notebook as A,covtype as B,rulling as R where A.id="+nb+" and A.name=B.id and A.pno=R.id");

/*ResultSet rs1=null;
    int size =0;
    if (rs != null)
    {
      rs.beforeFirst();
      rs.last();
      size = rs.getRow();
      rs.beforeFirst();
    }
                            out.print("<table id='asform'><th colspan='10'>"+size+" Results Found</th></tr>");
                            out.print("<tr><th>Sno.</th><th>ID</th><th>Paper Type</th><th>Quality</th><th>Size</th><th>Wt</th><th>Entry</th><th>Status</th><th>Updated</th><th>Action</th></tr>");
                            int i=0;*/
                            /*if(rs.next()){
                                out.print(rs.getString(rs.getString(1)+" "+rs.getString(2)+" "+b+" "+l+" <div id='list'></div"));
                            }else{
                            out.print("Invalid Operation");
                            }
                            cn.close();*/
//                       }
   catch(NumberFormatException ex){
                        out.print("<h2 align='center' style='background-color: firebrick; color: white;'>Invalid Input</h2>");
                        }catch (Exception ex) {
                            out.print(ex);
                        }

        %>
        