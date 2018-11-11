#
# map the world directory into the container to /home/minecraft/world
#
#



from centos
#requirements
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel sudo nano wget && yum -y update && yum clean all && ENV JAVA_HOME /usr/lib/jvm/java-openjdk && ENV PATH PATH$:JAVA_HOME/bin
#from scratch

# download minecraft
RUN useradd -m minecraft && usermod -aG wheel minecraft &&  su - minecraft -c "wget -q https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar && echo 'eula=true' > eula.txt && cd  && mkdir world"

#forge installieren
RUN su - minecraft -c "wget -q https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2772/forge-1.12.2-14.23.5.2772-installer.jar && java -jar forge-1.12.2-14.23.5.2772-installer.jar --installServer"

WORKDIR /home/minecraft

USER minecraft
ENTRYPOINT [ "java" "Xmx2048M -Xms2048M -jar","forge-1.12.2-14.23.5.2772-universal.jar","nogui" ]
#CMD [ "/bin/bash", "java -Xmx2048M -Xms2048M -jar forge-1.12.2-14.23.5.2772-universal.jar nogui" ]