# Railway Deployment Guide

## Prerequisites
- Railway account (free tier available)
- GitHub account connected to Railway
- This repository pushed to GitHub

## Deployment Steps

### 1. Push Code to GitHub
```bash
git add .
git commit -m "Prepare for Railway deployment"
git push origin main
```

### 2. Create New Project on Railway
1. Go to https://railway.app
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose your repository
5. Select the `backend` folder as the root directory

### 3. Add MySQL Database
1. In your Railway project, click "New"
2. Select "Database" → "Add MySQL"
3. Railway will automatically create a MySQL database

### 4. Configure Environment Variables
Railway will auto-detect most variables from the MySQL service. Verify these are set:

- `DATABASE_URL` - Auto-set by Railway MySQL (format: `jdbc:mysql://host:port/database`)
- `DATABASE_USER` - Auto-set by Railway MySQL
- `DATABASE_PASSWORD` - Auto-set by Railway MySQL
- `SPRING_PROFILES_ACTIVE` - Set to `production`
- `PORT` - Auto-set by Railway

**Manual Configuration (if needed):**
1. Click on your app service
2. Go to "Variables" tab
3. Add:
   - `SPRING_PROFILES_ACTIVE` = `production`
   - `DDL_AUTO` = `update`
   - `HIBERNATE_DIALECT` = `org.hibernate.dialect.MySQLDialect`

### 5. Deploy
Railway will automatically:
- Detect Java 21
- Run Maven build
- Create database tables (via Hibernate)
- Deploy your app

### 6. Access Your App
Once deployed, Railway provides a URL like:
```
https://your-app-name.up.railway.app
```

## Database Tables
Hibernate will automatically create:
- `vital_records` - Main data table
- `vital_records_audit` - Audit trail table
- `revinfo` - Revision information table

## Verify Deployment

### Test the Frontend
Open your Railway URL in a browser - you should see the Clinical Vitals Entry form.

### Test the API
```bash
curl -X POST https://your-app-name.up.railway.app/api/vitals \
  -H "Content-Type: application/json" \
  -d '{"subjectId": "TEST-001", "heartRate": 75, "bloodPressure": "120/80"}'
```

### Check Database
1. In Railway, click on your MySQL database
2. Go to "Data" tab
3. Run query: `SELECT * FROM vital_records_audit;`

## Troubleshooting

### Build Fails
- Check Railway logs for errors
- Ensure Java 21 is being used
- Verify Maven build succeeds locally

### Database Connection Issues
- Verify DATABASE_URL format is correct
- Check MySQL service is running
- Ensure environment variables are set

### App Not Loading
- Check Railway logs: `railway logs`
- Verify PORT environment variable is set
- Check that static files are in `src/main/resources/static`

## Local Testing with MySQL

If you want to test with MySQL locally before deploying:

1. Install MySQL locally
2. Create database: `CREATE DATABASE vitalsdb;`
3. Update `application.yml`:
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/vitalsdb
    driver-class-name: com.mysql.cj.jdbc.Driver
    username: root
    password: your_password
  jpa:
    hibernate:
      ddl-auto: update
    properties:
      hibernate:
        dialect: org.hibernate.dialect.MySQLDialect
```
4. Run: `./mvnw spring-boot:run`

## Cost
- Railway Free Tier: $5 credit/month (enough for small apps)
- MySQL database included in free tier
- No credit card required for free tier

## Support
For Railway-specific issues, check: https://docs.railway.app
