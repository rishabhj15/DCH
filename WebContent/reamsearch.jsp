 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>


   <link rel="stylesheet" href="styles.css" />
<link rel="stylesheet" href="chosen/chosen.css" />
   <script type="text/javascript" src="jquery-1.4.3.min.js"></script>
   <script>
		!window.jQuery && document.write('<script src="jquery-1.4.3.min.js"><\/script>');
	</script>
	<script type="text/javascript" src="fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
	<script type="text/javascript" src="fancybox/jquery.fancybox-1.3.4.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="fancybox/jquery.fancybox-1.3.4.css" media="screen" />






 	<link rel="stylesheet" href="style.css" />
        <script type="text/javascript" src="scw.js"></script>

<script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>
<link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

   <script type="text/javascript">
       function submitbind(){
var xmlhttp;
var contr=document.getElementById('bindcontr').value;
var rate=document.getElementById('bindrate').value;
var notebook=document.getElementById('nb').value;
var notebookq=document.getElementById('nq').value;
var bind=document.getElementById('bind').value;
var bavl=document.getElementById('avl').value;
var quality=document.getElementById('bindquality').value;
var psize=document.getElementById('bindpsize').value;
var rulling=document.getElementById('bindrulling').value;
if(notebookq==''||bind==''){
    alert('Insert quantity value for notebook. ');
    return;
}
else{
if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {


document.write("<p align=right><a href='home.jsp?q=viewStock1#fragment-3' target='_parent'> Close and go to page</a></p><h2 align='center' style='background-color: firebrick; color: white;'>Updated Successfully</h2><div id='res'></div>");

    }

  }
xmlhttp.open("GET","savebind.jsp?contr="+contr+"&notebook="+notebook+"&notebookq="+notebookq+"&bind="+bind+"&bavl="+bavl+"&quality="+quality+"&psize="+psize+"&rulling="+rulling+"&rate="+rate,true);
xmlhttp.send();
}
}
       function checkin(){
    var1=document.getElementById("nq").value;
    var2=document.getElementById("covq").innerHTML;
    if(document.getElementById("nq").value==""){
            document.getElementById("check").innerHTML="Enter Smaller Value Than"+var2;
    }else{
        if(parseFloat(var1)<=parseFloat(var2)&&parseFloat(var1)>0){

        check();

    }else{
        document.getElementById("nq").value=parseInt(var2);
    }
    }
}function check(){
    var1=document.getElementById("bind").value;
    var2=document.getElementById("avl").value;
    if(document.getElementById("bind").value==""){
            document.getElementById("check").innerHTML="Enter Smaller Value Than"+var2;
    }else{



    if(parseFloat(var1)<=parseFloat(var2)&&parseFloat(var1)>0){
        document.getElementById("check").innerHTML="<input type='button' onclick='submitbind()' id='but' value='Proceed'>";

    }else{
        document.getElementById("check").innerHTML="Enter Value baetween 0 and"+var2;
    }
    }
}

function check1(){
        str=document.getElementById("nb").value;

var xmlhttp;
if (str=="")
  {
  document.getElementById("covq").innerHTML="Write Something";
  return;
  }
if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("covq").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("GET","covcheck.jsp?q="+str,true);
xmlhttp.send();
}
</script>
   <body onload="check1()">
<%
String q1=request.getParameter("q1");
String q3=request.getParameter("q3");
String q4=request.getParameter("q4");
String r=request.getParameter("r");
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
                            ResultSet rs=null;
                           String sql="select A.quantity,A.psize,A.rulling,B.type,C.type from reamquant as A,papersize as B,rulling as C where A.quality='"+q1+"' and A.psize="+q3+" and A.rulling="+q4+" and A.psize=B.id and A.rulling=C.id";
                            
                            rs = st.executeQuery(sql);
                            ResultSet rs1=st1.executeQuery("Select * from contractor where sta='a' and area='binding'");
                            ResultSet rs2=st2.executeQuery("Select * from notebook where sta='a' and pno="+q4);
                            ResultSet rs3;
                            ResultSet rs4=st4.executeQuery("Select * from bindqual where sta='a'");
                            
                            if(rs.next()){
                            out.print("<div id=content> <br><form autocomplete='off'><table align=center id='asform' ><tr><th colspan='2'><input type=hidden id='avl' name='bavl' value="+rs.getFloat(1)+">"+q1+" "+rs.getString("B.type")+" "+rs.getString("C.type")+"<h3>"+rs.getFloat(1)+" Reams Available</h3></th></tr>");
                            out.print("<tr><td>Contractor</td><td><select class='chzn-select' id='bindcontr'  name='contr'>");
                            while(rs1.next()){
                            out.print("<option value="+rs1.getInt(1)+">"+rs1.getString(2)+"</option>");
                            }
                            out.print("</select></td></tr>");
                            out.print("<tr><td>Binding Quality</td><td><select class='chzn-select' id='bindrate'  name='bindrate'>");
                            while(rs4.next()){
                            out.print("<option value="+rs4.getInt(1)+">"+rs4.getString(2)+" | Rate:"+rs4.getString(3)+"</option>");
                            }
                            out.print("</select></td></tr>");
                            out.print("<tr><td>Select Notebook</td><td><select class='chzn-select' onchange='check1()' id='nb' name='notebook'>");
                            while(rs2.next()){
                            rs3=st3.executeQuery("Select A.name,B.type,A.quantity from covtype A,rulling B where A.id="+rs2.getString(2)+" and B.id="+rs2.getString(3));
                            
                            rs3.next();
                            out.print("<option value="+rs2.getInt(1)+">"+rs3.getString(1)+" "+rs3.getString(2)+" | Covers <i>"+rs3.getString(3)+"</i></option>");
                            }
                            out.print("</select></td></tr>");
                            out.print("<tr><td align='right' colspan='2' id='check1' ></td></tr>");
                            out.print("<tr><td>Enter number of copies: </td><td><input type=text id='nq' onkeyup='checkin()'  size=5 name=notebookq> < <span id='covq' ></span> </td></tr>");
                            out.print("<tr><td>Enter number of reams to bind: </td><td><input type=text onkeyup='check()' id='bind' size=5 name=bind></td></tr>");
                            out.print("<input type='hidden' id='bindquality' name='quality' value='"+q1+"'><input type='hidden' id='bindpsize' name='psize' value='"+q3+"'><input type='hidden' name='rulling' id='bindrulling' value='"+q4+"'>");
                            out.print("<tr><td colspan='3' align=right id='check'></td></tr></table></form></div>");
                            }else{
                            out.print("<table align=center id='asform'><tr><th><h3>Not Available</h3></th></tr></table></div>");
                            }
                        } catch (Exception ex) {
                            
                        }finally {
                        	  try{
                      			cn.close();
                      		}catch(Exception ex){
                      			ex.printStackTrace();
                      		}
                          }
%>
<script type="text/javascript">

    $(".chzn-select").chosen();

    $(".chzn-select-deselect").chosen({allow_single_deselect:true});
</script>

   </body>