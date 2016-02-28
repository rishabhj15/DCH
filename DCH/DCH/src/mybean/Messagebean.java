/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package mybean;

import java.sql.*;

/**
 *
 * @author Rishabh
 */
public class Messagebean {
    Messagebean(){}

    public String show(String command,int id){
        String resp="<table>";
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            ResultSet rs = st.executeQuery("Select * from message");
        if(command.equals("inbox")){
        while(rs.next()){
        resp=resp;//+"<tr><td>"+rs.getString("from")+"</td><td>"+rs.getString("subject")+"</td><td>"+rs.getString("content").substring(0, 10)+"</td></tr></table>";
                            }
        }          }catch(Exception ex){

          }
        return resp;
    }

}
