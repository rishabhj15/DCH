/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package session;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author Rishabh
 */
public class Cart_1 implements Serializable{
    private ArrayList list=new ArrayList();
    private String party;
    public Cart_1(Item_1 i,String p){
        list.add(i);
        party=p;
    }
    public void add(Item_1 i){
        int x=0;
        for(;x<list.size();x++){
            Item_1 j = (Item_1) list.get(x);
            if(j.pro.equals(i.pro)){
                i.q=i.q+j.q;
                list.remove(x);
                break;
            }
        }
        list.add(x, i);
        //list.add(i);
    }
    
    public void update(Item_1 i){
        int x=0;
        for(;x<list.size();x++){
            Item_1 j = (Item_1) list.get(x);
            if(j.pro.equals(i.pro)){
                list.remove(x);
                break;
            }
        }
        list.add(x, i);
        //list.add(i);
    }
public ArrayList get(){
return list;
}
public void remove(){
list.removeAll(list);
}
public void remove(int i){
list.remove(i);
}
public String getParty(){
return party;
}
public void updateParty(String p){
party=p;
}
}
