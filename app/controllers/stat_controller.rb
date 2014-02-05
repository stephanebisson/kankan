class StatController < ApplicationController
  def index
  	@users = User.recent
  end
end
