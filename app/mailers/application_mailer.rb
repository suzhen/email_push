class ApplicationMailer < ActionMailer::Base

  if Rails.env == "production"
    default from: "info@cbballiance.com.cn"
  else
    default from: "test@cbballiance.com.cn"
  end
  
  # layout 'mailer'
end
