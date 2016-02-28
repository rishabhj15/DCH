/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package session;

/**
 *
 * @author Rishabh
 */
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class User implements Serializable{
    private String id,username;
    private Date time;
    private ArrayList list;
    public User(String idf,String un){
        username=un;
        id=idf;
        time=new Date();

    }
    public String getUser(){
        return username;
    }
    public String getUserId(){
        return id;
    }
    public Date getTime(){
        return time;
    }
public void addItem(String nb,String b,String l){
list.add(nb);
}
}

