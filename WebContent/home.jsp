<%--
    Document   : index
    Created on : Sep 26, 2011, 3:06:23 PM
    Author     : Rishabh
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="session.User"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            User u = (User) session.getAttribute("user");
            if (u != null) {
                String q = request.getParameter("q");%>

<html>
    <head>

        <title>Diwakar Copy House-<%=q%></title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-15" />
        <link rel="stylesheet" type="text/css" href="css/superfish.css" media="screen">
        <script type="text/javascript" src="js/jquery-1.2.6.min.js"></script>
        <script type="text/javascript" src="js/hoverIntent.js"></script>
        <script type="text/javascript" src="js/superfish.js"></script>
        <script type="text/javascript">

            // initialise plugins
            jQuery(function(){
                jQuery('ul.sf-menu').superfish();
            });

        </script>


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
            function checkdelform(){
                if(document.frm.tab[0].checked==false&&document.frm.tab[1].checked==false&&document.frm.tab[2].checked==false||document.frm.bfr.value==""){
                    alert("Select Atleast 1 Table");
                    return false;
                }
            }

            function showmsg(vtr){
                alert("To change Bundle Size Go To \n Manage Stock - Binded - Edit.");
            }
            function calcont(str){
                tot=0;
                for(i=1;i<=str;i++){
                    if(document.getElementById('r'+i).value==''){
                        document.getElementById('r'+i).value='0';
                    }
                    document.getElementById('amt'+i).value=parseFloat(document.getElementById('r'+i).value)*parseFloat(document.getElementById('b'+i).value);
                    tot=tot+parseFloat(document.getElementById('r'+i).value)*parseFloat(document.getElementById('b'+i).value);
                }
                document.getElementById('total').value=tot;
                document.getElementById('labt').value=tot;
                caldiff();
            }
            function caldiff(){
                if(document.getElementById('labt').value==""||document.getElementById('matt').value==""){
                    document.getElementById('labt').value=0;
                    document.getElementById('matt').value=0
                }
                t1=document.getElementById('labt').value;
                t2=document.getElementById('matt').value;
                document.getElementById('diff').value=parseFloat(t1)-parseFloat(t2);
            }
            function bmat(str,str1){
                //calcont(str1);
                tot=0;
                for(i=1;i<=str;i++){
                    if(document.getElementById('bprice'+i).value==''){
                        document.getElementById('bprice'+i).value='0';
                    }
                    document.getElementById('bamt'+i).value=parseFloat(document.getElementById('bprice'+i).value)*parseFloat(document.getElementById('bq'+i).value);
                    tot=tot+parseFloat(document.getElementById('bprice'+i).value)*parseFloat(document.getElementById('bq'+i).value);
                }
                document.getElementById('matt').value=tot;
                document.getElementById('btotal').value=tot;
        
                caldiff();
            }

            function updatetransact(tid){
                
                var t1=document.getElementById('t'+tid).value;
                var p1=document.getElementById('p'+tid).value;
                var ltn=document.getElementById('ltn'+tid).value;
                var tn=document.getElementById('tn'+tid);
                var tn1 = tn.options[tn.selectedIndex].text;
                //alert(tn1);
                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        $("#receiptmsg").fadeIn(2000);
                        document.getElementById("receiptmsg").innerHTML=xmlhttp.responseText;
                        $("#receiptmsg").fadeOut(2000);
                    }
                }
                xmlhttp.open("GET","updatetransact.jsp?id="+tid+"&parcel="+p1+"&transrec="+t1+"&transname="+tn1+"&localtransname="+ltn,true);
                xmlhttp.send();
            }
    
            function fetchreceipt(str){
                document.getElementById("receipt").innerHTML="<img src='loadimg.gif' align='center' alt='' width='50' height='50'>";
                var xmlhttp;
                var value=document.getElementById(str).value;
                query="select * from transact where "+str+"='"+value+"' order by id desc";
                if (value=="")
                {
                    alert("Enter Valid Data.");
                    document.getElementById("receipt").innerHTML="Invalid Input";
                    return;
                }
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("receipt").innerHTML=xmlhttp.responseText;

                    }

                }
                xmlhttp.open("GET","receiptsearch.jsp?q="+query,true);
                xmlhttp.send();
            }
            function calall(str){
                checkcov(str);
                var bundle=0;
                var loose=0;
                var bs=document.getElementById("bs"+str).value;
                var t=document.getElementById("total"+str).value;
                document.getElementById("bundle"+str).value=parseInt(t/bs);
                document.getElementById("loose"+str).value=parseInt(t%bs);
                //bundle=document.getElementById("bundle"+str).value;
                return;
            }
            function calbun(str){
                checkcov(str);
                document.getElementById("total"+str).value='';
                var bundle=document.getElementById("bundle"+str).value;
                var loose=document.getElementById("loose"+str).value;
                var bs=document.getElementById("bs"+str).value;
                if(bundle==''){
                    //document.getElementById("bundle"+str).value='0';
                    //calbun(str);
                    //return;
                    document.getElementById("proceed"+str).disabled=true;
                    document.getElementById("total"+str).value=0;
                    return;
                }
                if(loose==''){
                    //document.getElementById("loose"+str).value='0';
                    //calbun(str);
                    document.getElementById("proceed"+str).disabled=true;
                    document.getElementById("total"+str).value=0;
                    return;
                }
                if(bs==''){
                    //document.getElementById("bs"+str).value='1';
                    //calbun(str);
                    document.getElementById("proceed"+str).disabled=true;
                    return;
                }


                var total=parseInt(bundle)*parseInt(bs);
                var total=parseInt(total)+parseInt(loose);
                document.getElementById("total"+str).value=parseInt(total);

                calall(str);
                document.getElementById("proceed"+str).disabled=false;
            }
            function calculatebundle(){
                var bundle=document.getElementById("bns").value;
                var loose=document.getElementById("los").value;
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
                }else{
                    var total=parseInt(bundle)*parseInt(bs);
                    var total=parseInt(total)+parseInt(loose);
                    document.getElementById("ts").value=parseInt(total);
                    checkcov(str);
                    document.getElementById("proceed").innerHTML="<input type='button' id='but'   onclick='submitbinded("+str+")' value='Proceed'>";
                }
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




            function valuate(frm){
                valid=true;
                if(frm.val.value==""){
                    alert("Invalid Data")   ;
                    valid=false;
                    frm.val.style.background ='#33CC00';
                    frm.val.focus();
                }
                return valid;
            }
            function valuatenotebook(frm){
                valid=true;
                if(frm.name.value==""){
                    alert("Invalid Data")   ;
                    valid=false;
                    frm.name.style.background ='#33CC00';
                    frm.name.focus();
                    return valid;
                }
                if(frm.pno.value==""){
                    alert("Invalid Data")   ;
                    valid=false;
                    frm.pno.style.background ='#33CC00';
                    frm.pno.focus();
                }
                return valid;
            }
            function valuatecontractor(frm){
                valid=true;
                if(frm.name.value==""){
                    alert("Invalid Data")   ;
                    valid=false;
                    frm.name.style.background ='#33CC00';
                    frm.name.focus();
                    return valid;
                }
                if(frm.rate.value==""){
                    alert("Invalid Data")   ;
                    valid=false;
                    frm.rate.style.background ='#33CC00';
                    frm.rate.focus();
                }
                return valid;
            }
            function expand(id){
                var i=parseInt(id);
                document.getElementById("ut").value=document.getElementById("u"+i).innerHTML;
                document.getElementById("pt").value=document.getElementById("p"+i).innerHTML;
                document.getElementById("jt").value=i;
            }
            function checkin(){
                var1=document.getElementById("nq").value;
                var2=document.getElementById("covq").innerHTML;
                if(document.getElementById("nq").value==""){
                    document.getElementById("check").innerHTML="Enter Smaller Value Than"+var2;
                }else{
                    if(parseFloat(var1)<=parseFloat(var2)&&parseFloat(var1)>0){
        
                        check();

                    }else{
                        document.getElementById("nq").value=parseInt(var2);
                    }
                }
            }

            function check(){
                var1=document.getElementById("bind").value;
                var2=document.getElementById("avl").value;
                if(document.getElementById("bind").value==""){
                    document.getElementById("check").innerHTML="Enter Smaller Value Than"+var2;
                }else{

    

                    if(parseFloat(var1)<=parseFloat(var2)&&parseFloat(var1)>0){
                        document.getElementById("check").innerHTML="<input type='button' onclick='submitbind()' id='but' value='Proceed'>";

                    }else{
                        document.getElementById("check").innerHTML="Enter Value baetween 0 and"+var2;
                    }
                }
            }


            function texthint(){
                str=document.getElementById("skey").value;
                query="select * from reel where rid="+str;
                document.getElementById("result").innerHTML="<img src='loadimg.gif' id='load' alt='' width='50' height='50'>";
                var xmlhttp;
                if (str=="")
                {
                    document.getElementById("result").innerHTML="Write Something";
                    return;
                }
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("result").innerHTML=xmlhttp.responseText;
                    }
                }
                xmlhttp.open("GET","search.jsp?q="+query,true);
                xmlhttp.send();
            }
            function checkcov(r){
                str=document.getElementById("nbid"+r).value;

                //document.getElementById("covqu").innerHTML="<span><img src='loadimg.gif' id='load' alt='' width='10' height='10'></span>";
                var xmlhttp;
                if (str=="")
                {
                    document.getElementById("covqu"+r).innerHTML="Write Something";
                    return;
                }
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("covqu"+r).innerHTML=xmlhttp.responseText;
                    }
                }
                xmlhttp.open("GET","covcheck.jsp?q="+str,true);
                xmlhttp.send();
            }
            function check1(){
                str=document.getElementById("nb").value;
        
                // document.getElementById("covq").innerHTML="<span><img src='loadimg.gif' id='load' alt='' width='10' height='10'></span>";
                var xmlhttp;
                if (str=="")
                {
                    document.getElementById("covq").innerHTML="Write Something";
                    return;
                }
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("covq").innerHTML=xmlhttp.responseText;
                    }
                }
                xmlhttp.open("GET","covcheck.jsp?q="+str,true);
                xmlhttp.send();
            }
            function texthint1(col,but){
                //str=document.getElementById("slist").value;
                str=document.getElementById(col).value;
                query="select * from reel where "+col+"='"+str+"' and status='"+but.value+"'";
                document.getElementById("result").innerHTML="<img src='loadimg.gif' align='center' id=load alt='' width='50' height='50'>";
                var xmlhttp;
                if (str=="select")
                {
                    document.getElementById("result").innerHTML="Select Something";
                    return;
                }
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("result").innerHTML=xmlhttp.responseText;
                    }
                }
                xmlhttp.open("GET","search.jsp?q="+query,true);
                xmlhttp.send();
            }
            function reamform(str){
                var xmlhttp;
                if (str=="")
                {
                    document.getElementById("str").innerHTML="Select Something";
                    return;
                }
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {

                        document.getElementById('action'+str).innerHTML='V';
                        document.getElementById('r'+str).style.background ='#dedede'
                        document.getElementById(str).innerHTML=xmlhttp.responseText;
                        document.getElementById(str).style.background ='#dedede'
                    }
    
                }
                xmlhttp.open("GET","reamform.jsp?rid="+str,true);
                xmlhttp.send();
            }

            function reelhistory(str){
                var xmlhttp;
                if (str=="")
                {
                    document.getElementById("str").innerHTML="Select Something";
                    return;
                }
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {

                        //document.getElementById('action'+str).innerHTML='V';
                        document.getElementById('r'+str).style.background ='#dedede'
                        document.getElementById(str).innerHTML=xmlhttp.responseText;
                        document.getElementById(str).style.background ='#dedede'
                    }

                }
                xmlhttp.open("GET","reelhistory.jsp?id="+str,true);
                xmlhttp.send();
            }

            function submitream(str){
                var xmlhttp;
                var rid=document.getElementById('reamrid'+str).value;
                var size=document.getElementById('reamsize'+str).value;
                var rulling=document.getElementById('reamrulling'+str).value;
                var contractor=document.getElementById('reamcontractor'+str).value;
                var quantity=document.getElementById('reamquantity'+str).value;
                if(quantity==''){
                    alert('Insert quantity value for reel '+str);
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
                            document.getElementById(str).innerHTML=xmlhttp.responseText;
                            //$("#"+str).slideUp(2000);
                            //document.getElementById(str).innerHTML="<h2 align='center' style='background-color: firebrick; color: white;'>Updated Successfully</h2>";
                            //$("#"+str).show();
                            //$("#"+str).fadeOut(4000);
                            //document.getElementById('action'+str).style.background='#ffffff';
                            //document.getElementById('action'+str).innerHTML='<img src=green.jpg width=30 height=30>  ';
                            //document.getElementById('sdate'+str).innerHTML='a moment ago.';
                            //document.getElementById('sta'+str).innerHTML='Rulled';
                        }

                    }
                    xmlhttp.open("GET","saveream.jsp?rid="+rid+"&size="+size+"&rulling="+rulling+"&contractor="+contractor+"&quantity="+quantity,true);
                    xmlhttp.send();
                }
            }


            function submitbinded(str){
                var xmlhttp;
                //var bundle=document.getElementById('bundle'+str).value;
                //var loose=document.getElementById('loose'+str).value;
                //var quality=document.getElementById('quality'+str).value;
                //var psize=document.getElementById('psize'+str).value;
                //var rulling=document.getElementById('rulling'+str).value;
                var nb=document.getElementById('notebook'+str).value;
                var bid=document.getElementById('bid'+str).value;
                var total=document.getElementById('total'+str).value;
                var cov=document.getElementById('covqu'+str).innerHTML;
                //var size=document.getElementById('bs'+str).value;
                //if(bundle==''||loose==''||total==''||total=='0'){
                if(total==''||total=='0'){
                    alert('Insert Valid Bunlde and Loose Values.');
                    document.getElementById('total'+str).focus();
                    return;
                }
                if(parseInt(cov)<parseInt(total)){
                    alert("Notebook quantity should be less than available covers.\n\
        Available Covers:"+parseInt(cov)+"\n\
        Total Notebook  :"+total);
                    return;
                }
                /*if(parseInt(size)<1||size==""){
                    alert("Invalid size."+size);
                    return;
                }*/
                else{
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp=new XMLHttpRequest();
                    }
                    xmlhttp.onreadystatechange=function()
                    {
                        if (xmlhttp.readyState==4 && xmlhttp.status==200)
                        {

                            document.getElementById("side").innerHTML=xmlhttp.responseText;
                            proposedsearch();
                            $("#side").show();
                            //$("#side").fadeOut(4000);

                            //texthint2();
                            //document.getElementById("side").innerHTML="<h2 align='center' style='background-color: firebrick; color: white;'>Updated Successfully</h2>";
                            //$("#upmsg").show();
                            //$("#upmsg").fadeOut(4000);

                        }

                    }
                    xmlhttp.open("GET","savebinded.jsp?bid="+bid+"&notebook="+nb+"&total="+total,true);
                    xmlhttp.send();
                }
            }
            function submitbind(){
                var xmlhttp;
                var contr=document.getElementById('bindcontr').value;
                var notebook=document.getElementById('nb').value;
                var notebookq=document.getElementById('nq').value;
                var bind=document.getElementById('bind').value;
                var bavl=document.getElementById('avl').value;
                var quality=document.getElementById('bindquality').value;
                var psize=document.getElementById('bindpsize').value;
                var rulling=document.getElementById('bindrulling').value;
                if(notebookq==''||bind==''){
                    alert('Insert quantity value for notebook. ');
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

                            //document.getElementById("res").innerHTML=xmlhttp.responseText;
        
                            //texthint2();
                            document.getElementById("res").innerHTML="<h2 align='center' style='background-color: firebrick; color: white;'>Updated Successfully</h2>";
                            //$("#res").show();
                            //$("#res").fadeOut(4000);
                            document.getElementById("res").innerHTML=xmlhttp.responseText;
                        }

                    }
                    xmlhttp.open("GET","savebind.jsp?contr="+contr+"&notebook="+notebook+"&notebookq="+notebookq+"&bind="+bind+"&bavl="+bavl+"&quality="+quality+"&psize="+psize+"&rulling="+rulling,true);
                    xmlhttp.send();
                }
            }
            function texthint2(r){
                //alert(r);
                document.getElementById("res").innerHTML="<img src='loadimg.gif' align=left id=load alt='' width='50' height='50'>";
                s1=document.getElementById(r+"s1").value;
                s3=document.getElementById(r+"s3").value;
                s4=document.getElementById(r+"s4").value;
                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("res").innerHTML=xmlhttp.responseText;
                        check1();
                    }
                }
                xmlhttp.open("GET","reamsearch.jsp?q1="+s1+"&q3="+s3+"&q4="+s4,true);
                xmlhttp.send();
            }
            function savebind(){
                t1=document.getElementById("d1").value;
                t2=document.getElementById("d2").value;
                t3=document.getElementById("d3").value;
                t4=document.getElementById("d4").value;
                t5=document.getElementById("d5").value;
                t6=document.getElementById("d6").value;
                t7=document.getElementById("d7").value;
                t8=document.getElementById("avl").value;
                document.getElementById("res").innerHTML="Saving<img src='loadimg.gif' align='center' id=load alt='' width='50' height='50'>";
                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("res").innerHTML=xmlhttp.responseText;
                        //texthint2();
                    }
                }
                xmlhttp.open("GET","savebind.jsp?contr="+t1+"&notebook="+t2+"&notebookq="+t3+"&bind="+t4+"&quality="+t5+"&psize="+t6+"&rulling="+t7+"bavl="+t8,true);
                xmlhttp.send();
            }
            function texthint3(){
                s1=document.getElementById("nb").value;
                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("bsizediv").innerHTML=xmlhttp.responseText;
                    }
                }
                xmlhttp.open("GET","bsizesearch.jsp?q1="+s1,true);
                xmlhttp.send();
            }
            function showreamtab(){
                s1=document.getElementById("reamquant").value;
                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("reamtab").innerHTML=xmlhttp.responseText;
                        oTable = $('#example').dataTable({
                            "bJQueryUI": true,
                            "bStateSave": true,
                            "sPaginationType": "full_numbers"

                        });
                        $("a#example4").fancybox({
                            'overlayShow'	: false,
                            'width'		: '60%',
                            'height'	: '70%',
                            'autoScale'	: false,
                            'transitionIn'	: 'elastic',
                            'transitionOut'	: 'elastic',
                            'type'		: 'iframe',
                            'onClosed': function() {
                                parent.location.reload(true);
                            }



                        });
                    }
                }
                xmlhttp.open("GET","index2.jsp?q1="+s1,true);
                xmlhttp.send();
            }
            function proposedsearch(){
                s1=document.getElementById("se2").value;
                //s3=document.getElementById("se").value;
                //s4=document.getElementById("s4").value;
                document.getElementById("res2").innerHTML="<img src='loadimg.gif' alt='' width='50' height='50'>";
                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("res2").innerHTML=xmlhttp.responseText;
    
                    }
                }
                xmlhttp.open("GET","proposedsearch.jsp?q1="+s1,true);
                xmlhttp.send();
            }
            function texthint4(t){
                se2=document.getElementById("se2").value;
                se3=document.getElementById("se3").value;
                frm=document.getElementById("frm").value;
                to=document.getElementById("to").value;
                if(frm==""||to==""){
                    alert("Select dates.");
                    document.getElementById("frm").style.background="#33CC00"  ;
                    document.getElementById("to").style.background="#33CC00"  ;
                    document.getElementById("frm").focus();
                    return;
                }else{
                    document.getElementById("frm").style.background="#ffffff"  ;
                    document.getElementById("to").style.background="#ffffff"  ;
                }
                if(t=='ream'){
                    document.getElementById("res2").innerHTML="<img src='loadimg.gif' alt='' width='50' height='50'>";
                    qry="select * from "+t+" where contractor='"+se2+"' and dat between '"+frm+"' and '"+to+"'";
                    qry1="";
                }else{
                    document.getElementById("res3").innerHTML="<img src='loadimg.gif' alt='' width='50' height='50'>";
                    qry="select * from "+t+" as A,bindqual as B where contractor='"+se3+"' and A.sta='processed' and A.bindqualid=B.id and dat between '"+frm+"' and '"+to+"'";
                    qry1="select * from bindmatreq as A,bindmat as B where A.contractor='"+se3+"' and A.bindmatid=B.id and A.dat between '"+frm+"' and '"+to+"'";
                }
                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        if(t=='bind'){
                            document.getElementById("res3").innerHTML=xmlhttp.responseText;
                        }else if(t=='ream'){
                            document.getElementById("res2").innerHTML=xmlhttp.responseText;}
                    }
                }
                xmlhttp.open("GET","contractsearch.jsp?q="+qry+"&t="+t+"&q1="+qry1,true);
                xmlhttp.send();
            }

        </script>
        <script type="text/javascript">
            function fetch(){
                var c=document.getElementById("quant").value;
                if(document.getElementById("quant").value==''){
                    alert('Enter Quantity');
                    return;
                }else{
                    var res='<td colspan=2><form action=savestock.jsp  method=post><table align=center id=asform >\n\
    <tr><th>SNo.</th><th>Id</th><th>Weight</th></tr>';
                    for(var i=1;i<=c;i++){
                        res=res+'<tr><td id=sno>'+i+'</td><td><input id=d'+i+' type=text size=10 name=id></td><td><input type=text id=wt'+i+' onkeyup=sumwt() name=w size=10></td></tr>';
                    }
                    res=res+'<tr><td colspan=3 align=right id=sum></td></tr><tr><td colspan=3 align=right ><input type=submit id=but value=Add></td></table></form></td>';
                    document.getElementById('m').innerHTML=res;
                }
            }
            function checkall(){
                valid=true;            
                var c=document.getElementById("quant").value;
                for(var i=1;i<=c;i++){
                    if(document.getElementById("d"+i).value==''||document.getElementById("wt"+i).value==''){
                        valid=false;
                        alert("All Fields Should Be Filled.");
                        return valid;
                    }
                }
                return valid;
            
            }
            
            function sumwt(){
                //alert("yippie");
                var c=document.getElementById("quant").value;
                var resl=0;
                for(var i=1;i<=c;i++){
                    //alert(parseFloat(document.getElementById("wt"+i).value));
                    if(document.getElementById("wt"+i).value==""){
                        resl=resl+0;
                    }else{
                        resl=resl+parseFloat(document.getElementById("wt"+i).value);
                    }
                }
                
                document.getElementById('sum').innerHTML=resl;
            }
        </script>
        <script type="text/javascript">
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
                $("a#example4").fancybox({
                    'overlayShow'	: false,
                    'width'		: '60%',
                    'height'	: '70%',
                    'autoScale'	: false,
                    'transitionIn'	: 'elastic',
                    'transitionOut'	: 'elastic',
                    'type'		: 'iframe',
                    'onClosed': function() {
                        parent.location.reload(true);
                    }



                });
                $("a#example5").fancybox({
                    'overlayShow'	: false,
                    'width'		: '60%',
                    'height'	: '70%',
                    'autoScale'	: false,
                    'transitionIn'	: 'elastic',
                    'transitionOut'	: 'elastic',
                    'type'		: 'iframe'});

                $("a#example3").fancybox({
                    'overlayShow'	: false,
                    'width'		: '100%',
                    'height'	: '100%',
                    'autoScale'	: false,
                    'transitionIn'	: 'elastic',
                    'transitionOut'	: 'elastic',
                    'type'		: 'iframe'

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
            <%if (q.equals("viewStock2")) {%>
                    $('#tabs ul li a').click(function () {
                        location.hash = $(this).attr('href');});
            <%}%>
                });
        </script>
                <script type="" >

            var dayarray=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
            var montharray=new Array("January","February","March","April","May","June","July","August","September","October","November","December")

            function getthedate(){
                var mydate=new Date()
                var year=mydate.getYear()
                if (year < 1000)
                    year+=1900
                var day=mydate.getDay()
                var month=mydate.getMonth()
                var daym=mydate.getDate()
                if (daym<10)
                    daym="0"+daym
                var hours=mydate.getHours()
                var minutes=mydate.getMinutes()
                var seconds=mydate.getSeconds()
                var dn="AM"
                if (hours>=12)
                    dn="PM"
                if (hours>12){
                    hours=hours-12
                }
                if (hours==0)
                    hours=12
                if (minutes<=9)
                    minutes="0"+minutes
                if (seconds<=9)
                    seconds="0"+seconds
                //change font size here
                var cdate="<font color='white' size='2' face='Arial'><b>"+dayarray[day]+", "+montharray[month]+" "+daym+", "+year+" "+hours+":"+minutes+":"+seconds+" "+dn
                    +"</b></font>"
                if (document.all)
                    document.all.clock.innerHTML=cdate
                else if (document.getElementById)
                    document.getElementById("clock").innerHTML=cdate
                else
                    document.write(cdate)
            }
            if (!document.all&&!document.getElementById)
                getthedate()
            function goforit(){
                if (document.all||document.getElementById)
                    setInterval("getthedate()",1000)
            }

        </script>
        <style type="text/css" title="currentStyle">
            @import "media/css/demo_table.css";
            @import "media/css/jquery.dataTables_themeroller.css";
        </style>
        <script type="text/javascript" language="javascript" src="media/js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {
                oTable = $('#exampley').dataTable({
                    "bJQueryUI": true,
                    "bStateSave": true,
                    "sPaginationType": "full_numbers"
                });
                oTable = $('#example').dataTable({
           
                    "bJQueryUI": true,
                    "bStateSave": true,
                    "sPaginationType": "full_numbers"

                });
                oTable = $('#examplex').dataTable({
                    "bJQueryUI": true,
                    "bStateSave": true,
                    "sPaginationType": "full_numbers"
                });
    
            } );
        </script>

    </head>
    <body onLoad="goforit() ;">
    
    <%
    Connection cn = null;
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Conf c = new Conf();
        cn = DriverManager.getConnection(c.getURL());
	%>

        <div id="conteneur">
            <div id="header">
                <table width="100%" ><tr><td width="40%" ><img src="diwakar.png" alt="" width="250" height="100"></td>
                        <td align="right" width="60%" valign="top" ><span id="clock"></span></td></tr></table>


            </div>

            <div id="haut">

                <ul class="menuhaut">
                    <li<%if (q.equals("welcome")) {%> id="this"<%}%>> <a href="home.jsp?q=welcome">Home</a></li>
                    <li<%if (q.equals("addStock")) {%> id="this"<%}%>> <a  href="home.jsp?q=addStock">Add Stock</a></li>
                    <li<%if (q.equals("viewStock1")) {%> id="this"<%}%>> <a  href="home.jsp?q=viewStock1">Manage Stock</a></li>
                    <li<%if (q.equals("viewStock2")) {%> id="this"<%}%>> <a  href="home.jsp?q=viewStock2">Manage Product</a></li>
                    <li<%if (q.equals("order")) {%> id="this"<%}%>> <a href="home.jsp?q=order">Orders</a></li>
                    <li<%if (q.equals("print")) {%> id="this"<%}%>> <a  href="home.jsp?q=print">Receipt</a></li>
                    <li<%if (q.equals("contractor")) {%> id="this"<%}%>> <a  href="home.jsp?q=contractor">Contractor</a></li>
                    <li<%if (q.equals("db")) {%> id="this"<%}%>> <a href="home.jsp?q=db">Database</a></li>
                    <li<%if (q.equals("history")) {%> id="this"<%}%>> <a href="home.jsp?q=history">History</a></li>
                    <li> <a href="logout.jsp">Logout</a></li>

                </ul>
            </div>

            <div id="centre">
                <div>

                </div>
                <div id="container">
                    <%
                         Statement st = cn.createStatement();
                         Statement st1 = cn.createStatement();
                         Statement st2 = cn.createStatement();
                         Statement st3 = cn.createStatement();
                         Statement st4 = cn.createStatement();
                         ResultSet rs;
                         if (q.equals("addStock")) {


                    %>
                    <h2 id="cmd">Add Stock</h2>
                    <div id="tabs">
                        <ul>
                            <li><a href="#fragment-1"><span>Paper</span></a></li>
                            <li><a href="#fragment-2" ><span>Cover</span></a></li>
                            <li><a href="#fragment-3"><span>Add Binded</span></a></li>
                            <li><a href="#fragment-4"><span>Add Reamed</span></a></li>
                            <li><a href="#fragment-5"><span>Add Binding Material</span></a></li>


                        </ul>

                        <div id="fragment-1">
                            <form action="savestock.jsp" onsubmit="return checkall()" autocomplete="off" method="post">
                                <fieldset>
                                    <legend>Add Paper:</legend>
                                    <table align="center"  >

                                        <tr>
                                            <td>Paper Type</td><td><select class="chzn-select" name="papertype"><option value="Reel">Reel</option><option value="Sheet">Sheet</option></select> </td>
                                        </tr>
                                        <tr>
                                            <%rs = st.executeQuery("Select * from quality where sta='a'  order by quality");%>
                                            <td>Quality</td><td><select class="chzn-select" name="quality"> <%while (rs.next()) {%><option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option><%}%></select> </td>
                                        </tr>
                                        <tr>
                                            <%rs = st.executeQuery("Select * from size where sta='a' order by size");%>
                                            <td>Size</td><td><select class="chzn-select" name="size"> <%while (rs.next()) {%><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select> </td>
                                        </tr>



                                        <tr>
                                            <td>Quantity</td><td><input type="text"  size="5" id="quant" name="quantity"> &nbsp;<input type="button" id="but" onclick="fetch()" value="Enter Details" ></td>
                                        </tr>
                                        <tr id="m" >

                                        </tr>

                                    </table>
                                </fieldset>
                            </form>
                        </div>
                        <div id="fragment-2">
                            <form action="savecover.jsp">
                                <fieldset>
                                    <legend>Add Cover:</legend>
                                    <table  align="center">
                                        <tr>
                                            <td>Type</td>
                                            <%rs = st.executeQuery("Select * from covtype where sta='a' order by name");%>
                                            <td><select class="chzn-select" name="covtype" id="cov" >
                                                    <%while (rs.next()) {%><option value="<%=rs.getInt(1)%>" ><%=rs.getString(2)%> | <span id="avl" >Available <%=rs.getString(3)%> </span></option><%}%>
                                                </select>
                                                <div id="cov"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Quantity</td><td><input type="text" size="5" name="quantity"> </td>
                                        </tr>
                                        <tr align="right"><td colspan="2"><input type="submit" id="but" value="Add"> </td></tr>
                                    </table>
                                </fieldset>
                            </form>
                        </div>
                        <div id="fragment-3">
                            <form action="savemain.jsp" method="post" autocomplete='off'>
                                <fieldset>
                                    <legend>Add Binded:</legend>
                                    <table>

                                        <input type="hidden" id="s1" name="quality" value="Manual Entry" >
                                        <tr><%rs = st.executeQuery("Select * from papersize where sta='a'");%>
                                        <input type="hidden"  name="psize" value="Manual Entry" >

                                        <td>Notebook</td>
                                        <%rs = st.executeQuery("Select * from notebook where sta='a' order by name");%>

                                        <td><select class="chzn-select" onchange="texthint3()" id="nb" name="notebook"><option value="default" selected >Select</option>
                                                <%while (rs.next()) {%>
                                                <%ResultSet rs1 = st1.executeQuery("Select A.name,B.type from covtype A,rulling B where A.id=" + rs.getString(2) + " and B.id=" + rs.getString(3));
                                            rs1.next();%>
                                                <option value="<%=rs.getString(1)%>"><%=rs1.getString(1) + " " + rs1.getString(2)%></option><%}%></select></td></tr>
                                        <tr><td colspan="2"><div id="bsizediv">

                                                </div></td></tr>
                                    </table>
                                </fieldset>
                            </form>

                        </div>
                        <div id="fragment-4">
                            <form autocomplete='off' action="savemainream.jsp" method="post">
                                <fieldset>
                                    <legend>Add Reamed:</legend>
                                    <table>
                                        <tr>
                                            <%rs = st.executeQuery("Select * from quality where sta='a' order by quality");%>
                                            <td>Quality</td><td><select class="chzn-select" name="quality"><%while (rs.next()) {%><option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option><%}%></select> </td>

                                        </tr>
                                        <tr>
                                            <%rs = st.executeQuery("Select * from papersize where sta='a' order by type");%>
                                            <td>Paperize</td><td><select class="chzn-select" name="size"><%while (rs.next()) {%><option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option><%}%></select> </td>
                                        </tr>
                                        <tr>
                                            <%rs = st.executeQuery("Select * from rulling where sta='a' order by type");%>
                                            <td>Rulling</td><td><select class="chzn-select" name="rulling"><%while (rs.next()) {%><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select> </td>
                                        </tr>

                                        <tr>
                                            <td>Quantity</td><td><input type="text" size="5" name="quantity">&nbsp;&nbsp; <input type="submit"  id="but" value="Save"></td>


                                        </tr>
                                    </table>
                                </fieldset>
                            </form>



                        </div>
                        <div id="fragment-5">
                            <%rs = st.executeQuery("Select * from bindmat where sta='a' order by id");%>
                            <form action="savemat.jsp">
                                <fieldset>
                                    <legend>Add Binding Material:</legend>
                                    <table>
                                        <tr> <td align="right">Type</td><td><select name="bindmat" class="chzn-select" >
                                                    <%while (rs.next()) {%>
                                                    <option value="<%=rs.getInt(1)%>">
                                                        <%=rs.getString(2) + "| Available:" + rs.getString(4)%>
                                                    </option>
                                                    <%}%>
                                                </select></td> </tr>
                                        <tr>
                                            <td>Quantity</td><td> <input type="text" size="5" name="matq"> <input type="submit" value="Add" id="but" ></td>
                                        </tr>

                                    </table>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                                                <%
                                    } else if (q.equals("viewStock2")) {
                    %>
                    <h2 id="cmd">Manage Stock</h2>
                    <div id="tabs"><ul>
                            <li><a href="#fragment-5"><span>Binded</span></a></li>
                        </ul>
                         <div id="fragment-5">

                            <table cellpadding="0" cellspacing="0" border="0" class="display" id="examplex" width="100%">
                                <thead>
                                    <tr id="" ><th>Sno</th><th>Notebook</th><th>Q</th><th>Updated</th><th>Action</th></tr>
                                </thead>
                                <tbody>
                                    <%rs = st.executeQuery("Select A.notebook,A.bundle,A.loose,B.name,B.pno,C.name,D.type,A.id,A.quantity,A.updated,A.bsize from bindquant as A,notebook as B,covtype as C,rulling as D where A.notebook=B.id and B.name=C.id and B.pno=D.id order by C.name,D.type ");
                                                       int g = 0;
java.util.Date da=new java.util.Date();
String td = "all";
da.setDate(da.getDate() - 365);
String fd= "all";

                                                        while (rs.next()) {
                                                            g++;
                                                            ResultSet x = st1.executeQuery("SELECT DATEDIFF(now(),'" + rs.getDate("A.updated") + "')");
                                                            x.next();
                                                            ResultSet x1 = st3.executeQuery("SELECT count(*) from bind where bindquantid="+rs.getInt("A.notebook"));
                                                            x1.next();
                                                            ResultSet x2 = st4.executeQuery("SELECT count(*) from dispatch where particular='"+rs.getString("C.name") +" "+ rs.getString("D.type")+"'");
                                                            x2.next();
                        %>

                                    <tr <%if (1000 > rs.getInt("A.quantity")) {%> class="gradeX" <%} else {%> class="gradeA"<%}%>>
                                        <td><%=g%></td><td><%=rs.getString("C.name") + " " + rs.getString("D.type")%></td>
                                        <td><%=rs.getString("A.quantity")%></td>
                                        <td style=" <%if (x.getInt(1) < 1) {%> color:red; <%}%>  padding-left: 1em;  " ><%=rs.getString("A.updated") + "<br> " + x.getString(1) + " days ago."%></td>
                                        <td>
                                            <a id="example4" href="editbinded.jsp?id=<%=rs.getString("A.id")%>"><img alt=""  width="20" src="images/edit.png"></a>
                                            <a href="del.jsp?id=<%=rs.getString("A.id")%>&tab=bindquant&nbid=<%=rs.getString("A.notebook")%>" onclick="return ask()"><img alt=""  width="20" src="images/del.png"></a>
                                            <%if(x1.getInt(1)>=1||x2.getInt(1)>=1){%>                                            <a target="_blank" href="viewbindedhistory.jsp?fromd=<%=fd%>&tod=<%=td%>&id=<%=rs.getString("A.notebook")%>&prod=<%=rs.getString("C.name") + " " + rs.getString("D.type")%>"><img alt=""  width="20" src="images/hid.png" title="<%=x1.getInt(1)+":"+x2.getInt(1)%>"></a><%}%>
                                        </td>

                                    </tr>

                                    <%
                                                        }
                                    %>
                                </tbody>
                            </table>

                        </div>
                       
                    <%
                                    } else if (q.equals("viewStock1")) {
                    %>
                    <h2 id="cmd">Manage Stock</h2>
                    <div id="tabs">
                        <ul>
                            <li><a href="#fragment-1"><span>Raw Reel</span></a></li>
                            <li><a href="#fragment-2"><span>Rulled Reel</span></a></li>
                            <li><a href="#fragment-3"><span>Ream</span></a></li>
                            <li><a href="#fragment-4"><span>Proposed</span></a></li>
                            <li><a href="#fragment-6"><span>Binding Material</span></a></li>
                        </ul>

                        <div id="fragment-1">
                            <fieldset>
                                <legend>Raw Reel</legend>
                                <table>
                                    <tr id="viewtab">
                                        <th>S No</th><th>Quality</th><th>Raw Quantity</th><th>Raw Weight</th><th>Action</th>
                                    </tr>
                                    <%
                                                        rs = st.executeQuery("SELECT COUNT( * ) AS  `Rows` ,sum(wt) , `quality` FROM  `reel` where status='raw' GROUP BY  `quality` ORDER BY  `quality` ");
                                                        int y = 0;
                                                        while (rs.next()) {
                                                            y++;
                                    %>

                                    <tr><td><%=y%></td><td><%=rs.getString(3)%></td><td align="right" ><%=rs.getString(1)%></td><td align="right"><%=rs.getString(2)%></td><td colspan="2" align="center"><a href="rawreel.jsp?quality=<%=rs.getString(3)%>&status=raw" target="_blank" ><img src="images/view.png" width="40px"  style="padding:0px; " > </a></td></tr>

                                    <%
                                                        }
                                    %>
                                </table>
                            </fieldset>
                            <%--
                             <table><tr><td>
                             <table id="asform" >
                                 <tr><td>Search by Id</td></tr>
                                 <tr><td><input id="skey" type="text" name="key"></td></tr>
                                 <tr><td align="right"><input id="but" type="button" onclick="texthint()"  value="Search" > </td> </tr>
                             </table></td>
                             <td>
                                 <table id="asform" >
                                 <tr><td colspan="2">Search by Quality</td></tr>
                                 <%rs=st.executeQuery("Select * from quality where sta='a' order by quality");%>
                                 <tr><td colspan="2" >Quality<select class="chzn-select-deselect" id="quality" name="quality"><option value="" selected ></option> <%while(rs.next()){%><option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option><%}%></select></td></tr>
                                 <tr><td><input type="Button" id="but" value="raw" onclick="texthint1('quality',this)"> </td><td><input id="but" type="Button" value="rulled" onclick="texthint1('quality',this)"> </td></tr>
                             </table>
                             </td>
                                 <td>
                                 <table id="asform" >
                                 <tr><td colspan="2">Search by Size</td></tr>
                                 <%rs=st.executeQuery("Select * from size where sta='a' order by size");%>
                                 <tr><td colspan="2" >Size<select class="chzn-select-deselect" id="size" name="size"><option value="" selected></option> <%while(rs.next()){%><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select></td></tr>
                                 <tr><td><input type="Button" id="but" value="raw" onclick="texthint1('size',this)"> </td><td><input type="Button" id="but" value="rulled" onclick="texthint1('size',this)"> </td></tr>
                             </table>
                             </td>
                                 </tr></table>
                            --%>
                            <%--
                            PreparedStatement ps = cn.prepareStatement("Select * from reel as A,size as B where status='raw' and A.size=B.id");
                            rs = ps.executeQuery();
                                                 st=cn.createStatement();
                                                        %>
                                                        <table cellpadding='0' cellspacing='0' border='0' class='display' id='exampley' width='100%'>
                                                            <tr><th>Sno.</th><th>ID</th><th>Paper Type</th><th>Quality</th><th>Size</th><th>Wt</th><th>Entry</th><th>Status</th><th>Updated</th><th>Action</th></tr>
                            <%                            int i=0;
                                                        while(rs.next()){
                                                            i++;

                                                        out.print("<a name='"+rs.getInt(1)+"'><tr class='gradeX'  id='r"+rs.getString(1)+"' align='center'><td>"+i+"</td><td>"+rs.getString("rid")+"</td>"+"<td>"+rs.getString("papertype")+"</td>"+"<td>"+rs.getString("quality")+"</td>"+"<td>"+rs.getString("B.size")+"</td>"+"<td>"+rs.getString("wt")+"</td>"+"<td>"+rs.getString("dat")+"</td>"+"<td id='sta"+rs.getString(1)+"' >"+rs.getString("status")+"</td>"+"<td id='sdate"+rs.getString(1)+"' >"+rs.getString("sdate")+"</td><td id='action"+rs.getString(1)+"'>");
                                                        if(rs.getString("status").equals("raw")){
                                                        out.print("<a onclick='reamform("+rs.getInt(1)+")' href='#"+rs.getString(1)+"'>Process</a>");
                                                        }else{
                                                        out.print("<a onclick='reelhistory("+rs.getInt(1)+")'  href='#"+rs.getString(1)+"'><img src='green.jpg' width='30' height='30' ></a>");
                                                        }
                                                        out.print("</td></tr>");
                                                        }

                                    %>
                                                    </table>
                            --%>
                            <%--        <div id="result"></div>--%>
                        </div>
                        <div id="fragment-2">
                            <fieldset>
                                <legend>Rulled Reel</legend>
                                <table>
                                    <tr id="viewtab" >
                                        <th>S No</th><th>Quality</th><th>Total Weight</th><th>Count</th><th>Total Output</th><th>Action</th>
                                    </tr>
                                    <%DecimalFormat dFormat = new DecimalFormat("0.00");
                                    //rs = st.executeQuery("SELECT COUNT( * ) AS  `Rows` ,sum(wt) , `quality` FROM  `reel` where status='rulled' GROUP BY  `quality` ORDER BY  `quality` ");
                                                        rs = st.executeQuery("SELECT A.quality,sum(A.wt) , count( * ),sum( B.quantity ) FROM reel AS A, ream AS B WHERE A.status = 'rulled' AND A.id = B.pid GROUP BY A.quality ");
                                                        y = 0;
                                                        while (rs.next()) {
                                                            y++;
                                    %>
                                    <tr><td><%=y%></td><td><%=rs.getString(1)%></td><td align="right" ><%=rs.getString(2)%></td><td align="right"><%=rs.getString(3)%></td><td align="right" ><%=dFormat.format(rs.getDouble(4))%></td><td colspan="2" align="center"><a href="rulledreel.jsp?quality=<%=rs.getString("quality")%>&status=rulled" target="_blank" ><img src="images/view.png" width="40px"  style="padding:0px; " > </a></td></tr>
                                                <%
                                                                    }
                                                %>
                                </table>
                            </fieldset>
                            <%--
                             <table><tr><td>
                             <table id="asform" >
                                 <tr><td>Search by Id</td></tr>
                                 <tr><td><input id="skey" type="text" name="key"></td></tr>
                                 <tr><td align="right"><input id="but" type="button" onclick="texthint()"  value="Search" > </td> </tr>
                             </table></td>
                             <td>
                                 <table id="asform" >
                                 <tr><td colspan="2">Search by Quality</td></tr>
                                 <%rs=st.executeQuery("Select * from quality where sta='a' order by quality");%>
                                 <tr><td colspan="2" >Quality<select class="chzn-select-deselect" id="quality" name="quality"><option value="" selected ></option> <%while(rs.next()){%><option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option><%}%></select></td></tr>
                                 <tr><td><input type="Button" id="but" value="raw" onclick="texthint1('quality',this)"> </td><td><input id="but" type="Button" value="rulled" onclick="texthint1('quality',this)"> </td></tr>
                             </table>
                             </td>
                                 <td>
                                 <table id="asform" >
                                 <tr><td colspan="2">Search by Size</td></tr>
                                 <%rs=st.executeQuery("Select * from size where sta='a' order by size");%>
                                 <tr><td colspan="2" >Size<select class="chzn-select-deselect" id="size" name="size"><option value="" selected></option> <%while(rs.next()){%><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select></td></tr>
                                 <tr><td><input type="Button" id="but" value="raw" onclick="texthint1('size',this)"> </td><td><input type="Button" id="but" value="rulled" onclick="texthint1('size',this)"> </td></tr>
                             </table>
                             </td>
                                 </tr></table>
                            --%>
                            <%--
                            PreparedStatement ps = cn.prepareStatement("Select * from reel as A,size as B where status='raw' and A.size=B.id");
                            rs = ps.executeQuery();
                                                 st=cn.createStatement();
                                                        %>
                                                        <table cellpadding='0' cellspacing='0' border='0' class='display' id='exampley' width='100%'>
                                                            <tr><th>Sno.</th><th>ID</th><th>Paper Type</th><th>Quality</th><th>Size</th><th>Wt</th><th>Entry</th><th>Status</th><th>Updated</th><th>Action</th></tr>
                            <%                            int i=0;
                                                        while(rs.next()){
                                                            i++;

                            out.print("<a name='"+rs.getInt(1)+"'><tr class='gradeX'  id='r"+rs.getString(1)+"' align='center'><td>"+i+"</td><td>"+rs.getString("rid")+"</td>"+"<td>"+rs.getString("papertype")+"</td>"+"<td>"+rs.getString("quality")+"</td>"+"<td>"+rs.getString("B.size")+"</td>"+"<td>"+rs.getString("wt")+"</td>"+"<td>"+rs.getString("dat")+"</td>"+"<td id='sta"+rs.getString(1)+"' >"+rs.getString("status")+"</td>"+"<td id='sdate"+rs.getString(1)+"' >"+rs.getString("sdate")+"</td><td id='action"+rs.getString(1)+"'>");
                            if(rs.getString("status").equals("raw")){
                            out.print("<a onclick='reamform("+rs.getInt(1)+")' href='#"+rs.getString(1)+"'>Process</a>");
                            }else{
                            out.print("<a onclick='reelhistory("+rs.getInt(1)+")'  href='#"+rs.getString(1)+"'><img src='green.jpg' width='30' height='30' ></a>");
                            }
                            out.print("</td></tr>");
                            }

        %>
                        </table>
                            --%>
                            <%--        <div id="result"></div>--%>
                        </div>
                        <div id="fragment-3">
                            <div height="500"  align="center" colspan="3" id="res"></div>
                            <%-- <table><tr><td>
                                <table id="asform" >
                                    <tr><td colspan="2">Search by Quality</td></tr>
                                    <%rs=st.executeQuery("Select * from quality where sta='a' order by quality");%>
                                    <tr><td>Quality</td><td><select class="chzn-select-deselect" id="s1" onchange="texthint2()" name="quality"><option value="" selected ></option> <%while(rs.next()){%><option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option><%}%></select></td></tr>
                                </table></td>
                                    <td>
                                    <table id="asform" >
                                        <tr><td colspan="2">Select By Paper-Size</td></tr>
                                        <%rs=st.executeQuery("Select * from papersize where sta='a' order by type");%>
                                        <td>Size</td><td><select class="chzn-select-deselect" onchange="texthint2()" id="s3" name="size"><option value="" selected ></option><%while(rs.next()){%><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select> </td>
                                    </table></td>
                                    <td>
                                    <table id="asform" >
                                        <tr><td colspan="2">Select By Rulling</td></tr>
                                        <%rs=st.executeQuery("Select * from rulling where sta='a' order by type");%>
                                        <td>Rulling</td><td><select class="chzn-select-deselect" onchange="texthint2()" id="s4" name="size"><option value="" selected ></option><%while(rs.next()){%><option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option><%}%></select> </td>
                                </table>
                                </td>
                                </tr>
                                <tr><td colspan="3" id="upmsg"></td></tr>
                                <tr><td colspan="3" id="res">
                                </td></tr>

                            </table>--%>


                            <table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
                                <thead>
                                    <tr ><th>Sno</th><th>Quality</th><th>Paper-size</th><th>Rulling</th><th>Quantity</th><th>Updated</th><th>Action</th></tr>
                                </thead>
                                <tbody>
                                    <%rs = st.executeQuery("Select A.updated,A.id,A.quality,A.psize,A.rulling,A.quantity,B.type,C.type from reamquant as A,papersize as B,rulling as C where A.psize=B.id and A.rulling=C.id order by A.quality,B.type, C.type");
                                                        int g = 0;
                                                        int h = 0;
                                                        String t1, t2 = "";
                                                        java.util.Date d1 = new java.util.Date();
                                                        java.sql.Timestamp da1 = new java.sql.Timestamp(d1.getTime());
                                                        while (rs.next()) {
                                                            h++;
                                                            g++;
                                                            ResultSet x = st1.executeQuery("SELECT DATEDIFF(now(),'" + rs.getDate("A.updated") + "')");
                                                            x.next();
                                                            Float f = Float.parseFloat(rs.getString("quantity"));
                                    %>

                                    <tr  <%if (f < 100) {%> title="Quantity Less Than 100 is Red."  class="even gradeX" <%} else {%> title="Quantity More Than 100 is Green."  class="even gradeA"<%}%>   >
                                        <td ><%=h%></td >
                                        <td ><%=rs.getString("quality")%><input type="hidden" id="<%=g%>s1" value="<%=rs.getString("quality")%>"><input type="hidden" id="<%=g%>s3" value="<%=rs.getString("psize")%>"> <input type="hidden" id="<%=g%>s4" value="<%=rs.getString("A.rulling")%>"></td>
                                        <td><%=rs.getString("B.type")%></td>
                                        <td><%=rs.getString("C.type")%></td>
                                        <td><%=f%></td>
                                        <td style=" padding-left:0px; <%if (x.getInt(1) < 1) {%> color:red;<%}%>"><%=rs.getString("A.updated") + "<br> " + x.getString(1) + " days ago."%></td>
                                        <td style=" float: right; vertical-align: top;  " ><a href="reamsearch.jsp?q1=<%=rs.getString("quality")%>&q3=<%=rs.getString("psize")%>&q4=<%=rs.getString("rulling")%>" id="example4" ><img width="20" src="images/proc.png"></a> <a href="editreamquant.jsp?q1=<%=rs.getString("quality")%>&q3=<%=rs.getString("psize")%>&q4=<%=rs.getString("rulling")%>" id="example4" ><img width="20" src="images/edit.png"></a> <a href="del.jsp?tab=reamquant&id=<%=rs.getString("A.id")%>" onclick="return ask()" id="del"><img width="20" src="images/del.png"></a></td>
                                    </tr>
                                    <%

                                                        }%>
                                </tbody>       </table>

                        </div>

                        <div id="fragment-4">
                            <fieldset>
                                <legend>Proposed:</legend>
                                <table>
                                    <tr><td id="side"></td></tr>
                                    <tr><td>
                                            <table id="asform" >
                                                <tr><td colspan="2" >Proposed Contractor</td>



                                                    <%rs = st.executeQuery("Select * from contractor where sta='a' and area='binding' ");%>

                                                    <td><select class="chzn-select" id="se2" onchange="proposedsearch()" ><option value="default" selected >Select</option>
                                                            <%while (rs.next()) {%>

                                                            <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select></td></tr>
                                            </table>  </td>

                                    </tr>

                                    <tr ><td colspan="2" id="res2">
                                        </td></tr>
                                </table>
                            </fieldset>
                        </div>
                        <div id="fragment-6">


                            <form action="dispatchmat.jsp">
                                <table>
                                    <%rs = st.executeQuery("Select * from contractor where sta='a' and area='binding'");%>
                                    <tr> <td align="right">Contractor</td><td><select name="contr" class="chzn-select" >
                                                <%while (rs.next()) {%>
                                                <option value="<%=rs.getInt(1)%>">
                                                    <%=rs.getString(2) + " | :" + rs.getString(4)%>
                                                </option>
                                                <%}%>
                                            </select></td> </tr>

                                    <%rs = st.executeQuery("Select * from bindmat where sta='a' order by id");%>
                                    <tr> <td align="right">Type</td><td><select name="bindmat" class="chzn-select" >
                                                <%while (rs.next()) {%>
                                                <option value="<%=rs.getInt(1)%>">
                                                    <%=rs.getString(2) + " | Available:" + rs.getString(4)%>
                                                </option>
                                                <%}%>
                                            </select></td> </tr>
                                    <tr>
                                        <td>Quantity</td><td> <input type="text" size="5" name="matq"> <input type="submit" value="Dispatch" id="but" ></td>
                                    </tr>

                                </table>
                            </form>
                        </div>
                    </div>
                    <%} else if (q.equals("db")) {
                    %>
                    <h2 id="cmd">Database</h2>
                    <div id="tabs">
                        <ul>
                            <li><a href="#fragment-1"><span>Quality</span></a></li>
                            <li><a href="#fragment-2"><span>Rulling</span></a></li>
                            <li><a href="#fragment-3"><span>Size</span></a></li>
                            <li><a href="#fragment-4"><span>Papersize</span></a></li>
                            <li><a href="#fragment-5"><span>Notebook</span></a></li>
                            <li><a href="#fragment-6"><span>Cover</span></a></li>
                            <li><a href="#fragment-7"><span>Contractor</span></a></li>
                            <li><a href="#fragment-8"><span>Party</span></a></li>
                            <li><a href="#fragment-9"><span>User</span></a></li>
                            <li><a href="#fragment-10"><span>Binding Quality</span></a></li>
                            <li><a href="#fragment-11"><span>Binding Material</span></a></li>

                        </ul>
                        <div id="fragment-1"><%//Reel%>
                            <table width="100%" align="center" >
                                <tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insert.jsp?tab=quality" onsubmit="return valuate(this)" method="post">
                                            <table align="left" id="asform">
                                                <tr><td>Quality Name: </td>
                                                    <td> <input type="text" name="val" size="15" > </td></tr>
                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but" value="Add Quality"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>

                                    <td width="50%" align="left" >
                                        <%rs = st.executeQuery("Select * from quality where sta='a' order by id");
                                            int i = 0;%>
                                        <table align="left"  id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Quality</th><th colspan="2" >Action</th></tr>

                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td  ><%=i%></td><td><%=rs.getString("quality")%></td><td><a onclick="return ask()" id="del" href="del.jsp?tab=quality&id=<%=rs.getInt("id")%>">Delete</a></td><td><a id="example2" href="edit.jsp?tab=quality&id=<%=rs.getInt("id")%>">Edit</td></tr>
                                            <%}%>
                                        </table></td>
                                </tr></table>

                        </div>
                        <div id="fragment-2">
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insert.jsp?tab=rulling" onsubmit="return valuate(this)" method="post">
                                            <table id="asform">
                                                <tr><td>Rulling Type: </td>
                                                    <td> <input type="text" name="val" size="15" > </td></tr>
                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but"  value="Add"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>

                                    <td width="50%" align="left" >
                                        <%rs = st.executeQuery("Select * from rulling where sta='a' order by id");%>
                                        <table id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Type</th><th colspan="2" >Action</th></tr>

                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td><%=i%></td><td><%=rs.getString(2)%></td><td><a onclick="return ask()" id="del" href="del.jsp?tab=rulling&id=<%=rs.getInt("id")%>">Delete</a></td><td><a id="example2" href="edit.jsp?tab=rulling&id=<%=rs.getInt("id")%>">Edit</td></tr>
                                            <%}%>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div id="fragment-3">
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insert.jsp?tab=size" onsubmit="return valuate(this)" method="post">
                                            <table id="asform">
                                                <tr><td>Reel Size: </td>
                                                    <td> <input type="text" name="val" size="15" > </td></tr>
                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but"  value="Add"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>

                                    <td align="left" width="50%" valign="top" >
                                        <%rs = st.executeQuery("Select * from size where sta='a' order by id");%>
                                        <table id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Reel Size</th><th colspan="2" >Action</th></tr>
                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td><%=i%></td><td><%=rs.getString(2)%></td><td><a onclick="return ask()" id="del" href="del.jsp?tab=size&id=<%=rs.getInt("id")%>">Delete</a></td><td><a id="example2" href="edit.jsp?tab=size&id=<%=rs.getInt("id")%>">Edit</td></tr>
                                            <%}%>
                                        </table></td></tr></table>
                        </div>
                        <div id="fragment-4">
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insert.jsp?tab=papersize" onsubmit="return valuate(this)"  method="post">
                                            <table id="asform">
                                                <tr><td>Paper-Size: </td>
                                                    <td> <input type="text" name="val" size="15" > </td></tr>
                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but"  value="Add"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>

                                    <td align="left" width="50%" valign="top" >
                                        <%rs = st.executeQuery("Select * from papersize where sta='a' order by id");%>
                                        <table id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Paper-Size</th><th colspan="2" >Action</th></tr>
                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td><%=i%></td><td><%=rs.getString(2)%></td><td><a onclick="return ask()" id="del" href="del.jsp?tab=papersize&id=<%=rs.getInt("id")%>">Delete</a></td><td><a id="example2" href="edit.jsp?tab=papersize&id=<%=rs.getInt("id")%>">Edit</td></tr>
                                            <%}%>
                                        </table></td></tr></table>
                        </div>
                        <div id="fragment-5">
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insert.jsp?tab=notebook" onsubmit="return valuatenotebook(this)"  method="post">
                                            <table id="asform">
                                                <tr><td>Cover: </td>
                                                    <%rs = st.executeQuery("Select * from covtype where sta='a' order by id");%>
                                                    <td> <Select name="name" class="chzn-select"><%while (rs.next()) {%><option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option><%}%></select> </td></tr>
                                                <tr><td>Rulling:</td>
                                                    <%rs = st.executeQuery("Select * from rulling where sta='a' order by id");%>
                                                    <td> <Select name="pno" class="chzn-select"><%while (rs.next()) {%><option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option><%}%></select> </td></tr>
                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but"  value="Add"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>

                                    <td align="left" width="50%" valign="top" >
                                        <%rs = st.executeQuery("Select * from notebook where sta='a' order by id");%>
                                        <table id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Cover</th><th>Rulling</th><th colspan="2" >Action</th></tr>
                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <%ResultSet rs1 = st1.executeQuery("Select * from covtype where id=" + rs.getString(2));
                                                rs1.next();%>
                                            <%ResultSet rs2 = st2.executeQuery("Select * from rulling where id=" + rs.getString(3));
                                                rs2.next();%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td><%=i%></td><td><%=rs1.getString(2)%></td><td><%=rs2.getString(2)%></td><td><a id="del" onclick="return ask()" href="del.jsp?tab=notebook&id=<%=rs.getInt("id")%>">Delete</a></td><td><a id="example2" href="edit.jsp?tab=notebook&id=<%=rs.getInt("id")%>">Edit</td></tr>
                                            <%}%>
                                        </table></td></tr></table>
                        </div>
                        <div id="fragment-6">
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insert.jsp?tab=covtype" onsubmit="return valuate(this)"  method="post">
                                            <table id="asform">
                                                <tr><td>Name: </td>
                                                    <td> <input type="text" name="val" size="15" > </td></tr>

                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but"  value="Add"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>

                                    <td align="left" width="50%" valign="top" >
                                        <%rs = st.executeQuery("Select * from covtype where sta='a' order by id");%>


                                        <table id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Name</th><th colspan="2" >Action</th></tr>
                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td><%=i%></td><td><%=rs.getString(2)%></td><td><a id="del" onclick="return ask()" href="del.jsp?tab=covtype&id=<%=rs.getInt("id")%>">Delete</a></td><td><a id="example2" href="edit.jsp?tab=covtype&id=<%=rs.getInt("id")%>">Edit</a></td></tr>
                                            <%}%>
                                        </table></td></tr></table>
                        </div>
                        <div id="fragment-7">
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insert.jsp?tab=contractor" onsubmit="return valuatecontractor(this)"  method="post">
                                            <table id="asform">
                                                <tr><td>Name: </td>
                                                    <td> <input type="text" name="name" size="15" > </td></tr>
                                                <tr><td>Rate: </td>
                                                    <td> <input type="text" name="rate" size="15" > </td></tr>
                                                <tr><td>Dept: </td>
                                                    <td> <select class="chzn-select" name="area"><option value="rulling">Rulling</option><option value="binding">Binding</option> </select> </td></tr>
                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but"  value="Add"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>

                                    <td align="left" width="50%" valign="top" >
                                        <%rs = st.executeQuery("Select * from contractor where sta='a' order by id");%>
                                        <table id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Name</th><th>Rate</th><th>Dept</th><th colspan="2" >Action</th></tr>
                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td><%=i%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getString(4)%></td><td><a id="del" onclick="return ask()" href="del.jsp?tab=contractor&id=<%=rs.getInt("id")%>" >Delete </a> </td><td> <a id="example2"  href="edit.jsp?tab=contractor&id=<%=rs.getInt("id")%>">Edit</a></td></tr>
                                            <%}%>
                                        </table></td></tr></table>
                        </div>
                        <div id="fragment-8">
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insertparty.jsp" onsubmit="return valuatenotebook(this)"  method="post">
                                            <table id="asform">
                                                <tr><td>Name: </td>

                                                    <td> <input type="text" size="10" name="name"> </td></tr>
                                                <tr><td>Address:</td>

                                                    <td><input type="text" size="10" name="addr">  </td></tr>
                                                <tr><td>Tin:</td>

                                                    <td><input type="text" size="10" name="tin">  </td></tr>
                                                <tr><td>Phone No:</td>

                                                    <td><input type="text" size="10" name="pno">  </td></tr>
                                                <tr><td>Transport:</td>

                                                    <td><input type="text" size="10" name="trans">  </td></tr>
                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but"  value="Add"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>
                                </tr><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <%rs = st.executeQuery("Select * from party LEFT JOIN party_hindi on id=pid where sta='a' order by addr,id");%>
                                        <table id="viewtab" >
                                        	<thead>
			                                <tr id="asform" ><th>Sno</th><th colspan="2">Name</th><th colspan="2">Address</th><th>Tin</th><th>Phone</th><th>Transport</th><th colspan="3" >Action</th></tr>
                                             </thead>
                                             <tbody>
                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;
                                                    String hindi_name ="";
                                                    String hindi_addr = "";
                                                    if(null!=rs.getString("name_hindi")){
                                                    	 hindi_name = rs.getString("name_hindi");
                                                    }
                                                    if(null!=rs.getString("address_hindi")){
                                                    	 hindi_addr = rs.getString("address_hindi"); 
                                                    }
                                                    %>
                                                    

                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td><%=i%></td><td><%=rs.getString(2)%></td><td><%=hindi_name%></td><td><%=rs.getString(3)%></td><td><%=hindi_addr%></td><td><%=rs.getString(4)%></td><td><%=rs.getString(5)%></td><td><%=rs.getString(6)%></td><td><a id="del" onclick="return ask()" href="del.jsp?tab=party&id=<%=rs.getInt("id")%>">Delete</a></td><td><a id="example5" href="editparty.jsp?tab=party&id=<%=rs.getInt("id")%>">Edit</td><td><a id="example5" href="editPartyHindi.jsp?tab=party&id=<%=rs.getInt("id")%>">Add Hindi</a></td></tr>
                                            <%}%>
                                            </tbody>
                                        </table></td></tr></table>
                        </div>
                        <div id="fragment-9">
                            <%rs = st.executeQuery("Select * from user order by id");
                                                rs.next();%>
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >

                                    </td>

                                    <td align="left" width="50%" valign="top" >
                                        <%rs = st.executeQuery("Select * from user order by id");%>
                                        <table id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Username</th><th>Password</th><th colspan="2" >Action</th></tr>
                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td id="j<%=i%>" ><%=rs.getInt("id")%></td><td id="u<%=rs.getInt("id")%>"><%=rs.getString(2)%></td><td id="p<%=rs.getInt("id")%>"><%=rs.getString(3)%></td><td><%if (rs.getInt("id") != 0) {%><a onclick="return ask()" href="del.jsp?tab=user&id=<%=rs.getInt("id")%>">Delete</a> | <a id="example2"  href="edit.jsp?tab=user&id=<%=rs.getInt("id")%>">Edit</a><%}%></td></tr>
                                            <%}%>
                                        </table></td></tr></table>
                        </div>
                        <div id="fragment-10">
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insert.jsp?tab=bindqual" onsubmit="return valuatecontractor(this)"  method="post">
                                            <table id="asform">
                                                <tr><td>Name: </td>
                                                    <td> <input type="text" name="name" size="15" > </td></tr>
                                                <tr><td>Rate: </td>
                                                    <td> <input type="text" name="rate" size="15" > </td></tr>
                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but"  value="Add"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>

                                    <td align="left" width="50%" valign="top" >
                                        <%rs = st.executeQuery("Select * from bindqual where sta='a' order by id");%>
                                        <table id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Name</th><th>Rate</th><th colspan="2" >Action</th></tr>
                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td><%=i%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><a id="del" onclick="return ask()" href="del.jsp?tab=bindqual&id=<%=rs.getInt("id")%>" >Delete </a> </td><td> <a id="example2"  href="edit.jsp?tab=bindqual&id=<%=rs.getInt("id")%>">Edit</a></td></tr>
                                            <%}%>
                                        </table></td></tr></table>

                        </div>
                        <div id="fragment-11">
                            <table width="100%" ><tr>
                                    <td align="left" width="50%" valign="top" >
                                        <form action="insert.jsp?tab=bindmat" onsubmit="return valuatecontractor(this)"  method="post">
                                            <table id="asform">
                                                <tr><td>Name: </td>
                                                    <td> <input type="text" name="name" size="15" > </td></tr>
                                                <tr><td>Unit Price: </td>
                                                    <td> <input type="text" name="rate" size="15" > </td></tr>
                                                <tr align="right" >
                                                    <td colspan="2" > <input type="submit" id="but"  value="Add"> </td>
                                                </tr>
                                            </table>
                                        </form>
                                    </td>

                                    <td align="left" width="50%" valign="top" >
                                        <%rs = st.executeQuery("Select * from bindmat where sta='a' order by id");%>
                                        <table id="viewtab" >
                                            <tr id="asform" ><th>Sno</th><th>Name</th><th>Unit Price</th><th colspan="2" >Action</th></tr>
                                            <%i = 0;
                                                while (rs.next()) {
                                                    i++;%>
                                            <tr <%if (i % 2 == 1) {%>id="odd"<%} else {%>id="even"<%}%> ><td><%=i%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><a id="del" onclick="return ask()" href="del.jsp?tab=bindmat&id=<%=rs.getInt("id")%>" >Delete </a> </td><td> <a id="example2"  href="edit.jsp?tab=bindmat&id=<%=rs.getInt("id")%>">Edit</a></td></tr>
                                            <%}%>
                                        </table></td></tr></table>

                        </div>

                    </div>
                    <%} else if (q.equals("welcome")) {
                    %>
                    <h2 id="cmd">Welcome</h2>
                    <h2 id="cmdd" > <%="Logged in at :" + u.getTime().toString() + " | Session will expire in 120 minutes if left idle."%>
                    </h2>
                    <%DecimalFormat deFormat = new DecimalFormat("0.00");%>
                    <table id="asform" align="center" >

                        <tr><th colspan="2" ><h3 style="font-size: 2em; padding:0em; " >Statistics</h3></th></tr>
                        <tr><td colspan="2" >(As on <%java.util.Date d = new java.util.Date();%><%=d.toString()%>)</td></tr>
                        <tr><th>Raw Reels</th><%rs = st.executeQuery("Select count(*) from reel where status='raw'");
                                        rs.next();%><td align="right" ><%=rs.getInt(1)%></td></tr>
                        <tr><th>Rulled Reels</th><%rs = st.executeQuery("Select count(*) from reel where papertype='Reel' and status='rulled'");
                                        rs.next();%><td align="right"><%=rs.getInt(1)%></td></tr>
                        <tr><th>Raw Reams</th><%rs = st.executeQuery("Select sum(quantity) from reamquant");
                                        rs.next();%><td align="right"><%=deFormat.format(rs.getDouble(1))%></td></tr>

                        <tr><th>Main Product</th><%rs = st.executeQuery("Select sum(quantity) from bindquant");
                                        rs.next();%><td align="right"><%=rs.getLong(1)%></td></tr>

                    </table>
                    <%} else if (q.equals("Success")) {
                    %>
                    <h2 id="cmd">Query Executed Successfully</h2>
                    <table align="center" ><tr><td><a href="home.jsp?q=addStock">Continue</a></td></tr></table>
                    <%} else if (q.equals("contractor")) {%>

                    <h2 id="cmd">Contractor Management</h2>
                    <table align="center" style=" margin-left:1em; margin-bottom:1em;" id="asform">
                        <tr><th colspan="4" ><h4>Select Period</h4></th></tr>
<%
java.util.Date d=new java.util.Date();
String tod = new SimpleDateFormat("yyyy-MM-dd").format(d);
d.setDate(d.getDate() - 6);
String fromd = new SimpleDateFormat("yyyy-MM-dd").format(d);
%>
                        <tr><td>From</td><td><input onclick='scwShow(this,event);' class="text" id="frm" name="frm" value='<%=fromd%>' /></td><td>To</td><td><input onclick='scwShow(this,event);' class="text" name="to" id="to" value='<%=tod%>' /></td></tr>

                    </table>
                    <div id="tabs">
                        <ul>
                            <li><a href="#fragment-1"><span>Weekly Rulling Record</span></a></li>
                            <li><a href="#fragment-2"><span>Weekly Binding Record</span></a></li>

                        </ul>

                        <div id="fragment-1">
                            <table><tr><td>
                                        <table id="asform" >
                                            <tr><td colspan="3" >Select Contractor</td></tr>
                                            <%rs = st.executeQuery("Select * from contractor where sta='a' and area='rulling' order by name");%>
                                            <tr><td>Contractor</td><td><select class="chzn-select" id="se2" name="quality"><%while (rs.next()) {%><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select></td><td><input type="button" id="but" onclick="texthint4('ream')" value='Search'> </td></tr>
                                        </table></td>
                                </tr>

                                <tr ><td colspan="2" id="res2">
                                    </td></tr>
                            </table>

                        </div>
                        <div id="fragment-2"><%//Reel%>

                            <table><tr><td>
                                        <table id="asform" >
                                            <tr><td colspan="3" >Select Contractor</td></tr>
                                            <%rs = st.executeQuery("Select * from contractor where sta='a' and area='binding' order by name");%>
                                            <tr><td>Contractor</td><td><select class="chzn-select" id="se3" name="quality"><%while (rs.next()) {%><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%}%></select></td><td><input type="button" id="but" onclick="texthint4('bind')" value='Search'> </td></tr>
                                        </table></td>

                                </tr>

                                <tr ><td colspan="2" id="res3">
                                    </td></tr>
                            </table>

                        </div>
                    </div>
                    <%} else if (q.equals("order")) {%>
                    <h2 id="cmd">Orders</h2>
                    <table align="left" width="100%" id="asform" >
                        <tr>
                            <th style=" padding: 10px;  " align="left" colspan="3">Pending Orders</th>
                            <th colspan="2">Total Order</th>
                            <td style=" padding: 10px;  " align="center" colspan="2" valign="middle "><form action="order2.jsp?serv=saveorder" target="_blank" method="post" >
                                    <%rs = st.executeQuery("Select * from party where sta='a' order by name");%>
                                    <select class="chzn-select" id="party" name="party" style=" width: 25em; " ><%while (rs.next()) {%><option value="<%=rs.getString(1)%>"><%=rs.getString(2) + " " + rs.getString(3)%></option><%}%></select>
                                    <input type="hidden" name="oid" value="0">
                                    <input type="submit" id="but"  value="New Order"/>
                                </form></td>
                        </tr>
                        <tr>
                            <th>Id</th><th>Party</th><th>Items</th><th>B</th><th>L</th><th>Order Date</th><th>Action</th>
                        </tr>
                        <%
                                            rs = st.executeQuery("select a.id,a.odate,b.name,b.addr,`a`.party from `order` `a`, party b where status='p' and `a`.`party`=b.id");
                                            ResultSet rs1 = null;
                                            int i = 0;
                                            while (rs.next()) {
                                                i++;
                                                rs1 = st1.executeQuery("Select count(item_id),sum(b_order),sum(l_order) from order_vs_avl where order_id='" + rs.getInt("a.id") + "' group by order_id");
                                                rs1.next();
                                                if (i % 2 == 0) {
                                                    out.println("<tr id=odd1>");
                                                } else {
                                                    out.println("<tr id=even1>");
                                                }
                        %>
                        <td><%=rs.getInt("a.id")%></td><td><%=rs.getString("b.name") + ", " + rs.getString("b.addr")%></td><td align="right" ><%=rs1.getInt(1)%></td><td align="right" ><%=rs1.getInt(2)%></td><td align="right" ><%=rs1.getInt(3)%></td><td align="center" ><%=rs.getString("a.odate")%></td><td align="center" ><a target="_blank" href="dispatchorder1.jsp?oid=<%=rs.getString("a.id")%>&pid=<%=rs.getString("a.party")%>">Load</a></td></tr>
                        <%
                                            }
                        %>

                    </table>



                    <%} else if (q.equals("print")) {%>
                    <h2 id="cmd">Print Receipt</h2>
                    <form>
                        <table><tr><td>
                                    <table id="asform">
                                        <tr>
                                            <td>Select Date</td>
                                            <td><input id="dat" onclick='scwShow(this,event);' class="text" type="text"></td>
                                        </tr>
                                        <tr><td colspan="2" align="right"><input type="button" onclick="fetchreceipt('dat')" value="Search" id="but" ></td></tr>
                                    </table></td><td>
                                    <table id="asform">
                                        <tr>
                                            <td>Dispatch/Receipt No.</td>
                                            <td><input id="id" type="text"></td>
                                        </tr>
                                        <tr><td colspan="2" align="right"><input type="button" onclick="fetchreceipt('id')" value="Search" id="but" ></td></tr>
                                    </table>
                                </td>
                                <td>
                                    <table id="asform">
                                        <tr>
                                            <td>Party</td>
                                            <td>
                                                <%rs = st.executeQuery("Select * from party where sta='a' order by name");%>
                                                <select class="chzn-select" id="party" style=" width: 25em; " ><%while (rs.next()) {%><option value="<%=rs.getString(1)%>"><%=rs.getString(2) + " " + rs.getString(3)%></option><%}%></select>
                                            </td>
                                        </tr>
                                        <tr><td colspan="2" align="right">

                                                <input type="button" onclick="fetchreceipt('party')" value="Search" id="but" ></td></tr>
                                    </table>
                                </td>
                            </tr></table>
                        <hr>
                        <div id="receipt"></div>
                        <div id="receiptmsg"></div>
                    </form>
                    <%} else if (q.equals("history")) {%>
                    <h2 id="cmd">History</h2>
                    <div id="tabs">
                        <ul>
                            <li><a href="#fragment-1"><span>Delete History</span></a></li>
                        </ul>
                        <div id="fragment-1">
                            <form action="delhistory.jsp" onsubmit="return checkdelform()" name="frm" method="post">
                                <fieldset>
                                    <legend>History:</legend>

                                    <table id="" >
                                        <tr><td>Before</td><td><input onclick='scwShow(this,event);' class="text" id="bfr" name="bfr" value='' /> </td></tr>
                                        <tr><td><input type="checkbox" name="tab" value="ream" /></td><td>Rulling Data</td></tr>
                                        <tr><td><input type="checkbox" name="tab" value="bind" /></td><td>Binding Data</td></tr>
                                        <tr><td><input type="checkbox" name="tab" value="transact" /></td><td>Sales Data</td></tr>
                                        <tr><td colspan="2" align="right"> <input type="submit" value="Delete" id="but" > </td></tr>
                                    </table>
                                </fieldset>
                            </form>
                        </div>


                    </div>

                    <%}%>
                    <%} catch (Exception ex) {
                        out.println(ex);
                    } finally{
                    	try
                        {                          
                          cn.close();
                        }
                        catch (Exception e)
                        {
                        	e.printStackTrace();
                        }
                    }%>
                    <script src="chosen/chosen.jquery.js" type="text/javascript"></script>
                    <script type="text/javascript">
     
                        $(".chzn-select").chosen();
    
                        $(".chzn-select-deselect").chosen({allow_single_deselect:true});
    
                    </script>
                </div>

            </div>
            <div id="pied">
                <jsp:include page="footer.html"></jsp:include>

            </div>

        </div>
        <%} else {
                        response.sendRedirect("index.jsp");
                    }%>
        </div>
    </body>
</html>