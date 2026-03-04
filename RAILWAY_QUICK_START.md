# Railway Deployment - Quick Start

## 🎯 What You Have Now
- ✅ Flutter Web app integrated into Spring Boot
- ✅ Single JAR file that serves both frontend and backend
- ✅ MySQL support configured
- ✅ Ready for Railway deployment

## 🚀 Deploy in 5 Steps

### 1. Push to GitHub
```bash
git add .
git commit -m "Ready for Railway deployment"
git push origin main
```

### 2. Create Railway Project
1. Go to https://railway.app/new
2. Click "Deploy from GitHub repo"
3. Select your repository
4. **Important**: Set root directory to `backend`

### 3. Add MySQL Database
1. In your project, click "+ New"
2. Select "Database" → "Add MySQL"
3. Wait for it to provision (~30 seconds)

### 4. Link Database to App
Railway should auto-link the database. Verify these variables exist in your app:
- `DATABASE_URL`
- `DATABASE_USER`  
- `DATABASE_PASSWORD`

### 5. Set Environment Variables
In your app service, go to "Variables" tab and add:
```
SPRING_PROFILES_ACTIVE=production
```

That's it! Railway will automatically:
- Build your app with Maven
- Create database tables
- Deploy and give you a public URL

## 🌐 Your App URL
After deployment, you'll get a URL like:
```
https://vitals-tracker-production.up.railway.app
```

Open it in your browser - the full app (frontend + backend) will be there!

## 🗄️ Database Tables
Hibernate automatically creates:
- `vital_records` - Main data
- `vital_records_audit` - Audit trail
- `revinfo` - Revision timestamps

## 🧪 Test Your Deployed App

### Via Browser
Just open your Railway URL and use the form!

### Via API
```bash
curl -X POST https://your-app.up.railway.app/api/vitals \
  -H "Content-Type: application/json" \
  -d '{"subjectId":"TEST-001","heartRate":75,"bloodPressure":"120/80"}'
```

## 💰 Cost
- Railway Free Tier: $5 credit/month
- This app uses ~$3-4/month
- No credit card needed for free tier

## 🔧 Troubleshooting

### Build Fails
Check Railway logs. Common issues:
- Java version mismatch (should be 21)
- Maven build errors

### Database Connection Error
Verify environment variables are set:
```bash
railway variables
```

### App Not Loading
- Check logs: Click on your service → "Deployments" → Latest deployment → "View Logs"
- Verify PORT is set (Railway sets this automatically)

## 📚 More Info
See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed documentation.

## 🎉 Success Checklist
- [ ] Code pushed to GitHub
- [ ] Railway project created
- [ ] MySQL database added
- [ ] Environment variables set
- [ ] App deployed successfully
- [ ] Can access app via Railway URL
- [ ] Can submit vitals through the form
- [ ] Data appears in MySQL database
