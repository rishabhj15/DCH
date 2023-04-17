 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

        <%
        String q=request.getParameter("q");
        
        Connection cn = null;
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());


                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();

                            ResultSet rs1=st1.executeQuery("Select quantity from covtype where id="+q+" ");
                            rs1.next();
                            out.print(rs1.getString(1));
                                                   } catch (Exception ex) {
                            out.println(ex);
                        }finally {
                        	  try{
                      			cn.close();
                      		}catch(Exception ex){
                      			ex.printStackTrace();
                      		}
                          }
        %>
