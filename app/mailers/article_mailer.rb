class ArticleMailer < ApplicationMailer

  def send_email_to_client(email,recipient)
    @email = email
    unless email.nil?
      mail(to: recipient,content_type: "text/html", subject: "#{@email.subject}",body: @email.body)
    end
  end

end
