 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

<%
String q=request.getParameter("q");
String q1=request.getParameter("q1");
//String q4=request.getParameter("q4");
//out.print(q);
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            ResultSet rs= st.executeQuery(q);
                            ResultSet rs1=null;
                            
                            out.print("<br><table align='center' width=100% ><tr><td>Binding Labour</td></tr></table><table align='right' width=100% id='asform'><tr>"
                                    + "<th>Date</th><th>Notebook</th><th>Ream <br>Quantity</th>");
                            out.print("<th>Proposed <br>Quantity</th><th>Processed <br>Quantity</th><th>Binding <br>Quality</th><th>Rate</th><th>Amount</th></tr>");
                            
                            float quantity=0;
                            int notebookq=0;
                            int notebookpq=0;
                            int t=0;int ti=0;String r="";
                            while(rs.next()){
                                t++;
                                if(t%2==0){
                                r="odd";
                                }else{
                                r="even";
                                }
                                ti=t;
                                rs1=st1.executeQuery("Select * from Notebook as A,Covtype as B,Rulling as C where A.id="+rs.getString("bindquantid")+" and A.name=B.id and A.pno=C.id");
                                rs1.next();
                            out.print("<tr id="+r+" ><td>"+rs.getDate("dat")+"</td><td align='center' >"+rs1.getString("B.name")+"<br>"+rs1.getString("C.type")+"</td><td align='right' >"+rs.getFloat("quantity")+"</td>");
                            
                                out.print("<input type=hidden value='"+rs.getFloat("notebookpq")+"' id='b"+t+"'>");
                            out.print("<td align='right'>"+rs.getString("notebookq")+"</td>");
                            out.print("<td align='right'>"+rs.getString("notebookpq")+"</td>");
                            out.print("<td align='center'>"+rs.getString("B.name")+"</td>");
                            out.print("<td align='right'><input type=text style='text-align: right;' value='"+rs.getString("B.rate")+"' id='r"+t+"' size='4'></td><td align='right'><input type=text  id='amt"+t+"' tabindex='-1' style='text-align: right;' readonly size='20'></td>");
                            notebookq=notebookq+rs.getInt("notebookq");
                            notebookpq=notebookpq+rs.getInt("notebookpq");
                            
                            out.print("</tr>");
                            quantity=quantity+rs.getFloat("quantity");
                            }
                            
                            out.print("  <tr><td colspan='8' align=right><input type='button' id='but' value='Calculate' onclick='calcont("+t+")'/></td></tr>");
                            
                            out.print(" <tr style='background-color: #3882C7;color: #fafafa;' ><th colspan='2' align=left >Total</th><td align=right>"+quantity+"</td>");
                            
                            out.print("<td align='right'>"+notebookq+"</td>"

                                    + "<td align='right'>"+notebookpq+"</td><td></td><td colspan='2' align='right'><input type=text id='total' style='text-align: right;' size='15'></td></tr></table>");
                            rs= st.executeQuery(q1);
                            out.print("<br><table align='center' width=100% ><tr><td><br>Binding Material</td></tr></table><table align='right' width=100% id='asform'><tr>"
                                    + "<th>Date</th><th>Material</th><th>Quantity</th>");
                            out.print("<th>Unit Price</th><th>Amount</th></tr>");
                            t=0;while(rs.next()){
                                t++;
                                if(t%2==0){
                                r="odd";
                                }else{
                                r="even";
                                }
                            out.print("<tr id="+r+" ><td align='center'>"+rs.getString("A.dat")+"</td>"+"<td align='center'>"+rs.getString("B.name")+"</td>"+"<td align='right'><input type=hidden id='bq"+t+"' value='"+rs.getString("A.quantity")+"'>"+rs.getString("A.quantity")+"</td>"+"<td align=right><input type=text id=bprice"+t+" style='text-align: right;' size=9 value="+rs.getString("B.rate")+"></td><td align=right><input type=text style='text-align: right;' readonly size='20' id='bamt"+t+"' ></td></tr>");

                            }
                            
                            out.print("  <tr><td colspan='5' align=right><input type='button' id='but' value='Calculate' onclick='bmat("+t+","+ti+")'/></td></tr>");
                            out.print("  <tr><th colspan='4' align=left>Total</th><th style='padding-right:5px;'  align=right><input type=text id='btotal' style='text-align: right;' readonly size='20' value=''></th></tr></table>");
                            out.print("<br><table align='left' width=100% ><tr><td><hr></td></tr><tr><td>Summary</td></tr></table>"
                                    + "<table width=100% id='asform' align=right>"
                                    + "<tr id=odd><td align=right>Labour Charges:</td><td align=right><input type=text id='labt' style='text-align: right;' size=10 value=0></td></tr>"
                                    + "<tr id=odd><td align=right>Material Charges:<td align=right><input type=text id='matt' style='text-align: right;' size=10 value=0></td></tr>"
                                    + "<tr><th align=right>Difference:</th><th align=right><input type=text id='diff' style='text-align: right;' size=10 value=0></th></tr></table>");
} catch (Exception ex) {
                            out.println(ex);
                        }

%>

