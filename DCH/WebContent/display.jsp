
<%@page import="session.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page import="session.Cart"%>
<%
            
            String se=request.getParameter("se");
            Cart newCart=(Cart)session.getAttribute("cart"+se);
            if(newCart!=null){
            ArrayList al=newCart.get();
            int i=al.size();
            if(i!=0){
            String row="odd";
                        out.print("<table id=display><tr id='headr'><th align=left id=reff colspan=3><span id=ref></span></div></th><td align=right colspan=4><input type=button value='Empty Cart' id='but' tabindex='-1' onclick='clearall("+se+")'> | <input type=button id='but' value='Dispatch' onclick='dispatch("+se+")'> </td></tr>");
                       out.print("<tr id=headr><th>S No</th><th>Particular</th><th>Bundle</th><th>Loose</th><th>Bundle Size</th><th>Total</th><th>Action</th></tr>");
            int bundlet=0,looset=0,totalt=0;
            for(int j=0;j<i;j++){
                if(j%2==0){
                row="even";
                }else{
                row="odd";
                }
            Item m=(Item)al.get(j);
            out.print("<tr id='"+row+"' ><td>"+(j+1)+"</td><td>");
            //out.print(m.getSE()+" ");
            out.print(m.getNB()+"</td><td align=right >");
            out.println(m.getB()+" </td><td align=right >");
            bundlet=bundlet+Integer.parseInt(m.getB());
            out.println(m.getL()+"</td><td align=right >");
            looset=looset+Integer.parseInt(m.getL());
            out.println(m.getSize()+"</td><td align=right >");
            out.println(m.getTotal()+"</td align=right >");
            totalt=totalt+m.getTotal();
            out.print("<td><input type=button value='Remove' id='but' onclick='remove("+se+","+j+")'> </td></tr>");
            }
            out.print("<tr id='headr'><td align=left colspan=2>"+i+" <i>Items Total</i></td><td align=right> <i>Total Bundles</i> "+bundlet+"</td><td align=right> <i>Total Loose </i>"+looset+"</td><td/><td align=right> <i>Total Count </i>"+totalt+"</td><td></td></tr>");
            out.print("<tr id='headr'><td align=right colspan=7><input type=button value='Empty Cart' id='but' onclick='clearall("+se+")'> | <input type=button id='but' value='Dispatch' onclick='dispatch("+se+")'> </td></tr></table>");
            }else{
            out.print("<table><tr id=headr ><td>Cart Empty. <span id=ref></span></td></tr>");
            }
            }else{
            out.print("<table><tr id=headr ><td>Empty Cart. <span id=ref></span></td></tr>");
            }
%>