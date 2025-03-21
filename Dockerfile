FROM jenkins/jenkins:lts

# Switch to root user to install dependencies
USER root

# Install Java, Maven, Git, and required dependencies
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk git maven unzip curl wget && \
    rm -rf /var/lib/apt/lists/*

# Set Java environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH"

# Install Google Chrome and ChromeDriver for Selenium
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get -fy install && \
    rm google-chrome-stable_current_amd64.deb

# Install ChromeDriver
RUN CHROME_DRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE) && \
    wget -N https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip

# Install Jenkins plugins
COPY jenkins-plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Ensure Jenkins user owns its home directory
RUN chown -R jenkins:jenkins /var/jenkins_home

# Copy entrypoint script (will handle cloning at runtime)
COPY entrypoint.sh /entrypoint.sh
RUN chown root:root /entrypoint.sh && chmod +x /entrypoint.sh

# Switch to Jenkins user
USER jenkins

# Set working directory
WORKDIR /var/jenkins_home


# Entrypoint script to initialize Jenkins
ENTRYPOINT ["/entrypoint.sh"]
