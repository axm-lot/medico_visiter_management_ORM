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
import com.google.gson.Gson;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manager.PatientManager;

@WebServlet(name = "PatientServlets", urlPatterns = {"/patients"})
public class ApiPatientServlets extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
         // Set CORS headers
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:5173");
        response.setHeader("Access-Control-Allow-Methods", "GET");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        List<Patient> patients = new ArrayList<>();
        
        PatientManager patientManager = new PatientManager();
        patients = patientManager.getAllData();
        
        System.out.println("Patients data:");
        for (Patient patient : patients) {
            System.out.println(patient.toString());
        }
        
        // Convert list of patients to JSON
        Gson gson = new Gson();
        
        String jsonPatients = gson.toJson(patients);
        
        // Set content type and write JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonPatients);
    }
}
