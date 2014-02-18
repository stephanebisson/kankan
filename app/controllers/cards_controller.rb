class CardsController < ApplicationController
  def random
    redirect_to card_path(Word.random)
  end

  def show
    @word = Word.find params[:id]
    @type = @word.word_types.order(frequency: 'DESC').first  
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

  	redirect_to random_cards_path
  end

end
