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
        if(document.form.reamquant.value==""){
        valid=false;
        
        alert("Invalid Input");}else{
        valid=true;
        }
        return valid;
    }
</script>
   <body>
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
                            out.print("<div id=content> <br><form name=form onsubmit='return check()' target=_parent action=updatereamquant.jsp method=post autocomplete='off'><table align=center id='asform' ><tr><th colspan='2'><input type=hidden id='avl' name='bavl' value="+rs.getFloat(1)+">"+q1+" "+rs.getString("B.type")+" "+rs.getString("C.type")+"<h3>"+rs.getFloat(1)+" Reams Available</h3></th></tr>");
                            out.print("<tr><td align=right >"
                                    + "<input type=text size=15 value='"+rs.getFloat(1)+"' id='rq' name=reamquant>"
                                    + "<input type=hidden name=quality value='"+q1+"'>"
                                    + "<input type=hidden name=psize value='"+q3+"'>"
                                    + "<input type=hidden name=rulling value='"+q4+"'>"
                                    + "</td><td align=left><input id=but  type=submit value='Update'></tr></table></form>");
                            }
                        } catch (Exception ex) {
                            //out.println(ex);
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