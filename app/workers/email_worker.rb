class EmailWorker
  include Sidekiq::Worker

  def perform(email_id)
    email = Email.find email_id
    email.receivers.each  do |receiver| 
      ArticleMailer.send_email_to_client(email,receiver).deliver
    end 
    ActiveRecord::Base.clear_active_connections!
  end

end