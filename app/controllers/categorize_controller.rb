class CategorizeController < ApplicationController
  def next
  	@word = Word.random_uncategorized
  end

  def choose
  	word = Word.find params[:id]
  	level = params[:level]
  	word.vote_level level
  	word.save!
  	redirect_to next_categorize_index_path
  end

  def wrong
  	word = Word.find params[:id]
  	word.vote_wrong
  	word.save!
  	redirect_to next_categorize_index_path
  end
end
