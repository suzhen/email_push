class ApplicationMailer < ActionMailer::Base

  if Rails.env == "production"
    default from: "nandor_test@163.com"
  else
    default from: "nandor.email.test@gmail.com"
  end
  
  # layout 'mailer'
end
