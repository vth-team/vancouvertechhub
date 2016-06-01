ActionMailer::Base.smtp_settings = {
  address:              "smtp.sendgrid.net",
  port:                 "587",
  enable_starttls_auto: true,
  authentication:       :plain,
  user_name:            ENV["EMAIL_USER_NAME"],
  password:             ENV["EMAIL_PASSWORD"]
}
