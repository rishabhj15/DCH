<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%
String qual=request.getParameter("quality");
String stat=request.getParameter("status");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
            <style type="text/css">
                #cmd{
                    background-color: #009999 ;
                    color: whitesmoke;
                    font-weight: bold;
                    padding:0.5em;
}
            </style>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link rel="shortcut icon" type="image/ico" href="http://www.datatables.net/favicon.ico" />

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
<table cellpadding="0" cellspacing="0" border="0" class="display" id="example1" width="100%">
	<thead>
            <tr style=" padding: 0em;" >
			<th>S No</th>
			<th>Reel Id</th>
			<th>Quality</th>
			<th>Size</th>
                        <th>Entry Date</th>
			<th>Contractor</th>
                        <th>Process Date</th>
                        <th>Weight</th>
                        <th>Output</th>

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
                            ResultSet rs = st.executeQuery("Select * from reel as A,size as B,ream as C,contractor as D where A.status='"+stat+"' and A.size=B.id and A.quality='"+qual+"' and A.id=C.pid and D.id=C.contractor");

                            int i=0;
                            DecimalFormat deFormat = new DecimalFormat("0.00");
                            while(rs.next()){
                                i++;
%>

			
		<tr class="odd gradeA" >
                    <td style="width: 1em;"  ><%=i%></td>
                    <td align="center" ><%=rs.getString("rid")%></td>
                    <td align="center" ><%=rs.getString("quality")%></td>
                    <td align="center" ><%=rs.getString("B.size")%></td>
                    <td align="center" ><%=rs.getString("A.dat")%></td>
                    <td align="center"><%=rs.getString("D.name")%></td>
                    <td align="center"><%=rs.getString("C.dat")%></td>
                    <td align="center" ><%=rs.getString("A.wt")%></td>
                    <td align="center"><%=deFormat.format(rs.getDouble("C.quantity"))%></td>
                    
                    <%--<td align="right" style=" float: left; vertical-align: top;"><a href="reamform.jsp?rid=<%=rs.getString("id")%>" id="example4" ><img width="20" src="images/proc.png"></a> <a id="example4" ><img width="20" src="images/edit.png"></a> <a onclick="return ask()" id="del"><img width="20" src="images/del.png"></a></td>--%>
                </tr>



<%}%>
                            </tbody>
	<tfoot>
		<tr>
			<th>S No</th>
			<th>Reel Id</th>
			<th>Quality</th>
			<th>Size</th>
                        <th>Entry Date</th>
			<th>Contractor</th>
                        <th>Process Date</th>
                        <th>Weight</th>
                        <th>Output</th>
                        
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