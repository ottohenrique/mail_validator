require 'resolv'
require 'net/smtp'

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
        domain = email_name.split('@').last
        v = email_name.match(/\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i).present?
        v = v && dns_valid(domain).present?
        Email.create(name: email_name, email_valid: v)
      end
      redirect_to "/validator/results"
    end
  end

  def results
    @emails = Email.all
  end

  def dns_valid(domain)
    dns = Resolv::DNS.new

    mx_records = dns.getresources domain, Resolv::DNS::Resource::IN::MX
    if mx_records.any?
      mx_server  = mx_records.first.exchange.to_s
    else
      return false
    end

    Net::SMTP.start mx_server, 25 do |smtp|
      smtp.helo "loldomain.com"
    end

  end

end
