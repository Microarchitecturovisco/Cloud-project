FROM jelastic/maven:3.9.4-openjdk-22.ea-b17 AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN --mount=type=cache,target=/root/.m2 mvn clean package -Dmaven.test.skip

FROM openjdk:22
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build $JAR_FILE /app/runner.jar
ENTRYPOINT java -jar /app/runner.jar