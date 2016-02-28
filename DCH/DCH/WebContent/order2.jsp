<%-- 
    Document   : order2
    Created on : Jun 17, 2012, 12:19:31 AM
    Author     : Rishabh
--%>

<%@page import="session.User"%>
<%@page import="session.Cart_1"%>
<%@page import="session.Item_1"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            User u = (User) session.getAttribute("user");
            if (u != null) {%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DCH NEW ORDER</title>
        <style type="text/css">
            .availablitydata th{
                text-align: right;
            }
            #butcart:focus,#bundle:focus,#loose:focus{
                background-color: #E2E4FF; 
            }
            #butcart{
                background: url("images/cartimages/addbutt.png") no-repeat scroll 0 0 transparent;
                color: #000000;
                cursor: pointer;
                font-weight: bold;
                height: 75px;
                width: 150px;
                text-align: right;
            }

            #partyname{
                background-color: #3882C7;
                color: #FFFFFF;
                
            }
            #zoomimg:hover{
                border-width: 1px;
                width: 45px;

            }
            #zoomimg1:hover{
                border-width: 1px;
                width: 60px;
            }
            #zoomimg{
                border-width: 0px;
            }
            #interf{
                background-color: #ffffff ;

            }
            #headr{
                background-color: #3882C7;
                color: white;
            }
            #redon{
                background-color: orange;

            }
            #but{
                font-size:14px;
                font-family:Arial,sans-serif;
                font-weight:bold;
                width:130px;
                border-top-style:double;

                border-top-width:4px;
                border-bottom-style:double;

                border-bottom-width:4px;
                border-left-style:solid;

                border-left-width:4px;
                border-right-style:solid;

                border-right-width:4px;
            }

            #but:hover{
                font-size: 16px;
            }
            body{
                background-color: #fafafa;
            }

        </style>
        <link rel="stylesheet" href="chosen/chosen.css" />
        <script type="text/javascript" src="jquery-1.4.3.min.js"></script>
        <script type="text/javascript" >
                !window.jQuery && document.write('<script src="jquery-1.4.3.min.js"><\/script>');
        </script>
        <script type="text/javascript" >
            function ask(){
                valid=true;
                var r=confirm("Are you sure you want to remove this item from cart ?");
                if (r==true)
                {
                    valid=true;
                }
                else
                {
                    valid=false;
                }
                return valid;
            }

            function OnButton1()
            {
                document.Form1.action = "saveorder.jsp"
                // document.Form1.target = "_blank";    // Open in a new window
                //  if(checkvals()){
                document.Form1.submit();             // Submit the page
                //}
            }
            function OnButton2()
            {   if(confirm("Are you sure you want to dispatch ?")){
                document.Form1.action = "processorder.jsp"
                // document.Form1.target = "_blank";    // Open in a new window
                if(checkvals()){
                    
                    document.Form1.submit();             // Submit the page
                    document.getElementById("but2").disabled=true;
                }
            }
            }
            
            var prod,rull,combo;
            function checkvals(){
                v=document.getElementsByName("bundle");
                t=document.getElementsByName("loose");
                a=document.getElementsByName("avl");
                to=document.getElementsByName("total");
                for(i=0;i<v.length;i++){
                    if(v.item(i).value==""){
                        alert("Field cannot be empty.");
                        v.item(i).focus();
                        return false;
                    }
                }
                for(i=0;i<t.length;i++){
                    if(t.item(i).value==""){
                        alert("Field cannot be empty.");
                        t.item(i).focus();
                        return false;
                    }
                }
                for(i=0;i<a.length;i++){
                    if(parseInt(a.item(i).value)<parseInt(to.item(i).value)){
                        alert("Only "+a.item(i).value+" is avalable. Requested "+to.item(i).value);
                        to.item(i).focus();
                        return false;
                    }
                }
                    for(i=0;i<to.length;i++){                        
                        if(parseInt(to.item(i).value)==""){
                            alert("Field cannot be zero.");
                            to.item(i).focus();
                            return false;
                        }
                    }
                    for(i=0;i<to.length;i++){
                        if(parseInt(to.item(i).value)==0){
                            alert("Field cannot be zero.");
                            to.item(i).focus();
                            return false;
                        }
                    }
                    return true;

                }
                function setAttributes(){
                    prod=document.getElementById("product").value;
                    rull=document.getElementById("rulling").value;
                }
                function remove_1(x){
                    if(ask())   {

                        document.getElementById("cart").innerHTML="<img src='loadimg.gif' align='center' alt='' width='40' height='40'>";
                        var xmlhttp;
                        if (window.XMLHttpRequest)
                        {// code for IE7+, Firefox, Chrome, Opera, Safari
                            xmlhttp=new XMLHttpRequest();
                        }
                        xmlhttp.onreadystatechange=function()
                        {
                            if (xmlhttp.readyState==4 && xmlhttp.status==200)
                            {
                                document.getElementById("cart").innerHTML=xmlhttp.responseText;

                            }
                        }
                        xmlhttp.open("GET","remove_1.jsp?id="+x+"&mode=single",true);
                        xmlhttp.send();
                    }
                }
                function removeAll(){
                    if(ask())   {

                        document.getElementById("cart").innerHTML="<img src='loadimg.gif' align='center' alt='' width='40' height='40'>";
                        var xmlhttp;
                        if (window.XMLHttpRequest)
                        {// code for IE7+, Firefox, Chrome, Opera, Safari
                            xmlhttp=new XMLHttpRequest();
                        }
                        xmlhttp.onreadystatechange=function()
                        {
                            if (xmlhttp.readyState==4 && xmlhttp.status==200)
                            {
                                document.getElementById("cart").innerHTML=xmlhttp.responseText;

                            }
                        }
                        xmlhttp.open("GET","remove_1.jsp?id=-1&mode=multiple",true);
                        xmlhttp.send();
                    }
                }
                function updatecart(pid){
                    if(pid==''){
                        alert('Invalid Operation');
                        return;
                    }
                    /*var bundle=document.getElementById("b"+pid).value;
                var loose=document.getElementById("l"+pid).value;
                var party=document.getElementById("party").value;
                var size=document.getElementById("s"+pid).value;*/
                    var quantity=document.getElementById("t"+pid).value;
                
                    if(quantity==''){
                        quantity=0;
                    }
                    var xmlhttp;
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                    }
                    xmlhttp.onreadystatechange=function()
                    {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200)
                        {
    
                            $("#msg").slideToggle(4000);
                            document.getElementById("msg").innerHTML=xmlhttp.responseText;
                            $("#msg").fadeOut(2000);
                            displaycart();
                            document.getElementById("t"+pid).focus();
                        }
                    }

                    xmlhttp.open("GET","updatecartproduct.jsp?product="+pid+"&q="+quantity+"&p="+party,true);
                    xmlhttp.send();
                }
                function fetchAvailable(){
                	str=document.getElementById("quantity").value = 0;
                    str=document.getElementById("lop").value;
                    if(str==''){
                        return;
                    }
                    
                    var xmlhttp;
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                    }
                    xmlhttp.onreadystatechange=function()
                    {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200)
                        {
                            document.getElementById("available").innerHTML=xmlhttp.responseText;
                            if(document.getElementById("avlQty")){
	                            avlQty=document.getElementById("avlQty").innerHTML;
	                            str=document.getElementById("quantity").value = avlQty;
                        	}
                        }
                    }

                    xmlhttp.open("GET","fetchAvailable.jsp?product="+str,true);
                    xmlhttp.send();
                }
                
                function addtoform(){
                    str=document.getElementById("lop").value;
                    if(str==''){
                        alert('Invalid Operation');
                        document.getElementById("lop").focus();
                        return;
                    }
                
                    var quantity=document.getElementById("quantity").value;
                    var party=document.getElementById("party").value;
                
                    if(quantity==''){
                        alert('Invalid Operation');
                        document.getElementById("quantity").focus();
                        return;
                    }
                    if(quantity=='0'){
                        quantity=1;
                    }
                    var xmlhttp;
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                    }
                    xmlhttp.onreadystatechange=function()
                    {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200)
                        {
                            document.getElementById("cart").innerHTML=xmlhttp.responseText;
                            document.getElementById("combo").focus();
                            $("#msg").slideToggle(4000);
                            document.getElementById("msg").innerHTML="Added to cart.";
                            $("#msg").fadeOut(2000);
                        }
                    }

                    xmlhttp.open("GET","addtocart.jsp?product="+str+"&q="+quantity+"&p="+party,true);
                    xmlhttp.send();
                }
            
                function getList(){
                    //setAttributes();
                    prod1=document.getElementById("product").value;
                    rull1=document.getElementById("rulling").value;
                    party=document.getElementById("party").value;
                    document.getElementById("combo").value="type here...";
                    document.getElementById("list").innerHTML="<p align='center'>Loading Product List.<br><img src='loadimg.gif' align='center' alt='' width='40' height='40'><br></p><hr>";
                    var xmlhttp;
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                    }
                    xmlhttp.onreadystatechange=function()
                    {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200)
                        {
                            document.getElementById("list").innerHTML=xmlhttp.responseText;
                            fetchAvailable();
                            displaycart();
                        }
                    }
                    xmlhttp.open("GET","productlist.jsp?product="+prod1+"&rulling="+rull1+"&party="+party,true);
                    xmlhttp.send();
                }
                function getList1(){
                    combo=document.getElementById("combo").value;
                    if(combo=="type here..."){
                        return;
                    }
                    var xmlhttp;
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                    }
                    xmlhttp.onreadystatechange=function()
                    {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200)
                        {
                            document.getElementById("list").innerHTML=xmlhttp.responseText;
                            fetchAvailable();
                        }
                    }
                    xmlhttp.open("GET","productlist1.jsp?combo="+combo,true);
                    xmlhttp.send();
                }
                
                function getList2(){
                    document.getElementById("list").innerHTML="<p align='center'> Loading Frequently Ordered Product List.<br><img src='loadimg.gif' align='center' alt='' width='40' height='40'><br></p><hr>";
                    party=document.getElementById("party").value;
                    
                    var xmlhttp;
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                    }
                    xmlhttp.onreadystatechange=function()
                    {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200)
                        {
                            document.getElementById("list").innerHTML=xmlhttp.responseText;
                            fetchAvailable();
                        }
                    }
                    xmlhttp.open("GET","productlist2.jsp?party="+party,true);
                    xmlhttp.send();
                }

                function displaycart(){
                    var xmlhttp;
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                    }
                    xmlhttp.onreadystatechange=function()
                    {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200)
                        {
                            document.getElementById("cart").innerHTML=xmlhttp.responseText;
                        }
                    }
                    xmlhttp.open("GET","displaycart.jsp",true);
                    xmlhttp.send();
                }
        </script>

    </head>
    <body onload="getList()" >
       
        <%
                        String p = request.getParameter("party");


                        try {
                            Cart_1 temp = (Cart_1) session.getAttribute("ordercart");
                            if (temp != null) {
                                temp.updateParty(p);
                            }
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c = new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st = cn.createStatement();
                            Statement st1 = cn.createStatement();
                            Statement st2 = cn.createStatement();
                            ResultSet rs = st.executeQuery("select * from party where id=" + p);
                            rs.next();
                            String pname = rs.getString(2) + ", " + rs.getString(3);
                            //String serv=request.getParameter("serv");
        %>

        <table align="center" width="90%" >
            <tr><td width="45%" align="center" valign="top" >

                    <table border="1" style=" border-collapse: collapse; position: fixed; border-bottom: 1px black solid ;  " >
                        <tr>
                            <td id=partyname colspan="2"><a tabindex="-5" href="home.jsp?q=order">Back</a>
                                <%=pname%>
                                <input type="hidden" id="party" value="<%=p%>">
                            </td>
                        
                        <tr >

                            <td>
                                <%

                                                rs = st.executeQuery("Select distinct product from v_print_stock order by product");
                                %>
                                <select style="width: 200px;" class="chzn-select" onchange="getList()" id="product" >
                                    <option value="" >All-</option>
                                    <%while (rs.next()) {%>
                                    <option ><%=rs.getString(1)%></option>
                                    <%}%>
                                </select></td><td>
                                <%
                                                rs = st.executeQuery("Select distinct rulling from v_print_stock order by rulling");
                                %>
                                <select style="width: 200px;" class="chzn-select" onchange="getList()" id="rulling" >
                                    <option value="" >All-</option>
                                    <%while (rs.next()) {%>
                                    <option ><%=rs.getString(1)%></option>
                                    <%}%>
                                </select></td></tr>
                        <%
                                                    rs = st.executeQuery("SELECT d.particular, count( particular ) FROM dispatch d, transact t WHERE d.tid = t.id AND t.party = '27' GROUP BY particular ORDER BY count( * ) DESC LIMIT 0 , 10");
                        %>
                        <tr>
                            <td colspan="2" >
                                <input id="combo" value="type here..." onfocus="this.select()"  style=" color: gray;  width:400px;" onkeyup="getList1()" accesskey="s">
                            </td></tr>

                        <%
                                        } catch (Exception ex) {
                                            out.print(ex);
                                        }
                        %>
                        <tr>
                            <td colspan="2" align="center">
                                Show Frequently Ordered Products 
                                <input type="radio" id="freqordered" onclick="getList2()" tabindex="-1" accesskey="f"/>
                            </td>
                        </tr>
                        <tr><td colspan="2">

                                <table width="100%" >
                                    <tr>
                                        <td colspan="2" id="list" >

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><div id="available"></div></td>
                                    </tr>
                                    <tr>
                                        <td colspan="1" align="center" >
                                            Quantity: <input type="text" size="5" value="0" id="quantity" style="text-align: right;" accesskey="q" >
                                        </td>
                                        <td colspan="1" align="right">
                                            <input type="button" onclick="addtoform()" value="Add to Cart" id="butcart" accesskey="a" >
                                        </td>
                                    </tr>
                                </table>
                            </td></tr>
       
                    </table>

                </td>

                <td valign="top" align="center" width="45%">

                    <form action='saveorder.jsp' name="Form1" autocomplete='off' method=post >
                        <input type="hidden" name="oid" value="<%=request.getParameter("oid")%>"/>
                        <div id="cart">

                        </div>
                    </form>
                </td>

            </tr></table>
        <script src="chosen/chosen.jquery.js" type="text/javascript"></script>

        <script type="text/javascript">

                $(".chzn-select").chosen();

                $(".chzn-select-deselect").chosen({allow_single_deselect:true});
        </script>
        <%} else {
                        response.sendRedirect("index.jsp");
                    }%>
    </body>
</html>