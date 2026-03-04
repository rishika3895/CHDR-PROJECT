# Clinical Vitals Tracking System

Full-stack application for clinical vitals entry with automatic audit trail using Hibernate Envers.

## Stack
- **Frontend**: Flutter Web (integrated into backend)
- **Backend**: Java 21 + Spring Boot + Hibernate Envers
- **Database**: MySQL (production) / H2 (local development)

## Quick Start (Local Development)

**Run the integrated app:**
```bash
cd backend
./mvnw spring-boot:run
```

Then open: http://localhost:8080/api/

(The Flutter frontend is served from the backend)

## Deployment

See [DEPLOYMENT.md](DEPLOYMENT.md) for complete Railway deployment instructions.

**Quick Deploy:**
1. Push to GitHub
2. Connect Railway to your repo
3. Add MySQL database in Railway
4. Set `SPRING_PROFILES_ACTIVE=production`
5. Deploy!

Railway will automatically create all database tables including audit trail.

## Features
- Real-time validation (HR: 30-250, BP: XXX/YYY format)
- Alert for heart rate > 100
- Sync status indicator
- Automatic audit trail (Hibernate Envers)
- RESTful API
- Single deployable JAR with embedded frontend

## API Endpoints
- `POST /api/vitals` - Create vital record
- `GET /api/vitals` - Get all records

## Audit Trail
All changes are automatically tracked in `vital_records_audit` table:
- **REVTYPE**: 0=INSERT, 1=UPDATE, 2=DELETE
- **REV**: Links to revision timestamp in `revinfo` table
- Full history of all field changes
