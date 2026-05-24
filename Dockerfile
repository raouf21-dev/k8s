# Stage 1: Build the JAR
FROM gradle:8.14-jdk17 AS builder
WORKDIR /app
COPY . .
RUN gradle build --no-daemon -x test

FROM openjdk:17.0.2-jdk
EXPOSE 8080
RUN mkdir /opt/app
COPY --from=builder /app/build/libs/*.jar /opt/app/app.jar
WORKDIR /opt/app
CMD ["java", "-jar", "app.jar"]