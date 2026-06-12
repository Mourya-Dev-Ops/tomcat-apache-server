# Complete Manual Java + Maven + Tomcat WAR Deployment Guide (EC2 Ubuntu)

## Architecture

```text
Developer
    │
    ▼
Git Repository
    │
    ▼
Application Source Code
    │
    ▼
Maven Build
    │
    ▼
WAR File
    │
    ▼
Tomcat Webapps
    │
    ▼
Browser
```

---

# Step 1: Launch EC2 Instance

Connect to EC2:

```bash
ssh -i nginx-key.pem ubuntu@<PUBLIC-IP>
```

Become root:

```bash
sudo su -
```

Verify:

```bash
whoami
```

Expected:

```text
root
```

---

# Step 2: Update Server

```bash
apt update
apt upgrade -y
```

---

# Step 3: Install Java 17

Install OpenJDK:

```bash
apt install openjdk-17-jdk -y
```

Verify Java:

```bash
java -version
```

Expected:

```text
openjdk version "17.x.x"
```

Verify compiler:

```bash
javac -version
```

Expected:

```text
javac 17.x.x
```

---

# Step 4: Find Java Installation Path

Find Java executable:

```bash
readlink -f $(which java)
```

Example Output:

```text
/usr/lib/jvm/java-17-openjdk-amd64/bin/java
```

Java Home:

```text
/usr/lib/jvm/java-17-openjdk-amd64
```

Verify:

```bash
ls /usr/lib/jvm/
```

Expected:

```text
java-17-openjdk-amd64
```

---

# Step 5: Configure JAVA_HOME

Open environment file:

```bash
nano /etc/environment
```

Add:

```text
JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
```

Save:

```text
CTRL + O
ENTER
CTRL + X
```

Reload:

```bash
source /etc/environment
```

Verify:

```bash
echo $JAVA_HOME
```

Expected:

```text
/usr/lib/jvm/java-17-openjdk-amd64
```

---

# Step 6: Install Maven

Install Maven:

```bash
apt install maven -y
```

Verify:

```bash
mvn --version
```

Expected:

```text
Apache Maven 3.x.x
Java version: 17
```

Find Maven Path:

```bash
which mvn
```

Example:

```text
/usr/bin/mvn
```

Maven Files:

```bash
ls /usr/share/maven
```

---

# Step 7: Move to /opt Directory

```bash
cd /opt
```

Why?

```text
/opt = Optional Third-Party Software

Common installations:

/opt/apache-tomcat
/opt/jenkins
/opt/sonarqube
/opt/nexus
```

---

# Step 8: Download Tomcat

Move to /opt:

```bash
cd /opt
```

Download:

```bash
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.118/bin/apache-tomcat-9.0.118.tar.gz
```

Verify:

```bash
ls
```

Expected:

```text
apache-tomcat-9.0.118.tar.gz
```

---

# Step 9: Extract Tomcat

```bash
tar -xvzf apache-tomcat-9.0.118.tar.gz
```

Verify:

```bash
ls
```

Expected:

```text
apache-tomcat-9.0.118
```

---

# Step 10: Understand Tomcat Structure

Move:

```bash
cd /opt/apache-tomcat-9.0.118
```

Check:

```bash
ls
```

Expected:

```text
bin
conf
lib
logs
temp
webapps
work
```

### Important Directories

#### bin

```text
startup.sh
shutdown.sh
```

#### conf

```text
server.xml
tomcat-users.xml
```

#### logs

```text
Tomcat Logs
```

#### webapps

```text
WAR files go here
```

---

# Step 11: Start Tomcat

Move:

```bash
cd /opt/apache-tomcat-9.0.118/bin
```

Start:

```bash
./startup.sh
```

Verify:

```bash
ps -ef | grep tomcat
```

Check Browser:

```text
http://<PUBLIC-IP>:8080
```

---

# Step 12: Open Security Group Ports

Inbound Rules:

```text
22    SSH
80    HTTP
443   HTTPS
8080  Custom TCP
```

Source:

```text
0.0.0.0/0
```

---

# Step 13: Clone Application Repository

Move:

```bash
cd /opt
```

Clone:

```bash
git clone https://github.com/Mourya-Dev-Ops/tomcat-apache-server.git
```

Move:

```bash
cd tomcat-apache-server
```

Verify:

```bash
ls
```

Expected:

```text
README.md
pom.xml
src
```

---

# Step 14: Build WAR File

Run:

```bash
mvn clean package
```

Expected:

```text
BUILD SUCCESS
```

---

# Step 15: Verify WAR File

```bash
ls target
```

Expected:

```text
DevOps-CICD-war-0.1.war
```

---

# Step 16: Deploy WAR to Tomcat

Copy WAR:

```bash
cp target/DevOps-CICD-war-0.1.war /opt/apache-tomcat-9.0.118/webapps/
```

Verify:

```bash
ls /opt/apache-tomcat-9.0.118/webapps
```

Expected:

```text
DevOps-CICD-war-0.1.war
```

---

# Step 17: Restart Tomcat

Move:

```bash
cd /opt/apache-tomcat-9.0.118/bin
```

Stop:

```bash
./shutdown.sh
```

Start:

```bash
./startup.sh
```

---

# Step 18: Verify Deployment

Tomcat automatically extracts:

```text
webapps/
├── DevOps-CICD-war-0.1.war
└── DevOps-CICD-war-0.1/
```

Verify:

```bash
ls /opt/apache-tomcat-9.0.118/webapps
```

Expected:

```text
DevOps-CICD-war-0.1
DevOps-CICD-war-0.1.war
```

---

# Step 19: Access Application

Open:

```text
http://<PUBLIC-IP>:8080/DevOps-CICD-war-0.1/
```

Expected:

```text
Application Page Loads Successfully
```

---

# Final Directory Structure

```text
/
├── etc
│   └── environment
│
├── usr
│   └── lib
│       └── jvm
│           └── java-17-openjdk-amd64
│
├── usr
│   └── share
│       └── maven
│
└── opt
    ├── apache-tomcat-9.0.118
    │    ├── bin
    │    ├── conf
    │    ├── logs
    │    ├── temp
    │    ├── webapps
    │    └── work
    │
    └── tomcat-apache-server
         ├── README.md
         ├── pom.xml
         ├── src
         └── target
              └── DevOps-CICD-war-0.1.war
```

---

# End-to-End Flow

```text
Git Repository
      │
      ▼
Clone Source Code
      │
      ▼
Maven Build
      │
      ▼
WAR Artifact
      │
      ▼
Copy to Tomcat Webapps
      │
      ▼
Tomcat Extracts WAR
      │
      ▼
Application Becomes Live
      │
      ▼
Access Through Browser
```





# Jenkins CI/CD Pipeline for Apache Tomcat WAR Deployment

## Project Architecture

```text
GitHub Repository
        │
        ▼
Jenkins EC2 Server
        │
        ▼
Maven Build
        │
        ▼
WAR File Creation
        │
        ▼
SSH / SCP
        │
        ▼
Tomcat EC2 Server
        │
        ▼
Apache Tomcat Deployment
```

---

# Phase 1: Create Jenkins EC2 Instance

Launch a new Ubuntu EC2 instance.

Recommended:

```text
AMI        : Ubuntu 26.04 LTS
Instance   : t2.micro
Storage    : 8 GB
```

Security Group:

```text
22   SSH
8080 Jenkins
```

---

# Phase 2: Connect to Jenkins Server

From local machine:

```bash
ssh -i jenkins-key.pem ubuntu@<JENKINS_PUBLIC_IP>
```

Switch to root:

```bash
sudo -i
```

Verify:

```bash
whoami
```

Expected:

```text
root
```

---

# Phase 3: Install Java 21

Update packages:

```bash
apt update
```

Install OpenJDK 21:

```bash
apt install openjdk-21-jdk -y
```

Verify:

```bash
java -version
```

Expected:

```text
openjdk version "21"
```

Why?

```text
Latest Jenkins requires Java 21.
Java 17 causes Jenkins startup failure.
```

---

# Phase 4: Install Jenkins Repository

Add Jenkins Key:

```bash
wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
```

Add Repository:

```bash
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" \
> /etc/apt/sources.list.d/jenkins.list
```

Update:

```bash
apt update
```

Install Jenkins:

```bash
apt install jenkins -y
```

---

# Phase 5: Start Jenkins

Enable service:

```bash
systemctl enable jenkins
```

Start service:

```bash
systemctl start jenkins
```

Check status:

```bash
systemctl status jenkins
```

Expected:

```text
active (running)
```

---

# Phase 6: Get Jenkins Initial Password

```bash
cat /var/lib/jenkins/secrets/initialAdminPassword
```

Copy the password.

Open:

```text
http://<JENKINS_PUBLIC_IP>:8080
```

Paste password.

Install suggested plugins.

Create admin user.

---

# Phase 7: Install Maven

```bash
apt install maven -y
```

Verify:

```bash
mvn --version
```

Expected:

```text
Apache Maven 3.x
Java version: 21
```

Why?

```text
Maven builds Java applications and creates WAR files.
```

---

# Phase 8: Install Git

```bash
apt install git -y
```

Verify:

```bash
git --version
```

Expected:

```text
git version 2.x
```

Why?

```text
Jenkins pulls source code from GitHub.
```

---

# Phase 9: Create Jenkins Job

Dashboard:

```text
New Item
```

Choose:

```text
Freestyle Project
```

Name:

```text
tomcat-apache-server
```

---

# Phase 10: Configure Git Repository

Git URL:

```text
https://github.com/Mourya-Dev-Ops/tomcat-apache-server.git
```

Branch:

```text
*/main
```

Why?

```text
Repository branch is main.
master causes clone failures.
```

---

# Phase 11: Configure Maven Build

Build Step:

```text
Invoke top-level Maven targets
```

Goals:

```text
clean package
```

Why?

```text
clean   → removes old builds
package → creates WAR file
```

Save.

---

# Phase 12: Build Project

Click:

```text
Build Now
```

Verify:

```text
Build History
```

Open Console Output.

Expected:

```text
BUILD SUCCESS
```

---

# Phase 13: Verify WAR File

Login Jenkins Server:

```bash
sudo su - jenkins
```

Go to workspace:

```bash
cd /var/lib/jenkins/workspace/tomcat-apache-server/target
```

Check WAR:

```bash
ls
```

Expected:

```text
DevOps-CICD-war-0.1.war
```

Absolute Path:

```bash
realpath DevOps-CICD-war-0.1.war
```

Example:

```bash
/var/lib/jenkins/workspace/tomcat-apache-server/target/DevOps-CICD-war-0.1.war
```

---

# Phase 14: Generate Jenkins SSH Key

Switch to Jenkins user:

```bash
sudo su - jenkins
```

Generate Key:

```bash
ssh-keygen -t ed25519 -C "jenkins@ec2"
```

Accept defaults.

Verify:

```bash
ls ~/.ssh
```

Expected:

```text
id_ed25519
id_ed25519.pub
```

View Public Key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Example:

```text
ssh-ed25519 AAAA..... jenkins@ec2
```

Why?

```text
Jenkins must SSH into Tomcat server automatically.
```

---

# Phase 15: Configure SSH Trust

Login to Tomcat Server:

```bash
ssh -i nginx-key.pem ubuntu@<TOMCAT_PUBLIC_IP>
```

Become root:

```bash
sudo -i
```

Open:

```bash
nano ~/.ssh/authorized_keys
```

Paste Jenkins Public Key.

Example:

```text
ssh-ed25519 AAAA..... jenkins@ec2
```

Save.

Fix permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

---

# Phase 16: Test SSH

From Jenkins:

```bash
ssh root@<TOMCAT_PUBLIC_IP>
```

Expected:

```text
root@ip-xxx-xxx-xxx#
```

No password should be requested.

Why?

```text
SSH key authentication is working.
```

---

# Phase 17: Copy WAR to Tomcat

From Jenkins:

```bash
scp /var/lib/jenkins/workspace/tomcat-apache-server/target/DevOps-CICD-war-0.1.war \
root@<TOMCAT_PUBLIC_IP>:/tmp/
```

Verify on Tomcat:

```bash
ls -lh /tmp/*.war
```

Expected:

```text
DevOps-CICD-war-0.1.war
```

---

# Phase 18: Deploy WAR

Copy:

```bash
cp /tmp/DevOps-CICD-war-0.1.war \
/opt/apache-tomcat-9.0.118/webapps/
```

Verify:

```bash
ls /opt/apache-tomcat-9.0.118/webapps
```

Expected:

```text
DevOps-CICD-war-0.1
DevOps-CICD-war-0.1.war
```

Why?

```text
Tomcat automatically extracts WAR files.
```

---

# Phase 19: Verify Deployment

Check logs:

```bash
tail -50 /opt/apache-tomcat-9.0.118/logs/catalina.out
```

Expected:

```text
Deploying web application archive
Deployment finished
```

---

# Phase 20: Access Application

Browser:

```text
http://<TOMCAT_PUBLIC_IP>:8080/DevOps-CICD-war-0.1
```

Expected:

```text
Welcome DevOps CICD Flow Youtube Channel
```

---

# Final Flow

```text
Developer
    │
    ▼
GitHub
    │
    ▼
Jenkins
    │
    ▼
Git Clone
    │
    ▼
Maven Build
    │
    ▼
WAR File
    │
    ▼
SSH/SCP
    │
    ▼
Tomcat
    │
    ▼
Application Deployment
```
