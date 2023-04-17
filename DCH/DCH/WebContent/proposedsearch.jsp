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
                            Statement st2= cn.createStatement();
                            Statement st3= cn.createStatement();
                            Statement st4= cn.createStatement();
                            Statement st5= cn.createStatement();
                            ResultSet rs= st.executeQuery("Select * from bind where contractor='"+q1+"' and sta='proposed' order by contractor");
                            ResultSet rs1=null;
                            ResultSet rs2=null;
                            ResultSet rs3=null;
                            out.print("<table align='right' id='asform'><tr><th>Contractor</th><th>Date</th><th>Notebook</th><th>Proposed</th><th align='left' >Total &nbsp; Cover &nbsp; Action</th>");
                            while(rs.next()){
                                rs1=st1.executeQuery("Select B.name,R.type from notebook A,covtype B,rulling R where A.id="+rs.getString("bindquantid")+" and A.name=B.id and A.pno=R.id");
                                rs1.next();
                                rs2=st2.executeQuery("Select * from contractor where id="+rs.getString("contractor"));
                                rs2.next();
                                rs3=st3.executeQuery("Select bsize from bindquant where notebook="+rs.getString("bindquantid"));
                                rs3.next();
                                ResultSet rs4=st4.executeQuery("select * from notebook where id="+rs.getString("bindquantid"));
                                rs4.next();
                                ResultSet rs5=st5.executeQuery("Select quantity from covtype where id="+rs4.getString(2)+" ");
                                rs5.next();
                            out.print("<tr id='even1'><td>"+rs2.getString("name")+"</td><td>"+rs.getDate("dat")+"</td><td>"+rs1.getString(1)+" "+rs1.getString(2)+"</td><td align='right' >"+rs.getString("notebookq")+"</td><td id='"+rs.getInt("id")+"' align=left ><form>"
                                    + "<input type=hidden id='quality"+rs.getString(1)+"' value='"+rs.getString("quality")+"'><input type=hidden id='psize"+rs.getString(1)+"' value='"+rs.getString("psize")+"'><input type=hidden id='rulling"+rs.getString(1)+"' value='"+rs.getString("rulling")+"'>"
                                    + "<input type=hidden id='notebook"+rs.getString(1)+"' value='"+rs.getString("bindquantid")+"'><input type=hidden id='bid"+rs.getString(1)+"'  value='"+rs.getString(1)+"'>"
                                    //+ " &nbsp;<input type='text' tabindex='"+rs.getString(1)+"' value='"+(rs.getInt("notebookq")/rs3.getInt("bsize"))+"' onfocus='checkcov("+rs.getString(1)+")'  onchange='calbun("+rs.getString(1)+")'  size='5' id='bundle"+rs.getInt(1)+"'> &nbsp;"
                                    //+ "<input type='text' tabindex='"+rs.getString(1)+"' value='"+(rs.getInt("notebookq")%rs3.getInt("bsize"))+"' onfocus='checkcov("+rs.getString(1)+")' onchange='calbun("+rs.getString(1)+")' size='5' id='loose"+rs.getInt(1)+"'>&nbsp;"
                                    //+ "<input type='text' tabindex='-1' size='2' id='bs"+rs.getString(1)+"' value='"+rs3.getInt("bsize")+"' readonly onkeyup='showmsg()' >  &nbsp; "
                                    //+ "<input type='text'  size='5' value='"+rs.getInt("notebookq")+"' tabindex='"+rs.getString(1)+"' onkeyup='calall("+rs.getString(1)+")' id='total"+rs.getInt(1)+"'><input type=hidden id=nbid"+rs.getInt(1)+" value='"+rs.getString("bindquantid")+"'><span id='covqu"+rs.getString(1)+"'></span> "
                                    + "<input type='text'  size='5' value='"+rs.getInt("notebookq")+"' tabindex='"+rs.getString(1)+"' id='total"+rs.getInt(1)+"'><input type=hidden id=nbid"+rs.getInt(1)+" value='"+rs.getString("bindquantid")+"'><span id='covqu"+rs.getString(1)+"'>"+rs5.getString(1)+"</span> "
                                    + "| <span id='proceed'>"
                                    + "<input type='button' id='proceed"+rs.getString(1)+"' tabindex='"+rs.getString(1)+"' onclick='submitbinded("+rs.getString(1)+")' value='Proceed'>"
                                    + "</span>"
                                    + "</form></td></tr>");
            }
} catch (Exception ex) {
                            out.println(ex.toString());
                        }
        finally {
        	  try{
      			cn.close();
      		}catch(Exception ex){
      			ex.printStackTrace();
      		}
          }

%>
