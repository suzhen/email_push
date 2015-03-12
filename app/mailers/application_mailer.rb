class ApplicationMailer < ActionMailer::Base

  if Rails.env == "production"
    default from: "newsletter@cbballiance.com"
  else
    # default from: "nandor.email.test@gmail.com"
     default from: "newsletter@cbballiance.com"
  end
  
  # layout 'mailer'
end
