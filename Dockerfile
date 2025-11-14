FROM tomcat:9.0.56

ARG POM_XML

ADD src/ /helloworld/src
ADD $POM_XML /helloworld/pom.xml

#  Build spring app
RUN apt update && apt install maven -y
WORKDIR /helloworld/
RUN mvn clean package

#  Deploy to tomcat
RUN mv target/helloworld.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
