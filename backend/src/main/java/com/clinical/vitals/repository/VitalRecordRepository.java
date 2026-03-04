package com.clinical.vitals.repository;

import com.clinical.vitals.model.VitalRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VitalRecordRepository extends JpaRepository<VitalRecord, Long> {
}
