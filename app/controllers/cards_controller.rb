class CardsController < ApplicationController
  def random
  	size = params[:size] || 1
  	right_size = Word.where(mandarin_length: size)
  	@word = right_size.skip(Random.rand(right_size.count)).first

  	@count = Word.count
  end

  def right
  	# log this 
  	redirect_to random_cards_path
  end

  def wrong
  	# log this 
  	redirect_to random_cards_path
  end

end
