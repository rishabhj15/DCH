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

            try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            ResultSet rs=null;
                            ResultSet rs1=null;
                            rs1=st.executeQuery("Select name,addr from party where id="+pid);
                            rs1.next();

                            
            out.print("<form action='processorder.jsp' onsubmit='return checkvals()' method=post >");
            out.print("<input id='party' name='party' type=hidden value="+pid+">");

            out.print("<table border=1 style='border-collapse:collapse;'>"
                    + "<tr><th colspan=2>Order No: "+oid+"</th><th colspan=5>"+rs1.getString(1)+", "+rs1.getString(2)+"</th></tr>"
                    + "<tr id=headr><th>S No</th><th>Particular</th><th>Bundle</th><th>Loose</th><th>Size</th><th>Bundle</th><th>Loose</th></tr>");
            
                rs=st1.executeQuery("SELECT * from order_vs_avl where order_id="+oid+" order by item_id");
                int j=0;
                while(rs.next()){
                    j++;
                out.print("<tr>"
                        + "<td>"+(j)+"</td>"
                        + "<td>"+rs.getString("product")+"<input type=hidden name=oid value="+oid+">"+"<input type=hidden name=proid value="+rs.getString("proid")+">"+rs.getString("rulling")+"</td>"
                        + "<td><input size=5 style='text-align:right;' name='bundle' value='"+rs.getInt("b_order")+"' type=text></td>"
                        + "<td><input size=5 style='text-align:right;' name='loose' value='"+rs.getInt("l_order")+"' type=text></td>"
                        + "<td><input size=5 style='text-align:right;' readonly name='bsize' tabindex=-1 value='"+rs.getInt("s_avl")+"' type=text></td>"
                        + "<td><input size=5 style='text-align:right;' name='loose' value='"+rs.getInt("b_avl")+"' type=text></td>"
                        + "<td><input size=5 style='text-align:right;' name='loose' value='"+rs.getInt("l_avl")+"' type=text></td></tr>");
                }
                           rs.close();
            
            //out.print("<tr><td><b>"+totalt+"</b></td><td><b>Total</td><td align=right><b>"+bundlet+"</b></td><td align=right><b>"+looset+"</b></td><td></td><td/></tr><tr><td align='center' colspan=4><span id='msg' style='background-color: firebrick; color: white;' ></span></td><td colspan=2 align=right><input type=submit value='Save Order'></td></tr>");

            out.print("</table><input type=submit value=Submit></input></form>");
            
            }catch(Exception ex){
            out.print(ex);
            }
%>