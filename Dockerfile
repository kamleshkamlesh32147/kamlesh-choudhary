# Build Stage
FROM maven:3.8-jdk-11 AS maven
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn package -DskipTests
#Final image
FROM openjdk:17-jre-slim
WORKDIR /app
COPY --from=maven /app/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
#install reactjs and copy files to static directory
RUN apt install npm
COPY index.html /var/www/html/app
ENTRYPOINT [ "executable to start react" ]
EXPOSE 80















