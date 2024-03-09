/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 *
 * @author axm
 */
@Entity
@Table(name="MEDECIN")
public class Medecin {
    @Id
    @Column(name = "codemed", length = 15)
    private String codemed;
    
    @Column(name = "nom", length = 50)
    private String nom;

    @Column(name = "prenom", length = 50)
    private String prenom;

    @Column(name = "grade", length = 15)
    private String grade;

    public Medecin(){}    
    
    public Medecin(String codemed, String nom, String prenom, String grade) {
        this.codemed = codemed;
        this.nom = nom;
        this.prenom = prenom;
        this.grade = grade;
    }

    public String getCodemed() {
        return codemed;
    }

    public void setCodemed(String codemed) {
        this.codemed = codemed;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}
