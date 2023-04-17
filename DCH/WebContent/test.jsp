<html>
    <head>
          <script type="text/javascript" src="jquery-1.4.3.min.js"></script>
	<script>
		!window.jQuery && document.write('<script src="jquery-1.4.3.min.js"><\/script>');
	</script>
	<script type="text/javascript" src="fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
	<script type="text/javascript" src="fancybox/jquery.fancybox-1.3.4.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="fancybox/jquery.fancybox-1.3.4.css" media="screen" />

   <script type="text/javascript">
		$(document).ready(function() {
			$("a#example2").fancybox({
				'overlayShow'	: false,
				'width'		: '40%',
				'height'	: '40%',
				'autoScale'	: false,
                                'transitionIn'	: 'elastic',
				'transitionOut'	: 'elastic',
                                'type'		: 'iframe'

			});
		});
	</script>


    </head>
    <body>
        <a id="example2" href="index.jsp" >Home</a>
    </body>
</html>