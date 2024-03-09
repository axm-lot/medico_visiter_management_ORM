/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlets;

import bean.Medecin;
import bean.Patient;
import bean.Visite;
import bean.VisiteId;

import com.google.gson.Gson;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manager.MedecinManager;
import manager.VisiteManager;

/**
 *
 * @author axm
 */
@WebServlet(name = "VisiteServlet", urlPatterns = {"/visite"})
public class VisiteServlets extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String codeMedToDel = request.getParameter("codeMedToDel");
        String codePatToDel = request.getParameter("codePatToDel");
        String codeMed = request.getParameter("codeMed");
        String codePat = request.getParameter("codePat");
        String date = request.getParameter("date");
        String searchValue = request.getParameter("search");

        List<Visite> visite = new ArrayList<>();
        VisiteManager vm = new VisiteManager();

        if ((codeMedToDel != null && !codeMedToDel.isEmpty()) || (codePatToDel != null && !codePatToDel.isEmpty())) {
            vm.deleteVisite(codeMedToDel, codePatToDel);
        } else if ((codeMed != null && !codeMed.isEmpty()) || (codePat != null && !codePat.isEmpty()) || (date != null && !date.isEmpty())) {
            try {
                System.out.println(date);
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // Adjust the pattern based on your date format
                Date d = dateFormat.parse(date);

                // You need to set values for e and l here
                Medecin m = new Medecin();
                // Set values for e

                Patient p = new Patient();
                // Set values for l

                vm.addVisite(new VisiteId(codeMed, codePat), d, m, p);
            } catch (ParseException e) {
                e.printStackTrace(); // Handle the parse exception appropriately
            }  catch (Exception e) {
                e.printStackTrace(); // Handle the exception appropriately
            }
        }
         

        if (searchValue != null && !searchValue.isEmpty()) {
            // Recherche par date, nom de médecin ou nom de patient
            visite = vm.searchVisite(searchValue);
        } else {
            // Aucune recherche spécifiée, récupérer toutes les visites
            visite = vm.getAllData();
        }

        // Add visite attribute to the request
        request.setAttribute("visite", visite);

        // Forward the request to visite.jsp
        String jspPage = "/visite.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(jspPage);
        dispatcher.forward(request, response);
        
    }
}

