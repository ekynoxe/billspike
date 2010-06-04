class UserMailer < ActionMailer::Base
  def invitation(invite,share)
    recipients  [invite.recipient_email]

    from        "admin@ekynoxe.com"
    subject     "You have been invited to the share \"#{share.name}\""
    body        :invite=>invite, :share =>share
  end
  
  def payment_reminder(sender,u,share)
    recipients [u.email]
    
    from        sender.email
    subject     "Payment reminder for the share \"#{share.name}\""
    body        :current_user=>sender, :user=>u, :share =>share
  end
end
