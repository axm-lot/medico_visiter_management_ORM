/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author axm
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestConnexion {
    public static void main(String... args){
        Connection conn = null;
        try{
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medico_visiter_management","root","*****");
            System.out.println("Connected as successfully ... !");
        } catch(SQLException e){
            e.printStackTrace();
        } finally{
            try{
                if(conn!=null){
                    conn.close();
                }
            }catch(SQLException e){
                e.printStackTrace();  
            }
        }
    }
}
