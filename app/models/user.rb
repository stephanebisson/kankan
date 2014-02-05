class User
  include Mongoid::Document
  field :i, as: :ip_address, type: String
  embeds_many :answers
end
