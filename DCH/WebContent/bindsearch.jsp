 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

<%
String q1=request.getParameter("q1");
//String q3=request.getParameter("q3");
//String q4=request.getParameter("q4");
out.println("<hr><b>You queried for : </b>"+q1+"<hr>");
Connection cn = null;
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            ResultSet rs= st.executeQuery("Select * from bindquant where notebook="+q1);
                            ResultSet rs1=null;
                            out.print("<table align='right' id='asform'><tr><th>Quality</th><th>Rulling</th><th>Bundle</th><th>Loose</th>");
                            while(rs.next()){
                                rs1=st1.executeQuery("Select * from rulling where id="+rs.getString("rulling"));
                                rs1.next();
                            out.print("<tr><td>"+rs.getString("quality")+"</td><td>"+rs1.getString("type")+"</td><td>"+rs.getString("bundle")+"</td><td>"+rs.getString("loose")+"</td></tr>");
            }
} catch (Exception ex) {
                            //out.println(ex);
                        }finally {
                        	  try{
                      			cn.close();
                      		}catch(Exception ex){
                      			ex.printStackTrace();
                      		}
                          }

%>
