class Notifications < ActionMailer::Base

  def contact(email_params)
    subject "[NerdTrack] " << email_params[:subject]
    recipients CONTATO_EMAIL
    from email_params[:email]
    sent_on Time.now.utc

    body :message => email_params[:body], :name => email_params[:name]
  end
  

end
