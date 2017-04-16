class ApplicationMailer < ActionMailer::Base
  # default from: "me@sandbox475078ca8cac4522a053eb51e0dfca2d.com"
  # default from: ENV['PRODUCTION_EMAIL_USER']
  default from: ENV['EMAIL_FROM'] || 'from@example.com'
  layout 'mailer'
end
