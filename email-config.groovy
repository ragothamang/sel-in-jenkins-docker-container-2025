import jenkins.model.*
import hudson.tasks.Mailer

def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()
jenkinsLocationConfiguration.setAdminAddress("admin@example.com")
jenkinsLocationConfiguration.save()

def mailer = Mailer.descriptor()
mailer.setSmtpServer("smtp.gmail.com")
mailer.setSmtpAuth(true)
mailer.setSmtpPort("587")
mailer.setUseSsl(false)
mailer.setCharset("UTF-8")
mailer.setReplyToAddress("your-email@gmail.com")
mailer.setCredentialsId("your-credentials-id")
mailer.save()