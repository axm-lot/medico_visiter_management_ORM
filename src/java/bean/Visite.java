package bean;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.util.Date;

@Entity
@Table(name="visiter")
public class Visite {

    public Visite(){
    }
    public Visite(VisiteId id, Date date, Patient patient) {
        this.id = id;
        this.date = date;
        this.patient = patient;
    }

    @EmbeddedId
    private VisiteId id;
    
    @ManyToOne
    @JoinColumn(name = "codemed", referencedColumnName = "codemed", insertable = false, updatable = false)
    private Medecin medecin;
    
    @ManyToOne
    @JoinColumn(name = "codepat", referencedColumnName = "codepat", insertable = false, updatable = false)
    private Patient patient;
    
    @Column(name = "date")
    private Date date;

    // Getters and Setters
    public VisiteId getId() {
        return id;
    }

    public void setId(VisiteId id) {
        this.id = id;
    }

    public Medecin getMedecin() {
        return medecin;
    }

    public void setMedecin(Medecin medecin) {
        this.medecin = medecin;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
