FROM maven

LABEL maintainer="yari@mail.um.ac.ir"
COPY src /home/app/src
COPY pom.xml /home/app
WORKDIR /home/app
RUN mvn clean
RUN  mvn install -DskipTests
EXPOSE 8080

ENTRYPOINT ["java","-jar","/home/app/target/electionmanager-1.0.jar"]
