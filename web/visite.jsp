<%-- 
    Document   : visite
    Created on : Mar 3, 2024, 2:33:28 AM
    Author     : axm
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="manager.PatientManager"%>
<%@page import="manager.MedecinManager"%>
<%@page import="bean.Patient"%>
<%@page import="bean.Medecin"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.Visite" %>
<%@ page import="manager.VisiteManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="./style.css">
        <title>Visite</title>
    </head>
    <body id="employeeTableBody">
            <div class="sidebar">
                <h2>SIDEBAR</h2>
                <ul>
                    <li class="nav-item">
                        <a class="nav-link" href="/gestion_patient_ORM/medecin">Medecin</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/gestion_patient_ORM/patient">Patient</a>
                    </li>
                    <li class="nav-item">
                        <a id="visiteLink" class="nav-link" href="/gestion_patient_ORM/visite">Visite</a>
                        <ul id="visiteSubMenu" class="sub-menu" style="display: none;">
                            <li><a href="#" id="ajouterBtn" data-bs-toggle="modal" data-bs-target="#addModal">Ajouter</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <%
                List<Visite> visite = (List<Visite>)request.getAttribute("visite");
                Medecin med = new Medecin();
                Patient pat = new Patient();
                VisiteManager vm = new VisiteManager();
                MedecinManager mm = new MedecinManager();
                PatientManager pm = new PatientManager();
            %>
            <header>
                <h3 style="color: gray">Gestion des visites dans un centre medical</h3>
            </header>
            <main>
                <div class="container">
                    <div class="row" style="margin: 0 0 10px 0;">
                        <div class="col-md-6 offset-md-3">
                            <form class="d-flex justify-content-between align-items-center" onsubmit="search(event)">
                                <h5 class="col-md-4" style="margin: 0;">Liste des visites</h5>
                                <input class="form-control col-md-4 me-2" type="search" style="max-width: 350px;" placeholder="Code ou nom d'un patient ... " aria-label="Search" id="inputSearchVis">
                                <button class="btn btn-outline-primary col-md-4" type="submit" style="max-width: 160px;">Rechercher</button>
                            </form>
                        </div>
                    </div>
                </div>
                <table class="table">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col">Medecin</th>
                            <th scope="col">Patient</th>
                            <th scope="col">Date</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (visite != null && !visite.isEmpty()) { %>
                            <% for (Visite emp : visite) { %>
                                <tr>
                                    <td><%= vm.getMedDetails(emp.getId().getCodemed()).getNom()+" "+vm.getMedDetails(emp.getId().getCodemed()).getPrenom()%></td>
                                    <td><%= vm.getPatientDetails(emp.getId().getCodepat()).getNom()+" "+vm.getPatientDetails(emp.getId().getCodepat()).getPrenom()%></td>
                                    <td><% SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy"); %>
                                    <% String formattedDate = dateFormat.format(emp.getDate()); %>
                                    <p class="card-text"><%= formattedDate %></p></td>
                                    <td style="display: flex; justify-content: space-evenly; align-items: center;">
                                        <button type="button" class="btn btn-primary" style="width: 80px">Editer</button>
                                        <button type="button" class="btn btn-outline-danger" style="width: 100px" onclick="confirmDelete('<%= emp.getId().getCodemed()%>','<%= emp.getId().getCodepat()%>')">Supprimer</button>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="4">Aucun visite trouvé</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </main>
            <footer>
                <div class="footer-copyright">
                    &copy; 2024 Copyright : projet hibernate
                </div>
            </footer>

            <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addModalLabel">Ajouter nouveau visite</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="$('#addModal').modal('hide');"></button>
                        </div>
                            <form>
                                <div class="column">
                                <!-- Select Medecin -->
                                <% List<Medecin> medecinListInVisite = mm.getAllData(); %>
                                    <div class="mb-3">
                                        <label for="selectMedecin" class="form-label"></label>
                                        <select class="form-select" id="selectMedecin" required style="width: 90%; margin: 0 5% 0 5%">
                                            <option selected disabled>Choisir un medecin</option>
                                            <% for (Medecin medecinInViste : medecinListInVisite) { %>
                                            <option value='<%= medecinInViste.getCodemed()%>'>
                                                <%= '#'+medecinInViste.getNom()+' '+medecinInViste.getPrenom() %>
                                            </option>
                                            <% } %>
                                        </select>
                                        
                                    </div>                             
                                </div>
                                <!-- Select Patient -->
                                <% List<Patient> patientListInVisite = pm.getAllData(); %>
                                <div class="mb-3">
                                    <label for="selectPatient" class="form-label"></label>
                                    <select class="form-select" id="selectPatient" required  style="width: 90%; margin: 0 5% 0 5%">
                                        <option selected disabled>Choisir un patient</option>
                                        <% for (Patient patientInVisite : patientListInVisite) { %>
                                        <option value='<%= patientInVisite.getCodepat()%>'>
                                            <%= '#'+patientInVisite.getNom()+' '+patientInVisite.getPrenom() %>
                                        </option>
                                        <% } %>
                                    </select>
                                </div>
                                <!-- Date Picker -->
                                <div class="mb-3">
                                    <label for="datepicker" class="form-label" style="margin: 0 0 0 5% ">Date de la visite</label>
                                    <input type="date" class="form-control" id="datepicker" required  style="width: 90%; margin: 0 5% 0 5%">
                                </div>
                                <div class="form-group" style="margin: 20px 20px 40px 0">
                                    <button  type="submit" class="btn btn-primary" id="addBtn" onclick="ajouter(event)">Ajouter</button>
                                </div>
                            </form>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Supprimer Visite</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="$('#exampleModal').modal('hide');"></button>
                </div>
                <div class="modal-body">
                    Voulez-vous vraiment supprimer cet enregistrement ?<br/><span style="color:tomato;">Cette action est irreversible</span>
                </div>
                <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="$('#exampleModal').modal('hide');">Retourner</button>
                <button type="button" class="btn btn-outline-danger" onclick="del(codeToDiscard, codeToDiscard1)"> Supprimer definitivement</button>
                </div>
            </div>
            </div>
        </div>

        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabelTitle">Editer un visite</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="$('#editModal').modal('hide');"></button>
                    </div>
                        <form>
                            <div class="column">
                                <div class="form-group col">
                                    <input type="hidden" class="form-control" id="editInputCode" placeholder="Ex: Med777">
                                </div>
                            <div class="form-group col">
                                <label for="editInputNom">Nom</label>
                                <input type="text" class="form-control" id="editInputNom" placeholder="Ex: RAKOTO" required>
                            </div>
                            <div class="form-group col" style="margin-top: 20px">
                                <label for="editInputPrenom">Prenom</label>
                                <input type="text" class="form-control" id="editInputPrenom" placeholder="Ex: Zafy">
                            </div>
                            </div>
                            <div class="form-group" style="margin-top: 20px">
                            <label for="editInputSexe">Sexe</label>
                            <input type="text" class="form-control" id="editInputSexe" placeholder="Ex: M/F">
                            </div>
                            <div class="form-group" style="margin-top: 20px">
                            <label for="editInputAdresse">Adresse</label>
                            <input type="text" class="form-control" id="editInputAdresse" placeholder="Ex: Rue de Paris">
                            </div>
                            <div class="form-group" style="margin: 20px 0 20px 20px ">
                                <button  type="submit" class="btn btn-primary" id="saveBtn" onclick="edit()">Enregistrer</button>
                            </div>
                        </form>
                </div>
            </div>
        </div>
        <script>
                let codeToDiscard;
                let codeToDiscard1;
                
                document.getElementById("visiteLink").addEventListener("click", toggleSubMenu);

                function ajouter(event) {
                    event.preventDefault();
                    var currentTimestamp = new Date().getTime();
                    var currentTime = new Date(currentTimestamp);
                    var hours = currentTime.getHours();
                    var minutes = currentTime.getMinutes();
                    var seconds = currentTime.getSeconds();
                    var formattedTime = hours + ':' + (minutes < 10 ? '0' : '') + minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
                    codeMed = document.getElementById("selectMedecin").value;
                    codePat = document.getElementById("selectPatient").value;
                    date = document.getElementById("datepicker").value+' '+formattedTime;
                    console.log("ADD : "+codeMed+codePat+date);
                    var xhr = new XMLHttpRequest();
                    xhr.open("GET", "/gestion_patient_ORM/visite?codeMed=" + codeMed +"&codePat="+codePat+"&date="+date, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            document.getElementById("employeeTableBody").innerHTML = xhr.responseText;
                        }
                    };
                    xhr.send();
                }

                function del(codeMedToDel, codePatToDel) {
                    var xhr = new XMLHttpRequest();
                    xhr.open("GET", "/gestion_patient_ORM/visite?codeMedToDel="+ codeMedToDel+"&codePatToDel=" + codePatToDel, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            document.getElementById("employeeTableBody").innerHTML = xhr.responseText;
                        }
                    };
                    xhr.send();
                }

                function confirmDelete(codeMedToDelete, codePatToDelete) {
                    $('#exampleModal').modal('show');
                    codeToDiscard=codeMedToDelete;
                    codeToDiscard1=codePatToDelete;
                    console.log(codeToDiscard+codeToDiscard1);
                }

                function search(event) {
                    event.preventDefault();
                    var searchValue = document.getElementById("inputSearchVis").value;

                    // Make an AJAX request to the servlet
                    var xhr = new XMLHttpRequest();
                    xhr.open("GET", "/gestion_patient_ORM/visite?search=" + searchValue, true);

                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            // Update the table with the search results
                            document.getElementById("employeeTableBody").innerHTML = xhr.responseText;
                        } else {
                            console.error('Error: ' + xhr.status);
                        }
                    };

                    console.log(searchValue);
                    xhr.send();
                }

                function setValues(codepat, nom, prenom, sexe, adresse){
                    document.getElementById("editInputCode").value = codepat;
                    document.getElementById("editInputNom").value = nom;
                    document.getElementById("editInputPrenom").value = prenom;
                    document.getElementById("editInputSexe").value = sexe;
                    document.getElementById("editInputAdresse").value = adresse;
                }
                function getMedCode(){
                    return document.getElementById("editInputCode").value;
                }

                function toggleSubMenu(event) {
                    event.preventDefault();
                    var subMenu = document.getElementById("visiteSubMenu");
                    if (subMenu.style.display === 'block') {
                        subMenu.style.display = 'none';
                    } else {
                        subMenu.style.display = 'block';
                    }
                }
                
                // Trigger the modal when "Supprimer" button is clicked
                document.getElementById("deleteButton").addEventListener("click", function() {
                    $('#exampleModal').modal('show');
                });

                document.getElementById("ajouterBtn").addEventListener("click", function(){
                    $('#addModal').modal('show');
                });

                document.getElementById("editButton").addEventListener("click", function(){
                    $('#editModal').modal('show');
                });
            </script>
            <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>