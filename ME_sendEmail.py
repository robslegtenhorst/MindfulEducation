import smtplib
from email.message import EmailMessage

fromaddr = "rob@mindful-education.co.uk"
toaddr = "robslegtenhorst@gmail.com"
msg = EmailMessage()
msg['From'] = fromaddr
msg['To'] = toaddr
msg['Subject'] = "Test Mail"

msg.set_content("Test mail from python")

server = smtplib.SMTP('smtp.office365.com', 587)
server.connect('smtp.office365.com',587)
server.ehlo()
server.starttls()
server.ehlo()

#Next, log in to the server
server.login("rob@mindful-education.co.uk", "bGr-bJR-xfa-6CQ")

#Send the mail
text = msg.as_string()
server.sendmail(fromaddr, toaddr, text)
server.quit()
