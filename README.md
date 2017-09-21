# centos7-jdk8-docker
the docker to set up jdk8 on centos7

# jdk
please download the JDK rpm version from http://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html, and place it as jdk/jdk-8-linux-x64.rpm
 
# build docker
docker build -t lionfin/centos7-jdk8:latest .

#dangling volume need to be pruned
docker volume rm $(docker volume ls -f "dangling=true" -q)

#dangling images need to be pruned
docker rmi $(docker images -f "dangling=true" -q)

#push
docker login
docker push lionfin/centos7-jdk8:latest
docker logout

# run
docker run -d --name lionfin-java -it -p 8080:8080 -p 8081:8081 -p 8787:8787 lionfin/centos7-jdk8:latest

# use volume to map all your files into the server if they should be accept with permission, e.g.
docker run -d --name lionfin-java -it -v `pwd`/start.sh:/opt/lionfin/start.sh -p 8080:8080 -p 8081:8081 -p 8787:8787 lionfin/centos7-jdk8:latest