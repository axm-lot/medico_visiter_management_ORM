package bean;

import jakarta.persistence.*;

@Entity
@Table(name = "PATIENT")
public class Patient {

    @Id
    @Column(name = "codepat", length = 15)
    private String codepat;

    @Column(name = "nom", length = 50)
    private String nom;

    @Column(name = "prenom", length = 50)
    private String prenom;

    @Column(name = "sexe", length = 10)
    private String sexe;

    @Column(name = "adresse", length = 30)
    private String adresse;
    
    public Patient() {}

    public Patient(String codepat, String nom, String prenom, String sexe, String adresse) {
        this.codepat = codepat;
        this.nom = nom;
        this.prenom = prenom;
        this.sexe = sexe;
        this.adresse = adresse;
    }

    public String getCodepat() {
        return codepat;
    }

    public void setCodepat(String codepat) {
        this.codepat = codepat;
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

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }
    @Override
    public String toString(){
        return "Patient{"+
             "codepat='"+codepat+'\''+
                ", nom='"+nom+'\''+
                ", prenom='"+prenom+'\''+
                ",sexe='"+sexe+'\''+
                ",adresse='"+adresse+'\''+
        '}';
    }
}