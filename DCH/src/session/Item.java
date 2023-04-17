/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package session;

import java.util.List;

/**
 *
 * @author Rishabh
 */
public class Item {
    String se=null;
    String li=null;
    String nb=null;
    String b=null;
    String l=null;
    String size=null;
    String pro=null;
    int total=0;
    
    public Item() {
		// TODO Auto-generated constructor stub
	}
public Item(String s,String n,String i,String be,String le,String sz,int t,String p){
se=s;
li=i;
b=be;
l=le;
nb=n;
total=t;
size=sz;
pro=p;
}
public String getSE(){
return se;
}
public String getNB(){
return nb;
}
public String getB(){
return b;
}
public String getL(){
return l;
}
public String getLi(){
return li;
}
public int getTotal(){
return total;
}
public String getSize(){
return size;
}
public String getPro(){
return pro;
}
}
