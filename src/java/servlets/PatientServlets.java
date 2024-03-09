/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlets;

/**
 *
 * @author axm
 */

import bean.Patient;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import manager.PatientManager;

@WebServlet(name = "PatientServlet", urlPatterns = {"/patient"})
public class PatientServlets extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String codeMed = request.getParameter("codeMed");
        String codePatToDelete = request.getParameter("codePatToDelete");
        String codePatToAdd = request.getParameter("codePatToAdd");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String sexe = request.getParameter("sexe");
        String adresse = request.getParameter("adresse");
        String codePatToEdit = request.getParameter("codePatToEdit");
        String newNom = request.getParameter("newNom");
        String newPrenom = request.getParameter("newPrenom");
        String newSexe = request.getParameter("newSexe");
        String newAdresse = request.getParameter("newAdresse");

        List<Patient> patient = new ArrayList<>();

        if(codePatToEdit != null && !codePatToEdit.isEmpty() && newNom != null && !newNom.isEmpty() && newPrenom != null && !newPrenom.isEmpty() && newSexe != null && !newSexe.isEmpty()  && newAdresse != null && !newAdresse.isEmpty() ){
            PatientManager pat = new PatientManager();
            pat.editPatient(codePatToEdit, newNom, newPrenom, newSexe, newAdresse);
            patient = pat.getAllData();
        }else if(codePatToAdd!=null && !codePatToAdd.isEmpty() && nom != null && !nom.isEmpty() && prenom != null && !prenom.isEmpty() && sexe != null && !sexe.isEmpty() && adresse != null && !adresse.isEmpty()){
            PatientManager pat = new PatientManager();
            pat.addPatient(codePatToAdd, nom, prenom, sexe, adresse);
            patient = pat.getAllData();
        }else if (codeMed != null && !codeMed.isEmpty()) {
            PatientManager pat = new PatientManager();
            // Handle the search request
            if (codeMed.matches("Pat\\d+")) {
                
                Patient me = pat.getPatientByCode(codeMed);

                if(me != null) {
                    patient.add(me); 
                }
            }else{
                patient = pat.getPatientByName(codeMed);
            }
        }else if(codePatToDelete != null && !codePatToDelete.isEmpty()) {
            PatientManager pat = new PatientManager();
            pat.deletePatient(codePatToDelete);
            patient = pat.getAllData();
        }else{
            PatientManager pat = new PatientManager();
            patient = pat.getAllData();
        }
        
        request.setAttribute("patient", patient);
        
        String jspPage = "/patient.jsp";
        
        RequestDispatcher dispatcher = request.getRequestDispatcher(jspPage);
        dispatcher.forward(request, response);
    }
}

