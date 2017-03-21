class ApplicationMailer < ActionMailer::Base
  default from: 'from@.env.example.com'
  layout 'mailer'
end
