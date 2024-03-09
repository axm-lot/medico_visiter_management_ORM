/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package manager;

import bean.Patient;
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
public class PatientManager {
        public void addPatient(String codepat, String nom, String prenom, String sexe, String adresse) {

        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction = session.beginTransaction();

        Patient patient = new Patient();

        patient.setCodepat(codepat);
        patient.setNom(nom);
        patient.setPrenom(prenom);
        patient.setSexe(sexe);
        patient.setAdresse(adresse);
        
        System.out.println("ok !");
        session.save(patient);

        transaction.commit();

    }
    
    public void deletePatient(String codeMed) {

        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction = session.beginTransaction();

        Patient e = (Patient)session.get(Patient.class, codeMed);

        session.delete(e);

        transaction.commit();

    }

    public Patient getPatientByCode(String codeMed) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Transaction transaction = session.beginTransaction();

            Patient patient = (Patient)session.get(Patient.class, codeMed);

            transaction.commit();

            return patient;
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

    public void editPatient(String codepat, String nom, String prenom, String sexe, String adresse) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction = session.beginTransaction();

        System.out.println("Code Pat to Edit: " + codepat);

        // Retrieve the existing Patient
        Patient pat = (Patient) session.get(Patient.class, codepat);

        if (pat != null) {
            // Update Patient information
            pat.setNom(nom);
            pat.setPrenom(prenom);
            pat.setSexe(sexe);
            pat.setAdresse(adresse);

            // Save the updated Patient
            session.saveOrUpdate(pat);
            transaction.commit();
        } else {
            // Handle the case where the Patient with the given code is not found
            System.out.println("Patient with code " + codepat + " not found.");
            transaction.rollback();
        }
    }

    public List<Patient> getPatientByName(String name) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Patient> patientList = new ArrayList<>();
        System.out.println("ok");
        try {
            tx = session.beginTransaction();

            // Use HQL to get all patients
            Query query = session.createQuery("FROM Patient WHERE nom LIKE :searchName OR prenom LIKE :searchName");
            query.setParameter("searchName", "%" + name + "%");
            
            patientList = query.list();

            // Commit the transaction
            tx.commit();

            return patientList;
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
        return patientList;
    }

    public List<Patient> getAllData() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Patient> patient = new ArrayList<>();

        try {
            tx = session.beginTransaction();

            // Use HQL to get all patient using hes class not the table
            Query query = session.createQuery("FROM Patient");
            patient = query.list();

            // Commit the transaction
            tx.commit();

            System.out.println("Nombre de patients récupérés : " + patient.size());
            return patient;
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
        return patient;
    }
}
