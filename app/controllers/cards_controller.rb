class CardsController < ApplicationController
  def random
  	@size = params[:size] || 1
    @level = params[:level]
  	@word = Word.random @size, @level
  end

  def right
    log_answer true
  end

  def wrong
    log_answer false
  end

  private

  def log_answer(right)
    ip = request.remote_ip
    character = params[:id]
    now = DateTime.now

    user = User.find_or_create_by! ip_address: ip
    user.answers.create! character: character, right: right, when: now
    user.last_seen = now
    user.save!

  	redirect_to random_cards_path(size: params[:size], level: params[:level])
  end

end
