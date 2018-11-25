class UserMailer < ApplicationMailer
  default from: "'Danya' <yarmolenko.dany@gmail.com>"
  layout 'mailer'

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/session/new'
    mail(to: @user.email, subject: 'Welcome to TODO LIST')
    # mg_client = Mailgun::Client.new ENV['api_key']
    # message_params = {:from    => ENV['gmail_username'],
    #                   :to      => @user.email,
    #                   :subject => 'Sample Mail using Mailgun API',
    #                   :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    # mg_client.send_message ENV['domain'], message_params
  end
end
