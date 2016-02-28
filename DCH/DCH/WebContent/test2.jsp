 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>
 <head>
<style type="text/css" title="currentStyle">
@import "media/css/demo_table.css";
@import "media/css/jquery.dataTables_themeroller.css";
</style>
                <script type="text/javascript" language="javascript" src="media/js/jquery.dataTables.js"></script>
                <script type="text/javascript" src="js/jquery-1.2.6.min.js"></script>
                <script type="text/javascript" charset="utf-8">

    $(document).ready(function() {
    oTable = $('#example').dataTable({
        "bJQueryUI": true,
        "sPaginationType": "full_numbers"
    });
} );

</script>
 </head>
 <body>
        <%
        String q=request.getParameter("q");

        //out.print(""+q+"");
        out.print("<br>");


        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps = cn.prepareStatement(q);
                            ResultSet rs = ps.executeQuery();
                            Statement st=cn.createStatement();
                            ResultSet rs1=null;
                            out.print("<table  cellpadding='0' cellspacing='0' border='0' class='display' id='example' width='100%'>");
                            out.print("<thead><tr><th>Sno.</th><th>ID</th><th>Paper Type</th><th>Quality</th><th>Size</th><th>Wt</th><th>Entry</th><th>Status</th><th>Updated</th><th>Action</th></tr></thead><tbody>");
                            int i=0;
                            while(rs.next()){
                                i++;
                                rs1=st.executeQuery("Select * from size where id="+rs.getString("size"));
                                rs1.next();
                            out.print("<a name='"+rs.getInt(1)+"'><tr class='gradeA' id='r"+rs.getString(1)+"' align='center'><td>"+i+"</td><td>"+rs.getString("rid")+"</td>"+"<td>"+rs.getString("papertype")+"</td>"+"<td>"+rs.getString("quality")+"</td>"+"<td>"+rs1.getString("size")+"</td>"+"<td>"+rs.getString("wt")+"</td>"+"<td>"+rs.getString("dat")+"</td>"+"<td id='sta"+rs.getString(1)+"' >"+rs.getString("status")+"</td>"+"<td id='sdate"+rs.getString(1)+"' >"+rs.getString("sdate")+"</td><td id='action"+rs.getString(1)+"'>");
                            if(rs.getString("status").equals("raw")){
                            out.print("<a onclick='reamform("+rs.getInt(1)+")' href='#"+rs.getString(1)+"'>Process</a>");
                            }else{
                            out.print("<a onclick='reelhistory("+rs.getInt(1)+")'  href='#"+rs.getString(1)+"'><img src='green.jpg' width='30' height='30' ></a>");
                            }
                            out.print("</td></tr><tr><td colspan='10' align='right' id='"+rs.getInt(1)+"'></td></tr>");
                            }
                            out.print("</tbody></table>");
                            cn.close();
                        } catch (Exception ex) {
                            out.println(ex);
                        }
        %>
 </body>