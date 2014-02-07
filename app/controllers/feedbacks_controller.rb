class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    Feedback.create feedback_params
    redirect_to root_path, notice: 'Thanks for letting us know!'
  end

  private
    def feedback_params
      params.require(:feedback).permit(:comment, :email, :rating)
    end
end
