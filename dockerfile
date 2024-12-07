# Stage 1: Build
FROM maven:3.8.8-eclipse-temurin-21 AS builder

# Set the working directory
WORKDIR /app

# Copy the project files to the container
COPY . .

# Build the application (skip tests to speed up the process)
RUN ./mvnw clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:21-jre

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Command to run the application
CMD ["java", "-jar", "app.jar"]
