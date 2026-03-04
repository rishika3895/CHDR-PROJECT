#!/bin/bash

# Deployment preparation script for Railway

echo "🚀 Preparing Clinical Vitals Tracker for Railway deployment..."

# Step 1: Build Flutter Web
echo "📦 Building Flutter web app..."
cd frontend
flutter build web --release
cd ..

# Step 2: Copy Flutter build to Spring Boot static resources
echo "📋 Copying Flutter build to backend..."
rm -rf backend/src/main/resources/static
cp -r frontend/build/web backend/src/main/resources/static

# Step 3: Build Spring Boot application
echo "🔨 Building Spring Boot application..."
cd backend
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
./mvnw clean package -DskipTests
cd ..

echo "✅ Build complete!"
echo ""
echo "📝 Next steps:"
echo "1. Commit and push to GitHub:"
echo "   git add ."
echo "   git commit -m 'Prepare for Railway deployment'"
echo "   git push origin main"
echo ""
echo "2. Deploy on Railway:"
echo "   - Go to https://railway.app"
echo "   - Create new project from GitHub repo"
echo "   - Select 'backend' as root directory"
echo "   - Add MySQL database"
echo "   - Set SPRING_PROFILES_ACTIVE=production"
echo "   - Deploy!"
echo ""
echo "📖 See DEPLOYMENT.md for detailed instructions"
