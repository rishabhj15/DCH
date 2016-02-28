
<%@page import="session.Item_1"%>
<%@page import="mybean.Conf"%>
<%@page import="java.sql.*"%>
<%@page import="session.Cart_1"%>
<%@page import="session.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page import="session.Cart"%>
<style>
    .viewcart td,th{
        padding-left: 5px;
        padding-right: 5px;
    }
</style>
<%
            try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            ResultSet rs=null;
                            ResultSet rs1=null;
                            Cart_1 newCart=(Cart_1)session.getAttribute("ordercart");
                            
            if(newCart!=null){
            ArrayList al=newCart.get();
            int i=al.size();
            if(i!=0){
                rs1=st1.executeQuery("Select name,addr from party where id="+newCart.getParty());
                            rs1.next();
            String row="odd";
            out.print("<input id='cparty' name='cparty' type=hidden value="+newCart.getParty()+">");
            out.print("<table border=1 style='border-collapse:collapse;' >"
                    + "<tr id=partyname><th colspan=8 align=left >"+rs1.getString(1)+", "+rs1.getString(2)+"</th></tr>"
                    + "<tr id=headr><th>Sn</th><th>Particular</th><th>Total</th><th>Available</th><th>Bundle</th><th>Loose</th><th>Size</th><th><img id='zoomimg1' src=images/cartimages/remove.png width=58 width=48 onclick='removeAll()' ></th></tr>");
            int bundlet=0,looset=0,totalt=0;
            String highl="";
            for(int j=0;j<i;j++){
                if(j%2==0){
                row="even";
                }else{
                row="odd";
                }
                Item_1 k=(Item_1)al.get(j);
                rs=st.executeQuery("Select * from stockwithid where id="+k.getProduct());
                rs.next();
                int q=k.getQ();
                int s=rs.getInt(5);
                int b=q/s;
                int l=q%s;
                /*if(l>=s){
                b=b+l/s;
                l=l%s;
                }*/
                if(rs.getInt("net_quantity")<q){
                highl="redon";
                }else{
                highl="";
                }
                out.print("<tr class='viewcart' id="+highl+">"
                        + "<td>"+(j+1)+"</td> <td>");%>
                        
                            <%out.print(rs.getString(2)+"<input type=hidden name=proid value="+rs.getString(1)+"> "+rs.getString(3)+"</td>"
                        + "<td><input size=5 style='text-align:right;' value='"+q+"' onchange=updatecart('"+rs.getString(1)+"')  name='total' id='t"+rs.getString(1)+"' type=text></td>"
                        + "<td>"+rs.getInt("net_quantity")+"<input type=hidden name=avl value='"+rs.getInt("net_quantity")+"'></td>"
                        + "<td align='right'><input name='bundle' value='"+b+"' type=hidden>"+b+"</td>"
                        + "<td align='right'><input name='loose' value='"+l+"' type=hidden>"+l+"</td>"
                        + "<td align='right'><input name='bsize' value='"+rs.getInt("Size")+"' type=hidden>"+rs.getInt("Size")+"</td>"
                        + "<td align=center id='interf' ><img id='zoomimg' alt='Remove' src=images/cartimages/remove.png width=35 width=35  onclick='remove_1("+j+")'> </td></tr>");
                
            rs.close();
            bundlet=bundlet+b;
            looset=looset+l;
            k=null;
            totalt++;
            }
            out.print("<tr class='viewcart'><td><b>"+totalt+"</b></td><td><b>Total</td><td align=right><b>"+bundlet+"</b></td><td align=right><b>"+looset+"</b></td><td align=right colspan=4><b>Parcel: </b><input type text name=parcel size=5 value=1 accesskey='p'></td></tr>"
                    + "<tr id='headr'><th align='center' colspan=4><span id='msg' style='background-color: firebrick; color: white;' ></span></th><th colspan=2 align=center><input type=button id='but1' onclick='OnButton1();' value='Save Order' accesskey='o'> </th><th colspan=2><input type=button id='but2' onclick='OnButton2();' value='Dispatch' accesskey='i' align='center'></th></tr>");
            out.print("</table>");
            }else{
            out.print("<table><tr id=headr ><td>Cart Empty. <span id=ref></span></td></tr></table>");
            }
            }
            else{
            out.print("<table><tr id=headr ><td>Cart Empty. <span id=ref></span></td></tr></table>");
            }
            }catch(Exception ex){
            out.print(ex);
            }
            
%>
<br></br>
<div align="center" id="helptext">
                                alt+s for <b>S</b>earch Box<br/>
                                alt+r for Search <b>R</b>esults<br/>
                                alt+q for <b>Q</b>uantity<br/>
                                alt+a for <b>A</b>dd to Cart<br/>
                                <hr>
                                alt+p for <b>P</b>arcel<br/>
                                alt+i for d<b>I</b>spatch<br/>
                                alt+o for Save <b>O</b>rder<br/>
    
</div>