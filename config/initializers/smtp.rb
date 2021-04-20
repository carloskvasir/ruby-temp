#if you are using the API key
ActionMailer::Base.smtp_settings = {
  domain: 'carloskvasir.me',
  address: "smtp.sendgrid.net",
  port: 587,
  authentication: :plain,
  user_name: 'PIJAhWhQQEGV962p-vDi1A',
  password: ENV['SENDGRID_API_KEY']
}
