FROM maven:3.6.1-jdk-8 AS MAVEN_BUILD
WORKDIR /build
COPY ./ ./
RUN mvn clean package

FROM openjdk:8-jre
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/simple-syslog-server.jar ./app.jar
CMD ["java", "-jar", "./app.jar", "tls"]
