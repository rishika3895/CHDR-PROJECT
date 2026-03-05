# Build stage
FROM maven:3.9.5-eclipse-temurin-21 AS build
WORKDIR /app
COPY backend/pom.xml .
COPY backend/mvnw .
COPY backend/.mvn .mvn
RUN mvn dependency:go-offline
COPY backend/src src
COPY backend/src/main/resources/static src/main/resources/static
RUN mvn clean package -DskipTests

# Run stage
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/vitals-tracker-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-Dserver.port=${PORT:-8080}", "-jar", "app.jar"]
