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
    //public String con1="jdbc:mysql://localhost/rishabhjain189?user=rishabhjain189&password=quality321";
    public String con="jdbc:mysql://localhost/ibra19_dch1?useUnicode=true&characterEncoding=UTF-8&user=ibra19_permisml&password=permisml123";
    //public String con="jdbc:mysql://localhost/ibra19_dch1?useUnicode=true&characterEncoding=UTF-8&user=root&password=root";
    //public String con="jdbc:mysql://127.5.80.1:3306/dch?useUnicode=true&characterEncoding=UTF-8&user=rishabhjain15&password=quality321";
	

    public String getURL() throws IOException{
return con;
}

    

    public static void main(String arg[]) throws IOException{
    Conf c=new Conf();
    System.out.print(c.getURL());
    }
    
}
