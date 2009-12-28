class Notifications < ActionMailer::Base

  def contact(email_params)
    subject "[NerdTrack] " << email_params[:subject]
    recipients "rafael@rafaeldohms.com.br" # Replace with your address
    #from email_params[:email]
    from "rdohms@gmail.com"
    sent_on Time.now.utc

    body :message => email_params[:body], :name => email_params[:name]
  end
  

end
