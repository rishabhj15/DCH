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

    function check(){
        valid=true;
        if(document.form.bquant.value==""||document.form.lquant.value==""||document.form.tquant.value==""||document.form.bsize.value==""){
        valid=false;

        alert("Invalid Input");}
    else if(document.form.bsize.value==0){
    alert("Bundle size should not be 0.")
    valid=false;
        }
    else{
        valid=true;
        }
        return valid;
    }

    function calculatebundle(){
var bundle=document.getElementById("bq").value;
var loose=document.getElementById("cq").value;
var bs=document.getElementById("bs").value;
if(bundle==''){
    document.getElementById("bns").value='0';
    calculatebundle();
}else if(loose==''){
    document.getElementById("los").value='0';
    calculatebundle();
}else if(bs==''){
        //document.getElementById("bs"+str).value='1';
        calculatebundle();
        return;
}else if(loose>=bs){
    if(bundle==''){
    bundle.value=0;
    //calbun(str);
    }
    document.getElementById("bq").value=parseInt(bundle)+parseInt(loose/bs);
    document.getElementById("cq").value=parseInt(loose%bs);
    //calbun(str);
    //return;
}else{
var total=parseInt(bundle)*parseInt(bs);
var total=parseInt(total)+parseInt(loose);
document.getElementById("tq").value=parseInt(total);
checkcov(str);
document.getElementById("proceed").innerHTML="<input type='button' id='but'   onclick='submitbinded("+str+")' value='Proceed'>";
}
}


</script>
   <body>
<%
String id=request.getParameter("id");

//out.println("<hr><b>You queried for : </b>"+q1+" "+q3+" "+q4+"<hr>");
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            Statement st2= cn.createStatement();
                            Statement st3= cn.createStatement();
                            Statement st4= cn.createStatement();
                            ResultSet rs=null;
                           rs=st.executeQuery("Select A.notebook,A.bundle,A.loose,B.name,B.pno,C.name,D.type,A.id,A.quantity,A.bsize from bindquant as A,notebook as B,covtype as C,rulling as D where A.notebook=B.id and B.name=C.id and B.pno=D.id and A.id="+id+" order by B.name desc " );
                            //String sql="select sum(quantity) from ream as A, reel as B where A.status='rulled' and B.status='rulled' and A.pid=B.id and B.quality='"+q1+"' and A.psize='"+q3+"' and A.ruling='"+q3+"'";
 //                           String t1="and B.quality='"+q1+"' " ;
   //                         String t3="and A.psize="+q3+" ";
     //                       String t4="and A.ruling="+q4+" ";
       //                     String t5="and A.contractor="+q5+" ";
         /*                   if(q1.equals("default")){
                            sql=sql+t3+t4+t5;
                            }
                            if(q3.equals("default")){
                            sql=sql+t1+t4+t5;
                            }
                            if(q4.equals("default")){
                            sql=sql+t1+t3+t5;
                            }
                            if(q5.equals("default")){
                            sql=sql+t1+t3+t4;
                            }*/
                            //out.println("<br>"+sql);
                            //rs = st.executeQuery(sql);
                            
                            if(rs.next()){
                            out.print("<div id=content> <br><form name=form onsubmit='return check()' target=_parent action=updatebinded.jsp method=post autocomplete='off'><table align=center id='asform' ><tr><th colspan='2'>"+rs.getString("C.name")+" "+rs.getString("D.type")+"</th></tr>");
                            out.print("<tr><td>"
                                    + "Bundle:</td><td><input type=text size=15 value='"+rs.getString(2)+"' onkeyup='calculatebundle()' id='bq' name=bquant></td></tr><tr><td>"
                                    + "Loose:</td><td><input type=text size=15 value='"+rs.getString(3)+"' onkeyup='calculatebundle()' id='cq' name=lquant></td></tr><tr><td>"
                                    + "Size:</td><td><input type=text size=15 value='"+rs.getString("A.bsize")+"' onkeyup='calculatebundle()' id='bs' name=bsize></td></tr><tr><td>"
                                    + "Total:</td><td><input type=text size=15 value='"+rs.getString("A.quantity")+"' onkeyup='calculatebundle()' id='tq' name=tquant>"
                                    + "<input type=hidden name=id value='"+id+"'>"
                                    + "</td><td align=left><input id=but  type=submit value='Update'></tr></table></form>");
                            /*out.print("<tr><td>Contractor</td><td><select class='chzn-select' id='bindcontr'  name='contr'>");
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
                            //rs4=st3.executeQuery("Select * from rulling where id="+rs2.getString(3));

                            //rs4.next();
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
                            }*/
                            }
                        } catch (Exception ex) {
                            //out.println(ex);
                        }
%>
<script type="text/javascript">

    $(".chzn-select").chosen();

    $(".chzn-select-deselect").chosen({allow_single_deselect:true});
</script>

   </body>