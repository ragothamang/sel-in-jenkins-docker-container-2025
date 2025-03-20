FROM jenkins/jenkins:lts

# Switch to root user
USER root

# Install Java, Maven, and required dependencies
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk git maven unzip curl && \
    apt-get clean

# Set Java environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH"
ENV GIT_REPO="https://github.com/ragothamang/sel-in-jenkins-docker-container-2025.git"

# Clone the repository inside the Jenkins container at build time
RUN git clone $GIT_REPO $WORK_DIR || (cd $WORK_DIR && git pull)

# Install Google Chrome and ChromeDriver for Selenium
RUN apt-get install -y wget && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get -fy install

RUN CHROME_DRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE) && \
    wget -N https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver

# Install Jenkins plugins
COPY jenkins-plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Create Jenkins job directory
VOLUME /var/jenkins_home

# Entrypoint script to initialize Jenkins
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
