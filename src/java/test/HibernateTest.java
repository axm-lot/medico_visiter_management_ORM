/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author axm
 */

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateTest {
    public static void main(String[] args) {
        // Configuration de Hibernate à partir du fichier de configuration
        Configuration configuration = new Configuration().configure("hibernate.cfg.xml");
        // Création de la session factory
        SessionFactory sessionFactory = configuration.buildSessionFactory();
        
        Session session = sessionFactory.openSession();
        // Ouverture d'une nouvelle session Hibernate
        try {
            // Test de la connexion en effectuant une requête simple
                session.beginTransaction();
                session.createQuery("SELECT 1").uniqueResult();
                session.getTransaction().commit();
                System.out.println("Connexion à la base de données réussie !");
            
        } catch (Exception e) {
            System.err.println("Erreur de connexion à la base de données : " + e.getMessage());
        } finally {
            // Fermeture de la session factory à la fin
            sessionFactory.close();
        }
    }
}
