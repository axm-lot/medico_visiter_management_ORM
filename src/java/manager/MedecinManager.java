/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package manager;

import bean.Medecin;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author axm
 */
public class MedecinManager {
    
    public void addMedecin(String codemed, String nom, String prenom, String grade) {

        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction = session.beginTransaction();

        Medecin e = new Medecin();

        e.setCodemed(codemed);
        e.setNom(nom);
        e.setPrenom(prenom);
        e.setGrade(grade);

        session.save(e);

        transaction.commit();

    }
    
    public void deleteMedecin(String codeMed) {

        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction = session.beginTransaction();

        Medecin e = (Medecin)session.get(Medecin.class, codeMed);

        session.delete(e);

        transaction.commit();

    }

    public Medecin getMedecinByCode(String codeMed) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Transaction transaction = session.beginTransaction();

            Medecin medecin = (Medecin)session.get(Medecin.class, codeMed);

            transaction.commit();

            return medecin;
        } catch (Exception e) {
            // Log the exception or print the stack trace for debugging
            e.printStackTrace();
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        return null; // Return null in case of an exception
    }

    public void editMedecin(String codemed, String nom, String prenom, String grade) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction = session.beginTransaction();

        System.out.println("Code Emp to Edit: " + codemed);

        // Retrieve the existing Medecin
        Medecin med = (Medecin) session.get(Medecin.class, codemed);

        if (med != null) {
            // Update Medecin information
            med.setNom(nom);
            med.setPrenom(prenom);
            med.setGrade(grade);

            // Save the updated Medecin
            session.saveOrUpdate(med);
            transaction.commit();
        } else {
            // Handle the case where the Medecin with the given code is not found
            System.out.println("Medecin with code " + codemed + " not found.");
            transaction.rollback();
        }
    }

    public List<Medecin> getMedecinByName(String name) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Medecin> medecinList = new ArrayList<>();
        System.out.println("ok");
        try {
            tx = session.beginTransaction();

            // Use HQL to get all medecins
            //Query query = session.createQuery("FROM Medecin WHERE nom LIKE '%"+name+"%' OR prenom LIKE '%"+name+"%'");
            Query query = session.createQuery("FROM Medecin WHERE nom LIKE :searchName OR prenom LIKE :searchName");
            query.setParameter("searchName", "%" + name + "%");
            
            medecinList = query.list();

            // Commit the transaction
            tx.commit();

            return medecinList;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace(); // Log or handle the exception appropriately
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        // Return an empty list in case of an exception
        return medecinList;
    }

    public List<Medecin> getAllData() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Medecin> medecin = new ArrayList<>();

        try {
            tx = session.beginTransaction();

            // Use HQL to get all medecin using hes class not the table
            Query query = session.createQuery("FROM Medecin");
            medecin = query.list();

            // Commit the transaction
            tx.commit();

            System.out.println("Nombre de patients récupérés : " + medecin.size());
            return medecin;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace(); // Log or handle the exception appropriately
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }

        // Return an empty list in case of an exception
        return medecin;
    }
}
