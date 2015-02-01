class ApplicationMailer < ActionMailer::Base

  if Rails.env == "production"
    default from: "newsletter@cbballiance.com"
  else
    default from: "nandor.email.test@gmail.com"
  end
  
  # layout 'mailer'
end
