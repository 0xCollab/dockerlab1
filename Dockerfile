FROM alpine:3.14
FROM openjdk:latest
COPY HelloWorld.java /
RUN javac HelloWorld.java
ENTRYPOINT ["java","HelloWorld"]
