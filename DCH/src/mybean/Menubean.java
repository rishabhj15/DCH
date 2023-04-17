package mybean;

import java.sql.*;

public  class Menubean

{

  public Menubean()   {  }
  public String  showMenu(String s,String k){
      String menu=null;
      Connection cn = null;
      try{
    	  Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
      if(s.equals("readmore")){
  menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../labbook/labbook.jsp'>Back</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../labbook/edit.jsp?key="+k+"'>Edit Task</a></td> </tr>"
          + "</table>";
      }else if (s.equals("addnewlit")) {
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/lit.jsp?key="+k+"'>Cancel</a></td> </tr>"
          + "</table>";
  }else if (s.equals("addnewtechn")) {
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/techn.jsp?key="+k+"'>Cancel</a></td> </tr>"
          + "</table>";
  }else if (s.equals("addnewres")) {
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/res.jsp?key="+k+"'>Cancel</a></td> </tr>"
          + "</table>";
  }else if (s.equals("addnewred")) {
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/red.jsp?key="+k+"'>Cancel</a></td> </tr>"
          + "</table>";
  }else if(s.equals("lit")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/addnewlit.jsp?key="+k+"'>Add New Document</a></td>"
          + "</table>";
  }else if(s.equals("res")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/addnewres.jsp?key="+k+"'>Add New Result</a></td>"
          + "</table>";
  }else if(s.equals("red")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/addnewred.jsp?key="+k+"'>Add New Writing</a></td>"
          + "</table>";
  }else if(s.equals("techn")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/addnewtechn.jsp?key="+k+"'>Add New Technique</a></td>"
          + "</table>";
  }else if(s.equals("viewequipment")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/equipment.jsp'>Back</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/addequipment.jsp?type="+k+"'>Add New Equipment</a></td>"
          + "</table>";
  }else if(s.equals("addnewequip")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/viewequipment.jsp?type="+k+"'>Cancel</a></td> </tr>"
          + "</table>";
          menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/equipment.jsp'>Cancel</a></td> </tr>"
          + "</table>";
  }else if (s.equals("litnav")) {
      try {
                            ResultSet rs = st.executeQuery("Select name from project where id="+k);
                            rs.next();
                            menu="<table align='left'>"
          + "<tr><td><a id='nav' href='project.jsp'>Project</a><td> >></td><td><a id='nav' href='../project/detail.jsp?key="+k+"'>"+rs.getString("name")+" </a>>> Literature</td> </tr>"
          + "</table>";
          }catch(Exception ex){

          }

  }else if (s.equals("technav")) {
      try {
           
                            ResultSet rs = st.executeQuery("Select name from project where id="+k);
                            rs.next();
                            menu="<table align='left'>"
          + "<tr><td><a id='nav' href='project.jsp'>Project</a><td> >></td><td><a id='nav' href='../project/detail.jsp?key="+k+"'>"+rs.getString("name")+" </a>>> Technique</td> </tr>"
          + "</table>";
          }catch(Exception ex){

          }

  }else if (s.equals("resnav")) {
      try {
                            ResultSet rs = st.executeQuery("Select name from project where id="+k);
                            rs.next();
                            menu="<table align='left'>"
          + "<tr><td><a id='nav' href='project.jsp'>Project</a><td> >></td><td><a id='nav' href='../project/detail.jsp?key="+k+"'>"+rs.getString("name")+" </a>>> Result</td> </tr>"
          + "</table>";
          }catch(Exception ex){

          }

  }else if (s.equals("rednav")) {
      try {
                            ResultSet rs = st.executeQuery("Select name from project where id="+k);
                            rs.next();
                            menu="<table align='left'>"
          + "<tr><td><a id='nav' href='project.jsp'>Project</a><td> >></td><td><a id='nav' href='../project/detail.jsp?key="+k+"'>"+rs.getString("name")+" </a>>> Writings</td> </tr>"
          + "</table>";
          }catch(Exception ex){

          }

  }else if (s.equals("newlitnav")) {
      try {
                            ResultSet rs = st.executeQuery("Select name from project where id="+k);
                            rs.next();
                            menu="<table align='left'>"
          + "<tr><td><a id='nav' href='../project/detail.jsp?key="+k+"'>"+rs.getString("name")+" </a>>> <a id='nav' href='../project/lit.jsp?key="+k+"'>Literature</a> >> Add New Doc</td> </tr>"
          + "</table>";
          }catch(Exception ex){

          }

  }else if (s.equals("newtechnav")) {
      try {
                            ResultSet rs = st.executeQuery("Select name from project where id="+k);
                            rs.next();
                            menu="<table align='left'>"
          + "<tr><td><a id='nav' href='../project/detail.jsp?key="+k+"'>"+rs.getString("name")+" </a>>> <a id='nav' href='../project/techn.jsp?key="+k+"'>Technique</a> >> Add New Technique</td> </tr>"
          + "</table>";
          }catch(Exception ex){

          }

  }else if (s.equals("newresnav")) {
      try {
                            ResultSet rs = st.executeQuery("Select name from project where id="+k);
                            rs.next();
                            menu="<table align='left'>"
          + "<tr><td><a id='nav' href='../project/detail.jsp?key="+k+"'>"+rs.getString("name")+" </a>>> <a id='nav' href='../project/res.jsp?key="+k+"'>Result</a> >> Add New Result</td> </tr>"
          + "</table>";
          }catch(Exception ex){

          }

  }else if (s.equals("newrednav")) {
      try {
                            ResultSet rs = st.executeQuery("Select name from project where id="+k);
                            rs.next();
                            menu="<table align='left'>"
          + "<tr><td><a id='nav' href='../project/detail.jsp?key="+k+"'>"+rs.getString("name")+" </a>>> <a id='nav' href='../project/red.jsp?key="+k+"'>Writing</a> >> Add New Writing</td> </tr>"
          + "</table>";
          }catch(Exception ex){

          }

  }else if (s.equals("detail")) {
      try {
                            ResultSet rs = st.executeQuery("Select name from project where id="+k);
                            rs.next();
                            menu="<table align='left'><tr><td><a id='nav' href='project.jsp'>Project</a><td> >></td><td id='subnav' >"+rs.getString("name")+"</td> </tr></table>";
          }catch(Exception ex){

          }

  }
      }catch(Exception ex){
    	  ex.printStackTrace();
      }finally {
    	  try{
  			cn.close();
  		}catch(Exception ex){
  			ex.printStackTrace();
  		}
      }
      return menu;
  }
  public String  showMenu(String s)
  {
      String menu = null;
  if(s.equals("labbook")){
  menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../labbook/addnew.jsp'>Add New Task</a></td> </tr>"
          + "</table>";
  }else if(s.equals("home")){
      menu="<table align='left'>"
          + "<td id='subnav' ><a id='leftnav' href='../user/editprofile.jsp'>Edit Profile</a></td>"
          + "</table>";
  }else if(s.equals("user")){
      menu="<table align='left'>"
          + "<td id='subnav'><a onclick=\"addnew()\" id='leftnav' href='#'>Add New User</a></td>"
          + "</table>";
  }else if(s.equals("forum")){
      menu="<table align='left'>"
          + "<td id='subnav'><a id='leftnav' href='#'>View Record</a></td>"
          + "</table>";
  }else if(s.equals("edituser")){
      menu="<table align='left'>"
          + "<td id='subnav'><a id='leftnav' href='main.jsp'>Cancel</a></td>"
          + "</table>";
  }else if(s.equals("edituserprofile")){
      menu="<table align='left'>"
          + "<td id='subnav'><a id='leftnav' href='../home.jsp'>Cancel</a></td>"
          + "</table>";
  }else if(s.equals("inbox")){
      menu="<table align='left'>"
          + "<td id='subnav'><a id='leftnav' href='compose.jsp'>Compose</a>"
          + "<td id='subnav' ><a id='leftnav' onclick=\"texthint('inbox')\" href='#'>Inbox</a></td>"
          + "<td id='subnav' ><a id='leftnav' onclick=\"texthint('outbox')\" href='#'>Outbox</a></td>"
          + "<td id='subnav' ><a id='leftnav' onclick=\"texthint('drafts')\" href='#'>Drafts</a></td>"
          + "<td id='subnav' ><a id='leftnav' onclick=\"texthint('trashed')\" href='#'>Trashed</a></td>"
          + "</table>";
  }else if(s.equals("compose")){
      menu="<table align='left'>"
          + "<td id='subnav'><a id='leftnav' href='inbox.jsp'>Cancel</a>"
          + "</table>";
  }else if(s.equals("edit")){
      menu="<table align='left'>"
          + "<td id='subnav' ><a id='leftnav' href='../labbook/labbook.jsp'>Cancel</a></td>"
          + "</table>";
  }else if(s.equals("project")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/addnew.jsp'>Add New Project</a></td>"
          + "</table>";
  }else if(s.equals("viewequipment")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/equipment.jsp'>Back</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/addequipment.jsp'>Add New Equipment</a></td>"
          + "</table>";
  }else if(s.equals("equipment")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/main.jsp'>Back</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/viewequipment.jsp?type=Reactif'>Reactifs</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/viewequipment.jsp?type=Glossware'>Glossware</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/viewequipment.jsp?type=Other'>Other</a></td>"
          + "</table>";
  }else if(s.equals("stock")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/main.jsp'>Back</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/addstock.jsp'>Add New Stock</a></td>"
          + "</table>";
  }else if(s.equals("supplier")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/main.jsp'>Back</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/addsupplier.jsp'>Add New Supplier</a></td>"
          + "</table>";
  }else if(s.equals("spending")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/main.jsp'>Back</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/addspending.jsp'>Add New Spending</a></td>"
          + "</table>";
  }else if(s.equals("management")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/equipment.jsp'>Equipments</a></td>"
          +"<td id='subnav' ><a id='leftnav' href='../management/stock.jsp'>Stocks</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/spending.jsp'>Spendings</a></td>"
          + "<td id='subnav' ><a id='leftnav' href='../management/supplier.jsp'>Suppliers</a></td>"
          + "</table>";
  }else if(s.equals("lit")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/addnewlit.jsp'>Add New Document</a></td>"
          + "</table>";
  }else if(s.equals("res")){
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/addnewlit.jsp'>Add New Result</a></td>"
          + "</table>";
  } else if (s.equals("addnew")) {
      menu="<table align='left'>"
          + "<tr><td id='subnav'><a id='leftnav' href='../labbook/labbook.jsp'>Cancel</a></td></tr>"
          + "</table>";
  }else if (s.equals("addnewproject")) {
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../project/project.jsp'>Cancel</a></td> </tr>"
          + "</table>";
  }else if (s.equals("addnewspending")) {
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/spending.jsp'>Cancel</a></td> </tr>"
          + "</table>";
  }else if (s.equals("addnewstock")) {
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/stock.jsp'>Cancel</a></td> </tr>"
          + "</table>";
  }else if (s.equals("addnewsupplier")) {
      menu="<table align='left'>"
          + "<tr><td id='subnav' ><a id='leftnav' href='../management/supplier.jsp'>Cancel</a></td> </tr>"
          + "</table>";
  }else{
  
  }
      return menu;

  }

}