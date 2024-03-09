/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlets;

import bean.Medecin;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manager.MedecinManager;

/**
 *
 * @author axm
 */
@WebServlet(name = "ApiMedecinServlets", urlPatterns = {"/medecins"})
public class ApiMedecinServlets extends HttpServlet{
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
         // Set CORS headers
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:5173");
        response.setHeader("Access-Control-Allow-Methods", "GET");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        List<Medecin> medecins = new ArrayList<>();
        
        MedecinManager patientManager = new MedecinManager();
        medecins = patientManager.getAllData();
        
        for (Medecin medecin : medecins) {
            System.out.println(medecin.toString());
        }
        
        // Convert list of patients to JSON
        Gson gson = new Gson();
        
        String jsonMedecins = gson.toJson(medecins);
        
        // Set content type and write JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonMedecins);
    }
}
