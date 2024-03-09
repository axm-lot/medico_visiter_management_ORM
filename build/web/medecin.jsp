<%-- 
    Document   : medecin
    Created on : Feb 27, 2024, 9:12:34 AM
    Author     : axm
--%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.Medecin" %>
<%@ page import="manager.MedecinManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="./style.css">
        <title>Medecin</title>
    </head>
    <body id="employeeTableBody">
        <div class="sidebar">
            <h2>SIDEBAR</h2>
            <ul>
                <li class="nav-item">
                    <a id="medecinLink" class="nav-link" href="/gestion_patient_ORM/medecin">Medecin</a>
                    <ul id="medecinSubMenu" class="sub-menu" style="display: none;">
                        <li><a href="#" id="ajouterBtn" data-bs-toggle="modal" data-bs-target="#addModal">Ajouter</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/gestion_patient_ORM/patient">Patient</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/gestion_patient_ORM/visite">Visite</a>
                </li>
            </ul>
        </div>
        <%
            List<Medecin> medecin = (List<Medecin>)request.getAttribute("medecin");
        %>
        <header>
            <h3 style="color: gray">Gestion des visites dans un centre medical</h3>
        </header>
        <main>
            <div class="container">
                <div class="row" style="margin: 0 0 10px 0;">
                    <div class="col-md-6 offset-md-3">
                        <form class="d-flex justify-content-between align-items-center" onsubmit="search(event)">
                            <h5 class="col-md-4" style="margin: 0;">Liste des medecins</h5>
                            <input class="form-control col-md-4 me-2" type="search" style="max-width: 350px;" placeholder="Code ou nom d'un medecin ... " aria-label="Search" id="inputSearchMed">
                            <button class="btn btn-outline-primary col-md-4" type="submit" style="max-width: 160px;">Rechercher</button>
                        </form>
                    </div>
                </div>
            </div>         
            <table class="table">
                <thead class="table-dark">
                    <tr>
                        <th scope="col">Code medecin</th>
                        <th scope="col">Nom</th>
                        <th scope="col">Prénom</th>
                        <th scope="col">Grade</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (medecin != null && !medecin.isEmpty()) { %>
                        <% for (Medecin emp : medecin) { %>
                            <tr>
                                <td><%= emp.getCodemed() %></td>
                                <td><%= emp.getNom()%></td>
                                <td><%= emp.getPrenom() %></td>
                                <td><%= emp.getGrade() %></td>
                                <td style="display: flex; justify-content: space-evenly; align-items: center;" >                                    
                                    <button id="editButton" type="button" class="btn btn-primary" style="width: 80px" onclick="setValues('<%= emp.getCodemed()%>','<%= emp.getNom()%>','<%= emp.getPrenom()%>','<%= emp.getGrade()%>');$('#editModal').modal('show');getMedCode()">Editer</button>
                                    <button id="deleteButton" type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="confirmDelete('<%= emp.getCodemed()%>');" style="width: 100px">Supprimer</button> 
                                </td>
                            </tr>
                        <% } %>
                        <% } else { %>
                        <tr>
                            <td colspan="6">Aucun medecin trouvé</td>
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
                        <h5 class="modal-title" id="addModalLabel">Ajouter nouveau medecin</h5>
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
                              <label for="inputGrade">Grade</label>
                              <input type="text" class="form-control" id="inputGrade" placeholder="Ex: Medecin diplômé d'Etat">
                            </div>
                            <div class="form-group" style="margin: 20px 20px 40px 0">
                                <button  type="submit" class="btn btn-primary" id="addBtn" onclick="ajouter();">Ajouter</button>
                            </div>
                          </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Supprimer Medecin</h5>
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
                    <h5 class="modal-title" id="editModalLabelTitle">Editer un medecin</h5>
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
                          <label for="editInputGrade">Grade</label>
                          <input type="text" class="form-control" id="editInputGrade" placeholder="Ex: Medecin diplômé d'Etat">
                        </div>
                        <div class="form-group" style="margin: 20px 0 20px 20px ">
                            <button  type="submit" class="btn btn-primary" id="saveBtn" onclick="edit()">Enregistrer</button>
                        </div>
                    </form>
            </div>
        </div>
    </div>
        
        <div class="modal fade" id="exampleToast" tabindex="-1" aria-labelledby="exampleToast" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modal </h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="$('#exampleToast').modal('hide');"></button>
            </div>
            <div class="modal-body">
                <span style="color:tomato;">Vous venez d'inserer un medecin !</span>
            </div>
          </div>
        </div>
      </div>

                

                
        <script>         
            let codeToDiscard;
            function showAddModal(){
                document.getElementById("addModal").modal('show');
            }

            function search(event) {
                event.preventDefault();
                var searchValue = document.getElementById("inputSearchMed").value;

                // Make an AJAX request to the servlet
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/gestion_patient_ORM/medecin?codeMed=" + searchValue, true);

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
                grade = document.getElementById("inputGrade").value;
                codeEmpToAdd = "Med"+Math.floor(Math.random()*10000);

                // Make an AJAX request to the servlet
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/gestion_patient_ORM/medecin?codeEmpToAdd=" + codeEmpToAdd +"&nom="+nom+"&prenom="+prenom+"&grade="+grade, true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        // Update the table with the search results
                        document.getElementById("employeeTableBody").innerHTML = xhr.responseText;
                    }
                };

                xhr.send();
            }

            function del(codeMedToDelete) {
                // Make an AJAX request to the servlet
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/gestion_patient_ORM/medecin?codeMedToDelete=" + codeMedToDelete, true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        // Update the table with the search results
                        document.getElementById("employeeTableBody").innerHTML = xhr.responseText;
                    }
                };
                xhr.send();
            }

            function confirmDelete(codeMedToDelete) {
                $('#exampleModal').modal('show');
                codeToDiscard=codeMedToDelete;
            }

            function setValues(codemed, nom, prenom, grade){
                document.getElementById("editInputCode").value = codemed;
                document.getElementById("editInputNom").value = nom;
                document.getElementById("editInputPrenom").value = prenom;
                document.getElementById("editInputGrade").value = grade;
            }
            function getMedCode(){
                return document.getElementById("editInputCode").value;
            }
            function edit(){
                newNom = document.getElementById("editInputNom").value;
                newPrenom = document.getElementById("editInputPrenom").value;
                newGrade = document.getElementById("editInputGrade").value;
                codeEmpToEdit = getMedCode();
                
                // Make an AJAX request to the servlet
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/gestion_patient_ORM/medecin?codeEmpToEdit=" + codeEmpToEdit +"&newNom="+newNom+"&newPrenom="+newPrenom+"&newGrade="+newGrade, true);

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
                var subMenu = document.getElementById("medecinSubMenu");
                if (subMenu.style.display === 'block') {
                    subMenu.style.display = 'none';
                } else {
                    subMenu.style.display = 'block';
                }
            }
            function showToast() {
                $('#exampleToast').modal('show');
                setTimeout(function () {
                $('#exampleToast').modal('hide');
                }, 4000);
            }
            
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

            document.getElementById("medecinLink").addEventListener("click", toggleSubMenu);
        </script>
        
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>
