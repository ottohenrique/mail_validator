class ValidatorController < ApplicationController
  def index
  end

  def validate
    if  emails_params['list'].blank? && emails_params['file'].blank?
      flash[:error] = 'Necessário passar uma lista de e-mails!'
      render 'index'
    else
      file = emails_params['file']

      File.open(Rails.root.join('public', 'uploads', file.original_filename), 'wb') do |f|
        f.write(file.read)
      end

      render 'results'
    end
  end

  def results
  end

  private
  def emails_params
    params['email']
  end
end
