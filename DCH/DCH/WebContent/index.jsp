<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
		<title>Diwakar Copy House v1.4.1</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-15" />
		<link rel="stylesheet" href="styles.css" />
                <script type="text/javascript" src="jquery-1.4.3.min.js"></script>
	<script>
		!window.jQuery && document.write('<script src="jquery-1.4.3.min.js"><\/script>');
	</script>
	<script type="text/javascript" src="fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
	<script type="text/javascript" src="fancybox/jquery.fancybox-1.3.4.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="fancybox/jquery.fancybox-1.3.4.css" media="screen" />
                <script type="text/javascript">
                    function foc(){
                        document.getElementById("pass").focus();
                    }
		$(document).ready(function() {
			$("a#example2").fancybox({
				'overlayShow'	: false,
				'width'		: '50%',
				'height'	: '30%',
				'autoScale'	: false,
                                'transitionIn'	: 'elastic',
				'transitionOut'	: 'elastic',
                                'type'		: 'iframe'

			});
                        $("a#example3").fancybox({
				'overlayShow'	: false,
				'width'		: '70%',
				'height'	: '100%',
				'autoScale'	: false,
                                'transitionIn'	: 'elastic',
				'transitionOut'	: 'elastic',
                                'type'		: 'iframe',
                                'align'         : 'center'
			});
		});


			$(function(){
                        $("#accordion").accordion({
                            header: "h3",

                        autoHeight: true,
			navigation: true
                        });
				// Tabs
				$('#tabs').tabs();
			});
		</script>
	</head>
    <body onload="foc()" >
	<div id="conteneur">
		  <div id="header">
                      <img src="diwakar.png" alt="jdalksd" width="300" height="130"></img>
                  </div>
                    <div id="centre">
			
                        <table align="center" >
                            
                            <tr align="right" >
                                <td align="left" width="70%"><img src="infi.png" alt="logo" width="464" height="171"></img></td>
                                <td width="30%" align="right" >
                        <form action="validate.jsp" method="post">
                 <table id="login">
                <tr><td colspan="2" align="center" > <img src="pass.png" alt="" width="100"> </td></tr>
            <tr><td id="un" >Username</td><td><input  type="text" value="admin" name="username" onfocus="document.getElementById('login').style.background='#3882C7';document.getElementById('un').style.col='#fafafa'" ></td></tr>
            <tr><td><div id="un">Password</div></td><td><input type="password" onfocus="document.getElementById('login').style.background='#3882C7';document.getElementById('un').style.col='#fafafa'"  id="pass" name="password"></td></tr>
            <tr><td colspan="2" align="right" ><input type="submit" id="but" value="Login"> </td> </tr>
            <tr><td colspan="2" align="right">Version 1.4.2<br>Date 1-May-17<br/>Prev Deploy Date 25-Oct-16</td></tr>

        </table>
            </form></td>
                            </tr></table>
			</div>
            <div id="pied"><jsp:include page="footer.html"></jsp:include></div>
	</div>
        <br></br>
        <br><br>
	</body>
</html>
