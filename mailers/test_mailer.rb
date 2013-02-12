require 'action_mailer'
class SimpleMailer < ActionMailer::Base
  def simple_message(recipient)
    from 'leonardr@example.org'
    recipients recipient
    subject 'A single-part message for you'
    body 'This message has a plain text body.'
  end
end

puts SimpleMailer.create_simple_message("l@m.fr")
