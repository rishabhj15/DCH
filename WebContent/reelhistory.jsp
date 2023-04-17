 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

        <%
        String q=request.getParameter("id");
        out.print(""+q+"");
        Connection cn = null;
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps = cn.prepareStatement("select * from ream as A,papersize as B,rulling as C,contractor as D where pid="+q+" and A.psize=B.id and A.rulling=C.id and A.contractor=D.id");
                            ResultSet rs = ps.executeQuery();
                            Statement st=cn.createStatement();
                            ResultSet rs1=null;

                            int i=0;
                            while(rs.next()){
                                i++;
                            
                            out.print("<table><tr>"
                                    + "<tr>"
                                    + "<table><tr>"
                                     + "<th>Date</th><th>Papersize</th><th>Rulling</th><th>Contractor</th><th>Quantity</th></tr>"
                                        + "<tr><td align='center' >"+rs.getString("A.dat")+"</td>"
                                    //+ "<td>"+rs.getString("A.id")+"</td></tr>"
                                        + "<td align='center'>"+rs.getString("B.type")+"</td>"
                                        + "<td align='center'>"+rs.getString("C.type")+"</td>"
                                        + "<td align='center'>"+rs.getString("D.name")+"</td>"
                                        + "<td align='center'>"+rs.getString("A.quantity")+"</td></tr></table></tr></table>");
                            }
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
