# Clinical Vitals Tracking System

Full-stack application for clinical vitals entry with automatic audit trail using Hibernate Envers.

## Live Demo
🚀 **App URL**: https://vitals-tracker-flxk.onrender.com/api/index.html

## Stack
- **Frontend**: Flutter Web (integrated into backend)
- **Backend**: Java 21 + Spring Boot + Hibernate Envers
- **Database**: H2 (in-memory)
- **Deployment**: Render.com

## Features
- Real-time validation (HR: 30-250, BP: XXX/YYY format)
- Alert for heart rate > 100
- Sync status indicator
- Automatic audit trail (Hibernate Envers)
- RESTful API
- Single deployable JAR with embedded frontend

## Local Development

**Run the app:**
```bash
cd backend
./mvnw spring-boot:run
```

Then open: http://localhost:8080/api/

## API Endpoints
- `POST /api/vitals` - Create vital record
- `GET /api/vitals` - Get all records
- `PUT /api/vitals/{id}` - Update vital record

## Audit Trail

Access H2 Console: https://vitals-tracker-flxk.onrender.com/api/h2-console

**Login:**
- JDBC URL: `jdbc:h2:mem:vitalsdb`
- Username: `sa`
- Password: (leave blank)

**Queries:**
```sql
-- View all records
SELECT * FROM VITAL_RECORDS;

-- View audit trail
SELECT * FROM VITAL_RECORDS_AUD;

-- View revision info
SELECT * FROM REVINFO;

-- Detailed audit history
SELECT 
    v.ID,
    v.SUBJECT_ID,
    v.HEART_RATE,
    v.BLOOD_PRESSURE,
    v.REVTYPE,
    r.REVTSTMP
FROM VITAL_RECORDS_AUD v
JOIN REVINFO r ON v.REV = r.REV
ORDER BY r.REVTSTMP DESC;
```

**REVTYPE Values:**
- `0` = INSERT (new record created)
- `1` = UPDATE (record modified)
- `2` = DELETE (record deleted)

## Deployment

Deployed on Render.com using Docker. Configuration files:
- `Dockerfile` - Multi-stage build with Maven and JRE
- `render.yaml` - Render service configuration

**Note:** H2 is in-memory, so data resets on app restart (free tier limitation).

## Project Structure
```
├── backend/                 # Spring Boot application
│   ├── src/main/java/      # Java source code
│   ├── src/main/resources/ # Config & static files (Flutter build)
│   └── pom.xml             # Maven dependencies
├── frontend/               # Flutter Web application
│   ├── lib/                # Dart source code
│   └── pubspec.yaml        # Flutter dependencies
├── Dockerfile              # Docker build configuration
└── render.yaml             # Render deployment config
```
