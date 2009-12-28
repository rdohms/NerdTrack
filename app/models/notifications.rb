class Notifications < ActionMailer::Base

  def contact(email_params)
    subject "[NerdTrack] " << email_params[:subject]
    recipients config_option(:contact_email).split(/, /)
    from email_params[:email]
    sent_on Time.now

    body :message => email_params[:body], :name => email_params[:name]
  end
  

end
