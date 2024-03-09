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
        <link rel="stylesheet" href="./style.css">
        <title>JSP Page</title>
    </head>
<body id="employeeTableBody">
        <div class="sidebar">
            <h2>SIDEBAR</h2>
            <ul>
                <li class="nav-item">
                    <a class="nav-link" href="/gestion_patient_ORM/medecin">Medecin</a>
                </li>
                <li class="nav-item">
                    <a id="patientLink" class="nav-link" href="/gestion_patient_ORM/patient">Patient</a>
                    <ul id="patientSubMenu" class="sub-menu" style="display: none;">
                        <li><a href="#" id="ajouterBtn" data-bs-toggle="modal" data-bs-target="#addModal">Ajouter</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/gestion_patient_ORM/visite">Visite</a>
                </li>
            </ul>
        </div>
        <%
            List<Patient> patient = (List<Patient>)request.getAttribute("patient");
        %>
        <header>
            <h3 style="color: gray">Gestion des visites dans un centre medical</h3>
        </header>
        <main>
            <div class="container">
                <div class="row" style="margin: 0 0 10px 0;">
                    <div class="col-md-6 offset-md-3">
                        <form class="d-flex justify-content-between align-items-center" onsubmit="search(event)">
                            <h5 class="col-md-4" style="margin: 0;">Liste des patients</h5>
                            <input class="form-control col-md-4 me-2" type="search" style="max-width: 350px;" placeholder="Code ou nom d'un patient ... " aria-label="Search" id="inputSearchMed">
                            <button class="btn btn-outline-primary col-md-4" type="submit" style="max-width: 160px;">Rechercher</button>
                        </form>
                    </div>
                </div>
            </div>
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
                                        <button id="editButton" type="button" class="btn btn-primary" style="width: 80px" onclick="setValues('<%= emp.getCodepat()%>','<%= emp.getNom()%>','<%= emp.getPrenom()%>','<%= emp.getSexe()%>','<%= emp.getAdresse()%>');$('#editModal').modal('show');getMedCode()">Editer</button>
                                        <button id="deleteButton" type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="confirmDelete('<%= emp.getCodepat()%>');" style="width: 100px">Supprimer</button> 
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
                        <h5 class="modal-title" id="addModalLabel">Ajouter nouveau patient</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="$('#addModal').modal('hide');"></button>
                    </div>
                        <form>
                            <div class="column">
                              <div class="form-group col">
                                <label for="inputNom">Nom</label>
                                <input type="text" class="form-control" id="inputNom" placeholder="Ex: RAKOTO" required>
                              </div>
                              <div class="form-group col" style="margin-top: 20px">
                                <label for="inputPrenom">Prenom</label>
                                <input type="text" class="form-control" id="inputPrenom" placeholder="Ex: Zafy">
                            </div>
                            </div>
                            <div class="form-group" style="margin-top: 20px">
                              <label for="inputSexe">Sexe</label>
                              <input type="text" class="form-control" id="inputSexe" placeholder="Ex: M/F">
                            </div>
                            <div class="form-group" style="margin-top: 20px">
                              <label for="inputAddress">Adresse</label>
                              <input type="text" class="form-control" id="inputAddress" placeholder="Ex: Lot IV261 Tnn">
                            </div>
                            <div class="form-group" style="margin: 20px 20px 40px 0">
                                <button  type="submit" class="btn btn-primary" id="addBtn" onclick="ajouter()">Ajouter</button>
                            </div>
                          </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Supprimer Patient</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="$('#exampleModal').modal('hide');"></button>
            </div>
            <div class="modal-body">
                Voulez-vous vraiment supprimer cet enregistrement?<br/><span style="color:tomato;">Cette action est irreversible</span>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="$('#exampleModal').modal('hide');">Retourner</button>
              <button type="button" class="btn btn-outline-danger" onclick="del(codeToDiscard)"> Supprimer definitivement</button>
            </div>
          </div>
        </div>
      </div>

    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabelTitle">Editer un patient</h5>
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
            function search(event) {
                event.preventDefault(); // Empêche le rechargement de la page par défaut

                // Get the search value from the input field
                var searchValue = document.getElementById("inputSearchMed").value;

                // Make an AJAX request to the servlet
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/gestion_patient_ORM/patient?codeMed=" + searchValue, true);

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

            function ajouter() {
                nom = document.getElementById("inputNom").value;
                prenom = document.getElementById("inputPrenom").value;
                sexe = document.getElementById("inputSexe").value;
                adresse = document.getElementById("inputAddress").value;
                codePatToAdd = "Pat"+Math.floor(Math.random()*10000);
                
                // Make an AJAX request to the servlet
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/gestion_patient_ORM/patient?codePatToAdd=" + codePatToAdd +"&nom="+nom+"&prenom="+prenom+"&sexe="+sexe+"&adresse="+adresse, true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        // Update the table with the search results
                        document.getElementById("employeeTableBody").innerHTML = xhr.responseText;
                    }
                };

                xhr.send();
                alert(codePatToAdd+nom+prenom+sexe+adresse);
                showToast();
            }

            function del(codePatToDelete) {
                // Make an AJAX request to the servlet
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/gestion_patient_ORM/patient?codePatToDelete=" + codePatToDelete, true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        // Update the table with the search results
                        document.getElementById("employeeTableBody").innerHTML = xhr.responseText;
                    }
                };
                xhr.send();
            }

            function confirmDelete(codePatToDelete) {
                $('#exampleModal').modal('show');
                codeToDiscard=codePatToDelete;
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
            function edit(){
                newNom = document.getElementById("editInputNom").value;
                newPrenom = document.getElementById("editInputPrenom").value;
                newSexe = document.getElementById("editInputSexe").value;
                newAdresse = document.getElementById("editInputAdresse").value;
                codePatToEdit = getMedCode();
                
                // Make an AJAX request to the servlet
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/gestion_patient_ORM/patient?codePatToEdit=" + codePatToEdit +"&newNom="+newNom+"&newPrenom="+newPrenom+"&newSexe="+newSexe+"&newAdresse="+newAdresse, true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        // Update the table with the search results
                        document.getElementById("employeeTableBody").innerHTML = xhr.responseText;
                    }
                };

                xhr.send();
                
                console.log(xhr.responseText);
            }

            function toggleSubMenu(event) {
                event.preventDefault();
                var subMenu = document.getElementById("patientSubMenu");
                if (subMenu.style.display === 'block') {
                    subMenu.style.display = 'none';
                } else {
                    subMenu.style.display = 'block';
                }
            }
            function showToast(){
                var toastEl = document.getElementById('myToast');
                var myToast = new bootstrap.Toast(toastEl);
                myToast.show();
                setTimeout(function() {
                    myToast.hide();
                }, 4000);
            };
            
            // Trigger the modal when "Supprimer" button is clicked
            document.getElementById("deleteButton").addEventListener("click", function() {
                $('#exampleModal').modal('show');
            });

            document.getElementById("ajouterBtn").addEventListener("click", function(){
                $('#addModal').modal('show');
            })

            document.getElementById("editButton").addEventListener("click", function(){
                $('#editModal').modal('show');
            })

            document.getElementById("patientLink").addEventListener("click", toggleSubMenu);
        </script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>