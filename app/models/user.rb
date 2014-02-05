class User
  include Mongoid::Document
  field :i, as: :ip_address, type: String
  field :d, as: :last_seen, type: DateTime
  embeds_many :answers

  def rights
  	answers.where(right: true).count
  end

  def wrongs
  	answers.where(right: false).count
  end

  def self.recent
  	order_by last_seen: :desc
  end

end
