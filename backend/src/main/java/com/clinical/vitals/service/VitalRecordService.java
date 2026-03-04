package com.clinical.vitals.service;

import com.clinical.vitals.dto.VitalRecordRequest;
import com.clinical.vitals.dto.VitalRecordResponse;
import com.clinical.vitals.model.VitalRecord;
import com.clinical.vitals.repository.VitalRecordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class VitalRecordService {
    
    private final VitalRecordRepository repository;
    
    @Transactional
    public VitalRecordResponse createVitalRecord(VitalRecordRequest request) {
        VitalRecord record = new VitalRecord();
        record.setSubjectId(request.getSubjectId());
        record.setHeartRate(request.getHeartRate());
        record.setBloodPressure(request.getBloodPressure());
        
        VitalRecord saved = repository.save(record);
        return toResponse(saved);
    }
    
    public List<VitalRecordResponse> getAllRecords() {
        return repository.findAll().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }
    
    private VitalRecordResponse toResponse(VitalRecord record) {
        VitalRecordResponse response = new VitalRecordResponse();
        response.setId(record.getId());
        response.setSubjectId(record.getSubjectId());
        response.setHeartRate(record.getHeartRate());
        response.setBloodPressure(record.getBloodPressure());
        response.setCreatedAt(record.getCreatedAt());
        response.setUpdatedAt(record.getUpdatedAt());
        response.setHighHeartRateAlert(record.getHeartRate() > 100);
        return response;
    }
}
