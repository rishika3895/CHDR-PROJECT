package com.clinical.vitals.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class VitalRecordResponse {
    private Long id;
    private String subjectId;
    private Integer heartRate;
    private String bloodPressure;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private boolean highHeartRateAlert;
}
