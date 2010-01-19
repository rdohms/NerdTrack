class NerdtrackController < ApplicationController
  def sobre
    respond_to do |format|
      format.html # sobre.html.erb
    end
  end

  def equipe
    respond_to do |format|
      format.html # equipe.html.erb
    end
  end

  def contato
    respond_to do |format|
      format.html # contato.html.erb
    end
  end

  def sendmail
    if Notifications.deliver_contact(params[:contato])
       flash[:notice] = "Email enviado com sucesso!"
       redirect_to(:back)
     else
       flash.now[:error] = "Erro ao enviar email!"
       render :contato
     end

  end
end
