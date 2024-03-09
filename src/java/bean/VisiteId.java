/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import java.io.Serializable;
import java.util.Objects;

/**
 *
 * @author axm
 */
public class VisiteId implements Serializable {
    private String codemed;
    private String codepat;

    public VisiteId() {
    }

    public VisiteId(String codemed, String codepat) {
        this.codemed = codemed;
        this.codepat = codepat;
    }

    public String getCodemed() {
        return codemed;
    }

    public void setCodemed(String codemed) {
        this.codemed = codemed;
    }

    public String getCodepat() {
        return codepat;
    }

    public void setCodepat(String codepat) {
        this.codepat = codepat;
    }
    
    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + Objects.hashCode(this.codemed);
        hash = 53 * hash + Objects.hashCode(this.codepat);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final VisiteId other = (VisiteId) obj;
        if (!Objects.equals(this.codemed, other.codemed)) {
            return false;
        }
        return Objects.equals(this.codepat, other.codepat);
    }

    @Override
    public String toString() {
        return "VisiteId{" + "codemed=" + codemed + ", codepat=" + codepat + '}';
    }
}
