class Feedback
  include Mongoid::Document
  field :comment, type: String
  field :email, type: String
  field :rating, type: Integer

  after_create :send_email

  protected
  def send_email
  	FeedbackMailer.feedback(self).deliver
  end
end
