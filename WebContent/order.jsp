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

		<title>Home > Select Party</title>
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
            <h2 id="cmd">Home > Select Party</h2>
<table cellpadding="0" cellspacing="0" border="0" class="display" id="example1" width="100%">
	<thead>
            <tr style=" padding: 0em;" >
			<th>S No</th>
			<th>Name</th>
			<th>Address</th>
			<th>Tin</th>
                        <th>Phone</th>
			<th>Transport</th>
		</tr>
	</thead>
        <tbody>
<%
String serv=request.getParameter("serv");
Connection cn = null;
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            Statement st2=cn.createStatement();
                            ResultSet rs = st.executeQuery("Select * from party where sta='a' order by name");

                            int i=0;
                            while(rs.next()){
                                i++;
%>


		<tr  >
                    <td style="width: 1em;"  ><%=i%></td>
                    <td align="left" ><a href="order2.jsp?serv=<%=serv%>&party=<%=rs.getInt("id")%>&name=<%=rs.getString("name")+", "+rs.getString("addr")%>"><%=rs.getString("name")%></a></td>
                    <td align="center" ><%=rs.getString("addr")%></td>
                    <td align="left" ><%=rs.getString("tin")%></td>
                    <td align="left" ><%=rs.getString("pno")%></td>
                    <td align="left"><%=rs.getString("trans")%></td>
                </tr>



<%}%>
                            </tbody>
	<tfoot>
		<tr>
			<th>S No</th>
			<th>Name</th>
			<th>Address</th>
			<th>Tin</th>
            <th>Phone</th>
			<th>Transport</th>
                        
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