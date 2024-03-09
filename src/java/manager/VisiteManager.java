package manager;

import bean.Medecin;
import bean.Patient;
import bean.Visite;
import bean.VisiteId;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author axm
 */
public class VisiteManager {
    public List<Visite> getAllData() {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Visite> visite = new ArrayList<>();

        try {
            tx = session.beginTransaction();

            // Use HQL to get all visite using hes class not the table
            Query query = session.createQuery("FROM Visite");
            visite = query.list();

            // Commit the transaction
            tx.commit();

            System.out.println("Nombre de visites récupérés : " + visite.size());
            return visite;
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
        return visite;
    }
    
    public Medecin getMedDetails(String code_medecin){
        MedecinManager mm = new MedecinManager();
        Medecin e = mm.getMedecinByCode(code_medecin);    
        return e;
    }
    
    public Patient getPatientDetails(String codePatient){
        PatientManager em = new PatientManager();
        Patient p = em.getPatientByCode(codePatient);    
        return p;
    }

    public void addVisite(VisiteId id, Date date, Medecin medecin, Patient patient) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction = session.beginTransaction();

        Visite visite = new Visite();
            visite.setId(id);
            visite.setDate(date);
            visite.setMedecin(medecin);
            visite.setPatient(patient);

        session.save(visite);

        transaction.commit();
    }
    public void deleteVisite(String codeMed, String codePat) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction transaction = session.beginTransaction();
        VisiteId id = new VisiteId(codeMed, codePat);

        Visite visite = (Visite) session.get(Visite.class, id);

        session.delete(visite);

        transaction.commit();
    }

    public List<Visite> searchVisite(String searchValue) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Visite> visite = new ArrayList<>();

        try {
            tx = session.beginTransaction();

            // Utilize HQL to search for visits by date, doctor's name, or patient's name
            Query<Visite> query = session.createQuery("FROM Visite v WHERE v.date = :searchDate OR v.medecin.nom LIKE :searchNomMedecin OR v.patient.nom LIKE :searchNomPatient", Visite.class);

            // Convert the search string to a Date if it's a valid date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date searchDate = null;
            try {
                searchDate = dateFormat.parse(searchValue);
            } catch (ParseException e) {
                // Ignore the exception if the string is not a valid date
            }

            // Parameters for the query
            if (searchDate != null) {
                query.setParameter("searchDate", searchDate);
            }
            query.setParameter("searchNomMedecin", "%" + searchValue + "%");
            query.setParameter("searchNomPatient", "%" + searchValue + "%");

            visite = query.getResultList();

            // Commit the transaction
            tx.commit();

            System.out.println("Nombre de visites récupérés : " + visite.size());
            return visite;
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
        return visite;
    }

}
