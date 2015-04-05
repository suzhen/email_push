class ApplicationMailer < ActionMailer::Base

  if Rails.env == "production"
    default from: "nandor_test@163.com"
    # default from: "newsletter@cbballiance.com"
  else
    default from: "nandor_test@163.com"
     # default from: "newsletter@cbballiance.com"
  end
  
  # layout 'mailer'
end
