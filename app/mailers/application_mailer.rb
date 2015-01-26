class ApplicationMailer < ActionMailer::Base

  if Rails.env == "production"
    # default from: "info@cbballiance.com"
    default from: "nandor.email.test@gmail.com"
  else
    default from: "nandor.email.test@gmail.com"
  end
  
  # layout 'mailer'
end
