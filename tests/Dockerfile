
# Base image: Use OpenJDK 22
FROM openjdk:22-jdk-slim-bullseye

# Create directory for New Relic logs
RUN mkdir -p /usr/local/newrelic/logs

# Copy the compiled JAR file
COPY build/libs/service-*-SNAPSHOT.jar /opt/app.jar

# Set the working directory to /opt
WORKDIR /opt

# Expose port 8080 to allow access to the service
EXPOSE 8080

# Set a default value for the Spring profile (optional)
ENV SPRING_PROFILE=default

# Set the entry point to start the application with the active Spring profile set from the environment variable
ENTRYPOINT ["java", "-Dspring.profiles.active=${SPRING_PROFILE}", "-jar", "app.jar"]
