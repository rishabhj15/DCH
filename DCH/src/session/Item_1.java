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
public class Item_1 {
    int q=0;
    String pro=null;
public Item_1(String p,int bun){
pro=p;
q=bun;
}
public Item_1(int p,int bun){
pro=p+"";
q=bun;
}
public String getProduct(){
return pro;
}
public int getQ(){
return q;
}

}
