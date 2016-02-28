<%@page import="com.mysql.jdbc.exceptions.MySQLSyntaxErrorException"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%
String prod=request.getParameter("product");

try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            ResultSet rs = st.executeQuery("Select size,net_quantity,concat(product,' ',rulling) from stockwithid where id="+prod);
                            if(rs.next()){
                                int b=0,s=0,l=0,avl=0;
                                s=rs.getInt(1);
                                avl=rs.getInt(2);
                                
                                b=avl/s;
                                l=avl%s;
                                
                                out.print("<fieldset><legend>Availablity of "+rs.getString(3) +"</legend><table class='availablitydata'><tr><th>Bundle:</th><td>"+b+"</td></tr>");
                                out.print("<tr><th>Loose:</th><td>"+l+"</td></tr>");
                                out.print("<tr><th>Size:</th><td><div id='avlQty'>"+s+"</div></td></tr>");
                                out.print("<tr><th>Available:</th><td>"+avl+"</td></tr></table></fieldset>");
                            }else{
                                out.print("<fieldset><legend>Availablity</legend>Product Not Found.</fieldset>");
                            }
                            rs.close();
                            st.close();
                            cn.close();
                            
}catch(MySQLSyntaxErrorException e){
        out.print("<fieldset><legend>Availablity</legend>Invalid Product Id</fieldset>");
}
catch(Exception ex){
        out.print(ex);
        }
%>
