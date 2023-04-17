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
public class Cart implements Serializable{
    private ArrayList list=new ArrayList();
    public Cart(Item i){
    
        list.add(i);
    }
    public void add(Item i){

    list.add(i);
    }
public ArrayList get(){
return list;
}
public void remove(){
list.removeAll(list);

}

}
