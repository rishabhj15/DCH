<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%
String qual=request.getParameter("quality");
String stat=request.getParameter("status");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link rel="shortcut icon" type="image/ico" href="http://www.datatables.net/favicon.ico" />
<style type="text/css">
                #cmd{
                    background-color: #009999 ;
                    color: whitesmoke;
                    font-weight: bold;
                    padding:0.5em;
}
            </style>
		<title><%=qual+" | "+stat%></title>
                <link type="text/css" href="css/custom-theme/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
		<style type="text/css" title="currentStyle">

                        @import "media/css/jquery.dataTables_themeroller.css";
			@import "media/css/demo_table.css";
		</style>
		<script type="text/javascript" language="javascript" src="media/js/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="media/js/jquery.dataTables.js"></script>
                <script type="text/javascript" src="fancybox/jquery.fancybox-1.3.4.pack.js"></script>
                <link rel="stylesheet" type="text/css" href="fancybox/jquery.fancybox-1.3.4.css" media="screen" />
                <script type="text/javascript" charset="utf-8">
function saveream(str,str1){
var xmlhttp;
var rid=str1;
var size=document.getElementById('ps'+str).value;
var rulling=document.getElementById('rulling'+str).value;
var contractor=document.getElementById('contractor'+str).value;
var quantity=document.getElementById('estd'+str).value;
if(confirm("Please confirm your selections.")){
    if(quantity==''){
        alert('Insert quantity value for reel '+str);
        document.getElementById('estd'+str).focus();
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
            document.getElementById("msg").innerHTML=xmlhttp.responseText;
            $("#msg").fadeOut(4000);
            location.reload();
            }

          }
        xmlhttp.open("GET","saveream.jsp?rid="+rid+"&size="+size+"&rulling="+rulling+"&contractor="+contractor+"&quantity="+quantity,true);
        xmlhttp.send();
        }
}else{
    return;
}

}

                    function calc(rid){
                        //alert(rid);
                        wt=document.getElementById("wt"+rid).value;
                        //alert(wt);
                        e=document.getElementById("ps"+rid);
                        ps=e.options[e.selectedIndex].text;
                        //alert(ps);
                        var ps1=ps.split("*");
                        //alert(ps1[0]);
                        gsm=document.getElementById("gsm"+rid).value;
                        //alert(gsm);
                        if(gsm==""){
                            alert("Enter GSM Value.")
                            document.getElementById("gsm"+rid).focus();
                            return;
                        }
                        estdw=(wt*20000)/(ps1[0]*ps1[1]*gsm);
                        //alert(estdw);
                        document.getElementById("estd"+rid).value=estdw.toFixed(2);
                    }
function ask(){
valid=true;
var r=confirm("Are you sure you want to delete ?");
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

			$(document).ready(function() {

                        $("a#example4").fancybox({
				'overlayShow'	: false,
				'width'		: '50%',
				'height'	: '50%',
				'autoScale'	: false,
                                'transitionIn'	: 'elastic',
				'transitionOut'	: 'elastic',
                                'type' : 'iframe',
                                'onClosed': function() {
    parent.location.reload(true);
  }

	});
	oTable = $('#example1').dataTable({
        "bJQueryUI": true,
        "bStateSave": true,
        "sPaginationType": "full_numbers"
    });

			} );
   		</script>

		
	</head>
	<body>
            <h2 id="cmd"><%=qual+" | "+stat%></h2>
        <div id="msg"></div>
<table cellpadding="0" cellspacing="0" border="0" class="display" id="example1" width="100%">
	<thead>
            <tr style=" padding: 0em;" >
			<th>S No</th>
			<th>Reel Id</th>
			<th>Quality</th>
                        <th>Entry</th>
			<th>Weight</th>
                        <th>Size</th>
                        <th>GSM</th>
                        <th>P-Size</th>
                        <th>Rulling</th>
                        <th>Estimated Ream</th>
                        <th>Contractor</th>
                        <th>Action</th>
		</tr>
	</thead>
        <tbody>
<%
Connection cn = null;
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            Statement st2=cn.createStatement();
                            ResultSet rs = st.executeQuery("Select * from reel as A,size as B where A.status='"+stat+"' and A.size=B.id and A.quality='"+qual+"'");
                            ResultSet rs1=null;
                            int i=0;
                            while(rs.next()){

                                i++;
%>

	

		<tr class="odd gradeA" >
                    <td style="width: 1em;"  ><%=i%></td>
                    <td align="center" ><%=rs.getString("rid")%></td>
                    <td align="center" ><%=rs.getString("quality")%></td>
                    <td align="center" ><%=rs.getString("A.dat")%></td>
                    <td align="center" ><%=rs.getString("A.wt")%></td>
                    <input type="hidden" id="wt<%=rs.getString("rid")%>" value="<%=rs.getString("A.wt")%>" >
                    <%String psize=rs.getString("B.size");%>
                    <td align="center" ><%=rs.getString("B.size")%></td>
                    <td align="center" ><input type="number" size="5" onchange="calc(<%=rs.getString("rid")%>)" id='gsm<%=rs.getString("rid")%>'></td>
                    <%rs1=st1.executeQuery("SELECT * FROM papersize ORDER BY IF( instr( TYPE , '"+psize+"' ) , instr( TYPE , '"+psize+"' ) , 65535 ) ASC");%>
                    <td><select style=" width: 10em; " onchange="calc(<%=rs.getString("rid")%>)" id="ps<%=rs.getString("rid")%>" name="size"><%while(rs1.next()){%><option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%}%></select> </td>
                    <%rs1=st1.executeQuery("Select * from rulling where sta='a' order by type");%>
                    <td><select style=" width: 10em; " id="rulling<%=rs.getString("rid")%>" name="rulling"><%while(rs1.next()){%><option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%}%></select> </td>
                    <td align="center" ><input type="text" id='estd<%=rs.getString("rid")%>'></td>
                    <%rs1=st1.executeQuery("Select * from contractor where sta='a' and area='rulling' order by id");%>
                    <td><select style=" width: 10em; " id="contractor<%=rs.getString("rid")%>" name="contractor"><%while(rs1.next()){%><option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%}%></select> </td>
                    <td align="right" style=" float: left; vertical-align: top;">
                        <a href="#" onclick="saveream(<%=rs.getString("rid")%>,<%=rs.getString("id")%>)"><img alt=""  width="20" src="images/proc.png"></a>
                        <a onclick="return ask()" href="del.jsp?tab=reel&id=<%=rs.getString(1)%>&quality=<%=qual%>" id="del"><img alt=""  width="20" src="images/del.png"></a></td>
                </tr>
		
	

<%}%>
                            </tbody>
	<tfoot>
		<tr>
			<th>S No</th>
			<th>Reel Id</th>
			<th>Quality</th>
			<th>Entry</th>
                        <th>Weight</th>
                        <th>Size</th>
                        <th>GSM</th>
                        <th>P-Size</th>
                        <th>Rulling</th>
                        <th>Estimated Ream</th>
                        <th>Contractor</th>
                        <th>Action</th>
		</tr>
	</tfoot>
</table>
                                    <%
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