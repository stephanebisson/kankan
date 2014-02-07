class FeedbackMailer < ActionMailer::Base
  default from: "feedback@kankan.me"

  def feedback(feedback)
  	@feedback = feedback
    mail(to: 'stephane.c.bisson+kankan@gmail.com', subject: 'Feedback about Kan Kan')
  end
end
