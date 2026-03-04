package com.clinical.vitals.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.hibernate.envers.Audited;

import java.time.LocalDateTime;

@Entity
@Table(name = "vital_records")
@Audited
@Data
public class VitalRecord {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Subject ID is required")
    @Column(nullable = false)
    private String subjectId;
    
    @NotNull(message = "Heart rate is required")
    @Min(value = 30, message = "Heart rate must be at least 30")
    @Max(value = 250, message = "Heart rate must not exceed 250")
    @Column(nullable = false)
    private Integer heartRate;
    
    @NotBlank(message = "Blood pressure is required")
    @Pattern(regexp = "\\d{2,3}/\\d{2,3}", message = "Blood pressure must be in format XXX/YYY")
    @Column(nullable = false)
    private String bloodPressure;
    
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @Column(nullable = false)
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
