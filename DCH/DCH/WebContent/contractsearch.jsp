 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

<%
String q=request.getParameter("q");
String q1=request.getParameter("q1");
String tab=request.getParameter("t");
//String q4=request.getParameter("q4");
//out.println("<hr><b>You queried for : </b>"+q+"<hr>");

Connection cn = null;
        try {
            if(tab.equals("bind")){%>
            <jsp:include page="binder.jsp"><jsp:param name="q" value="<%=q%>"></jsp:param><jsp:param name="q1" value="<%=q1%>" ></jsp:param> </jsp:include>
            <%}else{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            Statement st2= cn.createStatement();
                            Statement st3= cn.createStatement();
                            ResultSet rs= st.executeQuery(q);
                            ResultSet rs1=null;
                            ResultSet rs2=null;
                            ResultSet rs3=null;
                            out.print("<br><table align='center' width=100% ><tr><td>Reaming Labour</td></tr></table>");
                            out.print("<table align='left' id='asform'><tr><th>Date</th><th>Quality</th><th>Size</th><th>Weight</th><th>Rulling</th><th>Ream Quantity</th>");
                            
                            float quantity=0;
                            float wt=0;
                            int notebookq=0;
                            int t=0;
                            while(rs.next()){
                                t++;
                                rs1=st1.executeQuery("Select * from rulling where id="+rs.getString("rulling"));
                                rs1.next();
                                rs2=st2.executeQuery("Select * from papersize where id="+rs.getString("psize"));
                                rs2.next();
                                rs3=st3.executeQuery("Select * from reel where id="+rs.getString("pid"));
                                rs3.next();
                            out.print("<tr><td>"+rs.getDate("dat")+"</td><td td align='left'>"+rs3.getString("quality")+"</td><td td align='center'>"+rs2.getString("type")+"</td><td td align='right'>"+rs3.getFloat("wt")+"</td><td align='right' >"+rs1.getString("type")+"</td><td align='right' >"+rs.getFloat("quantity")+"</td>");
                            
                            out.print("</tr>");
                            wt=wt+rs3.getFloat("wt");
                            quantity=quantity+rs.getFloat("quantity");
                            }
                            
                            out.print("<tr style='background-color: #3882C7;color: #fafafa;' ><th colspan='3'>Total</th><td align=right>"+wt+"</td><td colspan=2 align=right>"+quantity+"</td>");
                            
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

