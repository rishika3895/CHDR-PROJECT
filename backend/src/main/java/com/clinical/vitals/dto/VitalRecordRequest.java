package com.clinical.vitals.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class VitalRecordRequest {
    
    @NotBlank(message = "Subject ID is required")
    private String subjectId;
    
    @NotNull(message = "Heart rate is required")
    @Min(value = 30, message = "Heart rate must be at least 30")
    @Max(value = 250, message = "Heart rate must not exceed 250")
    private Integer heartRate;
    
    @NotBlank(message = "Blood pressure is required")
    @Pattern(regexp = "\\d{2,3}/\\d{2,3}", message = "Blood pressure must be in format XXX/YYY")
    private String bloodPressure;
}
