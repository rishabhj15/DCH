/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Rishabh
 */
package mybean;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Conf{
    public String con="jdbc:mysql://localhost:3306/ibra19_dch1?useUnicode=true&characterEncoding=UTF-8&user=root&password=root";

    public String getURL() throws IOException{
return con;
}

    

    public static void main(String arg[]) throws IOException{
    Conf c=new Conf();
    System.out.print(c.getURL());
    }
    
}
