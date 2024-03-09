/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlets;

import bean.Medecin;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manager.MedecinManager;

/**
 *
 * @author axm
 */
@WebServlet(name = "MedecinServlet", urlPatterns = {"/medecin"})
public class MedecinServlets extends HttpServlet{
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String codeMed = request.getParameter("codeMed");
        String codeMedToDelete = request.getParameter("codeMedToDelete");
        String codeEmpToAdd = request.getParameter("codeEmpToAdd");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String grade = request.getParameter("grade");
        String codeEmpToEdit = request.getParameter("codeEmpToEdit");
        String newNom = request.getParameter("newNom");
        String newPrenom = request.getParameter("newPrenom");
        String newGrade = request.getParameter("newGrade");

        List<Medecin> medecin = new ArrayList<>();

        if(codeEmpToEdit != null && !codeEmpToEdit.isEmpty() && newNom != null && !newNom.isEmpty() && newPrenom != null && !newPrenom.isEmpty() && newGrade != null && !newGrade.isEmpty() ){
            MedecinManager med = new MedecinManager();
            med.editMedecin(codeEmpToEdit, newNom, newPrenom, newGrade);
            medecin = med.getAllData();
        }else if(codeEmpToAdd!=null && !codeEmpToAdd.isEmpty() && nom != null && !nom.isEmpty() && prenom != null && !prenom.isEmpty() && grade != null && !grade.isEmpty()){
            MedecinManager med = new MedecinManager();
            med.addMedecin(codeEmpToAdd, nom, prenom, grade);
            medecin = med.getAllData();
        }else if (codeMed != null && !codeMed.isEmpty()) {
            MedecinManager med = new MedecinManager();
            System.out.print("CODE MEDECIN ! "+codeMed);
            // Handle the search request
            if (codeMed.matches("Med\\d+")) {
                
                Medecin me = med.getMedecinByCode(codeMed);

                if(me != null) {
                    medecin.add(me); 
                }
            }else{
                //MedecinManager med = new MedecinManager();
                medecin = med.getMedecinByName(codeMed);
            }
        }else if(codeMedToDelete != null && !codeMedToDelete.isEmpty()) {
            MedecinManager med = new MedecinManager();
            med.deleteMedecin(codeMedToDelete);
            medecin = med.getAllData();
        }else{
            MedecinManager pat = new MedecinManager();
            medecin = pat.getAllData();
        }

        
        request.setAttribute("medecin", medecin);
        
        String jspPage = "/medecin.jsp";
        
        RequestDispatcher dispatcher = request.getRequestDispatcher(jspPage);
        dispatcher.forward(request, response);
    }
}
