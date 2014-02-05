class CardsController < ApplicationController
  def random
  	@size = params[:size] || 1
  	@word = Word.random @size
  end

  def right
    log_answer true
  	redirect_to random_cards_path(size: params[:size])
  end

  def wrong
    log_answer false
  	redirect_to random_cards_path(size: params[:size])
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
  end

end
