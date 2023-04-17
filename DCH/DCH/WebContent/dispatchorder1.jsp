<%@page import="session.Item_1"%>
<%@page import="mybean.Conf"%>
<%@page import="java.sql.*"%>
<%@page import="session.Cart_1"%>
<%@page import="session.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page import="session.Cart"%>
<%
String oid=request.getParameter("oid");
String pid=request.getParameter("pid");
Connection cn = null;
            try {

            Cart_1 temp=(Cart_1)session.getAttribute("ordercart");
            if(temp!=null){temp.remove();temp.updateParty(pid);}

            


                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            ResultSet rs=null;
                            ResultSet rs1=null;
                            rs1=st.executeQuery("Select name,addr from party where id="+pid);
                            rs1.next();

                rs=st1.executeQuery("SELECT * from order_vs_avail where order_id="+oid+" order by item_id");

                               int j=0;

                while(rs.next()){
                    Item_1 I=new Item_1(rs.getInt("proid"),rs.getInt("net_order"));
                    if(temp==null){
                    temp = new Cart_1(I,pid);
                    session.setAttribute("ordercart", temp);
                    }else{
                    temp.add(I);
                    temp.updateParty(pid);
                    }
                               }
                           rs.close();

response.sendRedirect("order2.jsp?party="+pid+"&oid="+oid);
            }catch(Exception ex){
            out.print(ex);
            }finally {
            	  try{
          			cn.close();
          		}catch(Exception ex){
          			ex.printStackTrace();
          		}
              }
%>