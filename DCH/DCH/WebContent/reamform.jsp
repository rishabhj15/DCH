 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>
<%-- 
    Document   : reamform
    Created on : Sep 29, 2011, 4:13:09 PM
    Author     : Rishabh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles.css" />
        <%String rid=request.getParameter("rid");%>
        <script type="text/javascript">
            function submitream(str){
var xmlhttp;
var rid=document.getElementById('reamrid'+str).value;
var size=document.getElementById('reamsize'+str).value;
var rulling=document.getElementById('reamrulling'+str).value;
var contractor=document.getElementById('reamcontractor'+str).value;
var quantity=document.getElementById('reamquantity'+str).value;
if(quantity==''){
    alert('Insert quantity value for reel '+str);
}
else{
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById(str).innerHTML=xmlhttp.responseText;
    //$("#"+str).slideUp(2000);
    //document.getElementById(str).innerHTML="<h2 align='center' style='background-color: firebrick; color: white;'>Updated Successfully</h2>";
    //$("#"+str).show();
    //$("#"+str).fadeOut(4000);
    //document.getElementById('action'+str).style.background='#ffffff';
    //document.getElementById('action'+str).innerHTML='<img src=green.jpg width=30 height=30>  ';
    //document.getElementById('sdate'+str).innerHTML='a moment ago.';
    //document.getElementById('sta'+str).innerHTML='Rulled';
    }

  }
xmlhttp.open("GET","saveream.jsp?rid="+rid+"&size="+size+"&rulling="+rulling+"&contractor="+contractor+"&quantity="+quantity,true);
xmlhttp.send();
}
}

function validatequ(){
valid=true;
if(document.getElementById("reamquantity<%=rid%>").value==""||document.getElementById("reamquantity<%=rid%>").value==0){
    alert("Invalid Quantity");
    valid=false;
}else{
var r=confirm("Confirm \nQuantity:"+document.getElementById("reamquantity<%=rid%>").value);
if (r==true)
  {
  valid=true;
  }
else
  {
  valid=false;
  }

}
return valid;
}



        </script>
    </head>
    <body style=" background-image: url('back.gif') " >
<%

//out.print("Unique Number:"+rid);
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());

                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            ResultSet rs;
                            ResultSet rs1 = st1.executeQuery("Select rid,wt from reel where id="+rid);
                            rs1.next();
                            %>
                            <form autocomplete='off' action="saveream.jsp" method="post">
                                <input type="hidden" id="reamrid<%=rid%>" name="rid" value="<%=rid%>">
                                <br><br>
                                <table id="asform" align="center" style="border-collapse: collapse; padding: 1em; background-image: url('back.gif');   " >
                                    <tr>
                                        <td colspan="2" style="background-color: #2191c0; color: whitesmoke; font-family: verdana; font-size: large;    " >
                                            <%="Reel Id: "+rs1.getInt(1)+" | Wt: "+rs1.getInt(2)%>
                                        </td>
                                    </tr>
            <tr>
                <%rs=st.executeQuery("Select * from papersize where sta='a' order by type");%>
                <td align="right" >Size</td><td><select style=" width: 10em; " id="reamsize<%=rid%>" name="size"><%while(rs.next()){%><option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option><%}%></select> </td>
            </tr>
            <tr >
                                                <%rs=st.executeQuery("Select * from rulling where sta='a' order by type");%>
                                                <td align="right">Rulling</td><td><select style=" width: 10em; " id="reamrulling<%=rid%>" name="rulling"><%while(rs.next()){%><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select> </td>
            </tr>
            <tr>
                                               <%rs=st.executeQuery("Select * from contractor where sta='a' and area='rulling' order by id");%>
                                <td align="right">Contractor</td><td><select style=" width: 10em; " id="reamcontractor<%=rid%>" name="contractor"><%while(rs.next()){%><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select> </td>
                            <%
                            cn.close();
                        } catch (Exception ex) {
                            out.println(ex);
                        }
%>
            </tr>
            <tr>
                <td align="right">Quantity</td><td><input type="text" style=" width: 10em; " style='text-align: right;' size="7" id="reamquantity<%=rid%>" value="0" name="quantity"></td>
            </tr>
            <tr><input type="hidden" value="<%=rid%>" name="rid">
            <td colspan="2" align="center" ><input  type="submit" value="Update" id="but" onclick="return validatequ()" ></td>
            </tr>
        </table></form>

    </body>
</html>
