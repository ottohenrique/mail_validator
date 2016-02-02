class ValidatorController < ApplicationController
  def index
  end

  def validate
    emails_list = params["email"]["list"]
    if emails_list.blank?
      flash["error"] = "Lista vazia, preencha com e-mails."
      render "index"
    else
      list = emails_list.split("\r\n")
      list.each do |email_name|
        v = email_name.match(/\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i).present?
        Email.create(name: email_name, email_valid: v)        
      end
      redirect_to "/validator/results"
    end
  end

  def results
    @emails = Email.all
  end

end
