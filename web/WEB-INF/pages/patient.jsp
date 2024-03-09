<%-- 
    Document   : patient
    Created on : Feb 24, 2024, 1:24:03 AM
    Author     : axm
--%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.Patient" %>
<%@ page import="manager.PatientManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        List<Patient> patient = (List<Patient>)request.getAttribute("patient");
    %>
    <h1 style="text-align: center">Gestion Patient</h1>
    <p>${message}</p>
        <table class="table">
            <thead class="table-dark">
                <tr>
                    <th scope="col">Code Patient</th>
                    <th scope="col">Nom</th>
                    <th scope="col">Prénom</th>
                    <th scope="col">Sexe</th>
                    <th scope="col">Adresse</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%-- Boucle à travers la liste des patients --%>
                <% if (patient != null && !patient.isEmpty()) { %>
                        <% for (Patient emp : patient) { %>
                            <tr>
                                <td><%= emp.getCodepat() %></td>
                                <td><%= emp.getNom()%></td>
                                <td><%= emp.getPrenom() %></td>
                                <td><%= emp.getSexe() %></td>
                                <td><%= emp.getAdresse() %></td>
                                <td style="display: flex; justify-content: space-evenly; align-items: center;" >                                    
                                    <button type="button" class="btn btn-primary" style="width: 80px" >Edit</button>
                                    <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal" style="width: 80px">Delete</button>                                                                                       
                                </td>
                            </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="6">Aucun patient trouvé</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </body>
</html>