<%-- 
    Document   : printreceipt
    Created on : Dec 1, 2011, 5:25:44 PM
    Author     : Rishabh
--%>

<%@page import="mybean.Conf"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <style type="text/css">
#h3{
                padding: 0;
                font-weight: bold;
}
#tem{
    font-weight: normal;
    color: #60605d;
}
#headr{
    border: #7e98fc;
}
#main{
    border-width: 1px;
    border-style: solid;
}
#topl{
    border-width: 1px;
    border-style: solid;
    border-right-width: 0px;
}
#topr{
    border-width: 1px;
    border-style: solid;
    border-left-width: 0px;
}
#date{
    padding-top: 0.4em;
    padding-bottom: 0.4em;
    padding-left: 3em;
    padding-right: 3em;
    border-width: 1px;
    border-style: solid;
    font-style:  italic;
    font-weight: bold;
    
}
#date1{
    padding-left: 1em;
    padding-right: 3em;

    font-style:  italic;
    font-weight: bold;
    color: #60605d;

}
th,td{
    padding-left: 1em;
    padding-right: 1em;
}
#odd{
    background-color: #c7c4c7;
}
#even{
    background-color: #e8e7e8;
}
#row{
    font-weight: bold;
}
#adv{
    font-weight: normal;
    font-family: verdana;
    font-size: xx-small ;
}
        </style>
    
<%

            String id=request.getParameter("id");
			Connection cn = null;
            try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            Statement st2=cn.createStatement();
                            Statement st3=cn.createStatement();
                            Statement st4=cn.createStatement();
                            
                            ResultSet rs = st.executeQuery("Select * from dispatch where tid="+id);
                            ResultSet rs1 = st1.executeQuery("Select * from transact where id="+id);
                            rs1.next();
                            ResultSet rs2 = st2.executeQuery("Select * from party where id="+rs1.getString("party"));
                            ResultSet rs3 = st3.executeQuery("Select * from transact where party="+rs1.getString("party")+" order by id");
                            ResultSet rs4 = st4.executeQuery("Select * from party_hindi where pid="+rs1.getString("party"));
                            rs2.next();
                            
                            String name_hindi ="",address_hindi = "";
                            if(rs4.next()){
                            	name_hindi = rs4.getString("name_hindi");
                            	address_hindi = rs4.getString("address_hindi");
                            }
                            int recNo = -1;
                            if(rs1.getInt("showid")==0){
                            	recNo = rs1.getInt("id");
                            }else{
                            	recNo = rs1.getInt("showid");
                            }
                            %>
                            <title>
                                Receipt No: <%=recNo%>
                            </title>
    </head>
    <body>
        <%
        String preDate="";
        String preRec="";

        
        while(rs3.next()&&rs3.getInt(1)!=Integer.parseInt(id)){
            preDate="Prev Date: "+rs3.getString(3);
            if(rs3.getString(2)==null){
            	preRec=" | Receipt No: "+rs3.getString(1);
            }else{
            preRec=" | Receipt No: "+rs3.getString(2);
            }
         }
        
                            out.print("<table id=main align='center'><tr><td id=topl valign=top>"
                            + "<div id=h3>To:<b><span id='tem' style='color:black; font-size: large;'> "+rs2.getString("name")+", "+rs2.getString("addr")+"</span>"
                            + "</b><br>");
                            if(!name_hindi.equalsIgnoreCase("")||!address_hindi.equalsIgnoreCase("")){
                            	out.print("To:<b><span id='tem' style='color:black; font-size: large;'> "+name_hindi+", "+address_hindi+"</span></b><br>");
                            }
                            out.print("Tin No: <i><span id='tem'> "+rs2.getString("tin")+"</span></i><br>Phone: <i><span id='tem'> "+rs2.getString("pno")+"</span></i><br>Transport: ");
                            if(rs1.getInt("Treceipt")!=0){
                            out.print("<i>("+rs1.getInt("Treceipt")+")</i>");
                            }
                            if(!rs1.getString("tname").equals("")){
                            out.print("<i><span id='tem'> "+rs1.getString("tname")+"</span></i>");
                            }else{
                            out.print("<i><span id='tem'> "+rs2.getString("trans")+"</span></i>");
                            }
                            
                            out.print("</div><div id=date>Date: "+rs1.getString("dat")+"  |  Receipt No: "+recNo+"</div><div id=date1>"+preDate+preRec+"</div></td><td id=topr><img src='diwakar1.png' alt='' width=225 height=125 ></td></tr>");
                            
                            out.print("<tr><td colspan='2' ><table width=100% id=sub ><tr id=headr><th>S No</th><th align=left >Particular</th><th align=right >Bundle</th><th align=right>Size</th><th align=right>Loose</th><th align=right>Total</th></tr>");
                            int k=0;
                            int bundlet=0,looset=0,totalt=0;
                            while(rs.next()){k++;
                            if(k%2==0){
                            out.print("<tr id=even>");
                            }else{
                                out.print("<tr id='odd'>");
                            }
                            out.print("<td>"+k+"</td><td align='left'>");
                            out.print(rs.getString("particular")+"</td><td align=right>");
                            out.print(rs.getString("bundle")+"</td><td align=right >");
                            out.print(rs.getString("bsize")+"</td><td align=right>");
                            out.print(rs.getString("loose")+"</td><td align=right>");
                            out.print(rs.getString("total")+"</td></tr align=right>");
                            bundlet=bundlet+Integer.parseInt(rs.getString("bundle"));
                            looset=looset+Integer.parseInt(rs.getString("loose"));
                            totalt=totalt+Integer.parseInt(rs.getString("total"));
                            }
                            out.print("<tr><td colspan=6><hr></td></tr><tr id='row'><td align=left colspan=2>"+k+" <i> Items Total</i></td><td align=right> <i></i> "+bundlet+"</td><td colspan=2  align=right> <i></i>"+looset+"</td><td align=right> <i></i>"+totalt+"</td></tr>");
                            out.print("<tr><td colspan=6><hr></td></tr>"
                                    + "<tr id=row >"
                                        + "<td id='adv' valign=middle colspan=2></td>"
                                        + "<td valign=middle colspan=4 align=right>");
                            if(rs1.getInt("noparcel")<=0){
                            out.print("<table><tr><th><i>No. of Parcels:</i></th><td> ............</td></tr>");
                            }else{
                            out.print("<table><tr><th><i>No. of Parcels:</i></th><td><u> &nbsp; &nbsp; &nbsp;&nbsp;"+rs1.getInt("noparcel")+"</u></td></tr>");
                            }
                            if(!rs1.getString("localtrans").equals("")){
                            out.print("<tr><th><i>Local Transport:</i></th><td><u> "+rs1.getString("localtrans")+" <u></td></tr>");
                            }
                            out.print("</table></td></tr></table></td></tr></table>");
}catch (Exception ex) {
out.print(ex);
}finally {
	  try{
			cn.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
  }
%>
    </body>
</html>
