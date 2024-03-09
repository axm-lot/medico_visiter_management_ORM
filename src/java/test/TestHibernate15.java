/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author axm
 */
import bean.Patient;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class TestHibernate15 {

    public static void main(String args[]) {
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Transaction transaction = null;
        Session session = sessionFactory.openSession();
        try {
            transaction = session.beginTransaction();
            Patient patient = new Patient("pat1" , "axm","lot","M","Fianara" );
            session.save(patient);
            transaction.commit();
            System.out.println("Le nouveau patient a ete enregistre");
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        sessionFactory.close();
    }
}
