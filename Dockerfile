#FROM alpine:3.14
#FROM openjdk:latest
#COPY HelloWorld.java /
#RUN javac HelloWorld.java
#ENTRYPOINT ["java","HelloWorld"]
#test

FROM alpine:3.11
RUN apk --no-cache add git python3 py-lxml \
    && rm -rf /var/cache/apk/*
WORKDIR /
RUN git clone https://github.com/stamparm/DSVW
WORKDIR /DSVW
RUN sed -i 's/127.0.0.1/0.0.0.0/g' dsvw.py
EXPOSE 65412
CMD ["python3", "dsvw.py"]