<%@page import="session.User"%>
<%@page import="mybean.Conf"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
            User u = (User) session.getAttribute("user");
            if (u != null) {%>
<html>
    <head>
        <style type="text/css">
#but,#reff{
   font-size:14px;
   font-family:Arial,sans-serif;
   font-weight:bold;
   color:#FFFFFF;
   width:130px;
   background-color:#EE7777;
   border-top-style:double;
   border-top-color:#EE7777;
   border-top-width:4px;
   border-bottom-style:double;
   border-bottom-color:#EE7777;
   border-bottom-width:4px;
   border-left-style:solid;
   border-left-color:#EE7777;
   border-left-width:4px;
   border-right-style:solid;
   border-right-color:#EE7777;
   border-right-width:4px;
}

#but:hover{
    background-color: #FF7777;
}

th,td{
    padding-right: 2em;
    padding-left: 2em;
    padding-top: 0.5em;
    padding-bottom: 0.5em;
}
#display{
     font-size: small;
}
#top{
    padding-right: 0em;
    padding-left: 0em;
    padding-top: 0.5em;
    padding-bottom: 0.5em;
    font-size: small;
}
#even{
    background-color: #cbcbcb;
}
#odd{
    background-color: #77d5f7;
}
#headr{
    background-image: url('disp.png');
    color: #000000;
    
}
#list{
     position: absolute;
        left: 1in;
        top: 1.7in;
}
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dispatch Form</title>
<link rel="stylesheet" href="chosen/chosen.css" />

   <script type="text/javascript" src="jquery-1.4.3.min.js"></script>
	<script>
		!window.jQuery && document.write('<script src="jquery-1.4.3.min.js"><\/script>');
	</script>

        <script type="text/javascript">
            function colorize(strin){
                if(strin=="bundle"){
                    o1="loose";
                    o2="size";
                }
                if(strin=="loose"){
                    o1="bundle";
                    o2="size";
                }
                if(strin=="size"){
                    o1="loose";
                    o2="bundle";
                }
                document.getElementById(strin).style.background="#cccfff";
                document.getElementById(o1).style.background="#fafafa";
                document.getElementById(o2).style.background="#fafafa";
            }
            var list=0;
function append(){
                
                list=list+1;
                //document.getElementById("list").setAttribute("id", "list"+list);
                bundle=document.getElementById("bundle").value;
                loose=document.getElementById("loose").value;
                product=document.getElementById("product").value;
                se=document.getElementById("se").value;
                size=document.getElementById("size").value;
                notebook=document.getElementById("opt"+product).innerHTML;
                avb=document.getElementById("avb").innerHTML;
                avlo=document.getElementById("avlo").innerHTML;
                var xmlhttp;
                if(parseInt(bundle)+parseInt(loose)==0){
                    alert("Bundle and Loose both cannot be zero. Please change any of them.");
                    document.getElementById("bundle").focus();
                    return;
                }
if (bundle==""||loose==""||size==''||size==0)
  {
  alert("Please Enter Valid Quantity");

        if(bundle==""){
            document.getElementById("bundle").focus();
            return;
        }
        if(loose==""){
            document.getElementById("loose").focus();
            return;
        }
        if(size==""||size==0){
            document.getElementById("size").focus();
            return;
        }
        return;
  }
  if(bundle>parseInt(avb)||loose>parseInt(avlo)){
      alert("Please Enter a value between \n\
0 and "+avb+" for 'Bundle' \n\
\n\
and 0 and "+avlo+" for 'Loose' fields");
     if(bundle>parseInt(avb))               {
            document.getElementById("bundle").focus();
     }
     if(loose>parseInt(avlo))               {
            document.getElementById("loose").focus();
     }
  return;
  }
  document.getElementById("list").innerHTML="<img src='loadimg.gif' align='center' alt='' width='50' height='50'>";
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("bundle").value="";
    document.getElementById("loose").value="";
    document.getElementById("product").focus();
    document.getElementById("list").innerHTML=xmlhttp.responseText;
    set();
    //document.getElementById("listi").setAttribute("id", "list");
    //document.getElementById("list")
    }
  }
xmlhttp.open("GET","append.jsp?se="+se+"&li="+list+"&nb="+notebook+"&b="+bundle+"&l="+loose+"&size="+size+"&pro="+product,true);
xmlhttp.send();
}

function set(){

se=document.getElementById("se").value;
ref=document.getElementById("ref"+se).innerHTML;
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    //document.getElementById("bundle").value="";
    //document.getElementById("loose").value="";
    document.getElementById("list").innerHTML=xmlhttp.responseText;
    document.getElementById("ref").innerHTML=ref;
    //document.getElementById("listi").setAttribute("id", "list");
    //document.getElementById("list")
    }
  }
xmlhttp.open("GET","display.jsp?se="+se,true);
xmlhttp.send();
}
function getavl(){
str=document.getElementById("product").value;
query="select bundle,loose,bsize,quantity from bindquant where notebook="+str;
document.getElementById("avl").innerHTML="<img src='loadimg.gif' align='center' alt='' width='20' height='20'>";
var xmlhttp;
if (str=="")
  {
  document.getElementById("avl").innerHTML="Select Something";
  return;
  }
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("avl").innerHTML=xmlhttp.responseText;
    document.getElementById("bundle").focus();
    }
  }
xmlhttp.open("GET","avl.jsp?q="+query,true);
xmlhttp.send();

    }
    function clearall(se){
document.getElementById("list").innerHTML="<img src='loadimg.gif' align='center' alt='' width='20' height='20'>";
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

    }
  }
xmlhttp.open("GET","clearall.jsp?se="+se,true);
xmlhttp.send();
}
function dispatch(se){
    window.location="dispatchperform.jsp?se="+se;
}
function dispatch1(se){
document.getElementById("list").innerHTML="<img src='loadimg.gif' align='center' alt='' width='20' height='20'>";
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

    }
  }
xmlhttp.open("GET","dispatchperform.jsp?se="+se,true);
xmlhttp.send();
}
function remove(se,j){
document.getElementById("list").innerHTML="<img src='loadimg.gif' align='center' alt='' width='20' height='20'>";
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

    }
  }
xmlhttp.open("GET","remove.jsp?se="+se+"&id="+j,true);
xmlhttp.send();
}
function edit(se,j){
remove(se,j);
}

        </script>
    </head>
    <body onload="set()" >
<%
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            ResultSet rs = null;
                            Statement st1=cn.createStatement();
                            ResultSet rs1 = null;
                            Statement st2=cn.createStatement();
                            ResultSet rs2 = null;
                            %>
                            
<table align="center" width="100%" bgcolor="#CDCDCD" style=" height: 50px;  "  >
                                

<tr align="left" >
<%rs=st.executeQuery("Select * from party where sta='a' order by name");%>
<td id="top" valign="middle" align="right" >Party</td><td id="top" align="left" ><select size="3" tabindex="1" class="chzn-select" id="se" onchange="set()" style=" width: 25em;background-color: #f1f1f1;"  > <%while(rs.next()){%>
                                            
<option id="ref<%=rs.getString(1)%>" value="<%=rs.getString(1)%>"><%=rs.getString(2)+" "+rs.getString(3)%></option>

<%}%></select> </td>
<%rs=st.executeQuery("Select * from notebook as A,covtype as B,rulling as C,bindquant as D where A.sta='a' and A.name=B.id and A.pno=C.id and A.id=D.notebook order by B.name ");%>
<td valign="middle" align="right" id="top">Product</td><td id="top" valign=middle align="left" ><select tabindex="2"    class="chzn-select" id="product" onchange="getavl()" style=" width: 25em;background-color: #f1f1f1;"   > <%while(rs.next()){%>
<%//rs1=st1.executeQuery("Select * from covtype where id="+rs.getString("name")+"");rs1.next();%>
<%//rs2=st2.executeQuery("Select * from rulling where id="+rs.getString("pno")+"");rs2.next();%>
<option id="opt<%=rs.getInt("id")%>" value="<%=rs.getInt("A.id")%>"><%=rs.getString("B.name")+" "+rs.getString("C.type")%></option>

<%}%></select> </td><td width="50%"></td>

</tr>
<tr>
<tr>
    <td valign="top" colspan="2" align="left"></td><td colspan="2" align="left" id="avl" ></td>
</tr>
</table>


<div id="list">

        </div>

<%
}catch (Exception ex) {
out.print(ex);
}
%>
<script src="chosen/chosen.jquery.js" type="text/javascript"></script>
<script type="text/javascript">

    $(".chzn-select").chosen();

    $(".chzn-select-deselect").chosen({allow_single_deselect:true});
</script>

    </body>
</html>
        <%} else {
                        response.sendRedirect("index.jsp");
                    }%>
