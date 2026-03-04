package com.clinical.vitals.controller;

import com.clinical.vitals.dto.VitalRecordRequest;
import com.clinical.vitals.dto.VitalRecordResponse;
import com.clinical.vitals.service.VitalRecordService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/vitals")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class VitalRecordController {
    
    private final VitalRecordService service;
    
    @PostMapping
    public ResponseEntity<VitalRecordResponse> createVitalRecord(
            @Valid @RequestBody VitalRecordRequest request) {
        VitalRecordResponse response = service.createVitalRecord(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
    
    @GetMapping
    public ResponseEntity<List<VitalRecordResponse>> getAllRecords() {
        return ResponseEntity.ok(service.getAllRecords());
    }
}
