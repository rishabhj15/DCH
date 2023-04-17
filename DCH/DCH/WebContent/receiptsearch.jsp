 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
        <%
        String q=request.getParameter("q");
        Connection cn = null;
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps = cn.prepareStatement(q);
                            ResultSet rs = ps.executeQuery();
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            ResultSet rs1=null;
                            ResultSet rs2=null;
                            int i=0,k=0,j=0,l=0;
                            out.print("*Mouseover for details.");
                            out.print("<table id='asform' ><tr><th>Sno.</th><th>Tran<br/>No.</th><th>Receipt<br/> No</th><th>Date</th><th>Party</th><th>Items</th><th>Parcel</th><th>Local Transporter</th><th>Transport</th><th>Action</th></tr>");
                            String temp[],temp1[],t;
                            while(rs.next()){
                                i++;
                                rs1=st.executeQuery("Select * from party where id="+rs.getString("party"));
                                rs2=st1.executeQuery("Select count(*) from dispatch where tid="+rs.getInt("id"));
                                rs1.next();
                                rs2.next();
                                String sta="";
                                if(rs1.getString("sta").equals("d")){sta=" (Deleted Party)";}
                                temp=rs1.getString(6).split(",");
                                if(i%2==0){
                                out.println("<tr id=odd1>");
                                }else{
                                out.println("<tr id=even1>");
                                }
                            out.println("<td>"+i+"</td><td>"+rs.getInt("id")+"</td><td>"+rs.getInt("showid")+"</td><td>"+rs.getString("dat")+"</td><td>"+rs1.getString(2)+" "+rs1.getString(3)+sta+"</td><td align='right'>"+rs2.getInt(1)+"</td><td align=center><input size=3 value="+rs.getString("noparcel")+" id='p"+rs.getInt("id")+"'/></td>"
                                    + "<td align=center><input size=10 value='"+rs.getString("localtrans")+"' id='ltn"+rs.getInt(1)+"'/></td>"
                                    + "<td align=center><input size=10 value="+rs.getString("Treceipt")+" id='t"+rs.getInt("id")+"'/>*");
                            l=l+Integer.parseInt(rs.getString("noparcel"));
                            if(rs1.getString(6).equals("")){
                            out.print("<input type=text value='"+rs.getString("tname")+"' size=10 id=tn"+rs.getInt("id")+">");
                            }else{
                            out.print("<select style='width:10em;' id=tn"+rs.getInt("id")+">");
                            for(j=0;j<temp.length;j++){
                            out.print("<option  ");
                            if(rs.getString("tname").equals(temp[j])){
                            out.print("selected");
                            }
                            out.print("  value="+temp[j]+">"+temp[j]+"</option>");
                            }
                            out.print("</select>");
                            }
                            out.println("&nbsp;<input type=button value='Update' onclick='updatetransact("+rs.getInt("id")+")' ></td><td align=right><a target='_blank' href='printreceipt.jsp?id="+rs.getInt("id")+"'><img src='print.png' width=20 height='20' ></a></td></tr>");
                            k=k+rs2.getInt(1);
                            }
                            out.print("<tr><th colspan=2 align=left>"+i+" reciepts</th><th colspan=3 align=right>Total: "+k+"</th><th>"+l+"</th><th colspan=4></th>");
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