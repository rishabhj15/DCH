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
                           rs=st.executeQuery("Select A.notebook,A.bundle,A.loose,B.name,B.pno,C.name,D.type,A.id,A.quantity,A.bsize from bindquant as A,notebook as B,covtype as C,rulling as D where A.notebook=B.id and B.name=C.id and B.pno=D.id and A.id="+id+" order by B.name desc " );
                            
                            if(rs.next()){
                            out.print("<div id=content> <br><form name=form onsubmit='return check()' target=_parent action=updatebinded.jsp method=post autocomplete='off'><table align=center id='asform' ><tr><th colspan='2'>"+rs.getString("C.name")+" "+rs.getString("D.type")+"</th></tr>");
                            out.print("<tr><td>"
                                    + "Bundle:</td><td><input type=text size=15 value='"+rs.getString(2)+"' onkeyup='calculatebundle()' id='bq' name=bquant></td></tr><tr><td>"
                                    + "Loose:</td><td><input type=text size=15 value='"+rs.getString(3)+"' onkeyup='calculatebundle()' id='cq' name=lquant></td></tr><tr><td>"
                                    + "Size:</td><td><input type=text size=15 value='"+rs.getString("A.bsize")+"' onkeyup='calculatebundle()' id='bs' name=bsize></td></tr><tr><td>"
                                    + "Total:</td><td><input type=text size=15 value='"+rs.getString("A.quantity")+"' onkeyup='calculatebundle()' id='tq' name=tquant>"
                                    + "<input type=hidden name=id value='"+id+"'>"
                                    + "</td><td align=left><input id=but  type=submit value='Update'></tr></table></form>");
                            
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