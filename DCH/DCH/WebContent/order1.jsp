<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%
String party=request.getParameter("party");
String name=request.getParameter("name");
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

		<title><%=name%></title>
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
            <h2 id="cmd">Home > Select Party > Select Products</h2>
            <span><%=name%></span> 
<table cellpadding="0" cellspacing="0" border="0" class="display" id="example1" width="100%">
	<thead>
            <tr style=" padding: 0em;" >
			<th>S No</th>
			<th>Product</th>
			<th>Bundle</th>
			<th>Loose</th>
                        <th>Size</th>
			<th>Action</th>
                        
		</tr>
	</thead>
        <tbody>
<%try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            Statement st2=cn.createStatement();
                            ResultSet rs = st.executeQuery("Select B.id,C.name,D.type,A.bundle,A.loose,A.bsize from bindquant as A, notebook as B,covtype as C,rulling as D where A.notebook=B.id and B.sta='a' and B.name=C.id and B.pno=D.id  order by C.name");

                            int i=0;
                            while(rs.next()){
                                i++;
%>


		<tr class="odd gradeA" >
                    <td style="width: 1em;"  ><%=i%></td>
                    <td align="left" ><%=rs.getString("C.name")+" "+rs.getString("D.type")%></td>
                    <td align="left" ><%=rs.getString("A.bundle")%></td>
                    <td align="left" ><%=rs.getString("A.loose")%></td>
                    <td align="left"><%=rs.getString("A.bsize")%></td>
                    <td align="center">
                        <input size="5" type="text" name="b"><input size="5" type="text" name="l"><input size="5" type="text" name="s">
                        <a href="dispatch3.jsp?party=<%=rs.getInt("B.id")%>">Next</a></td>
                    <%--<td align="right" style=" float: left; vertical-align: top;"><a href="reamform.jsp?rid=<%=rs.getString("id")%>" id="example4" ><img width="20" src="images/proc.png"></a> <a id="example4" ><img width="20" src="images/edit.png"></a> <a onclick="return ask()" id="del"><img width="20" src="images/del.png"></a></td>--%>
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
}
%>



	</body>
</html>