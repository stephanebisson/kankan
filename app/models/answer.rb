class Answer
  include Mongoid::Document
  field :c, as: :character, type: String
  field :a, as: :right, type: Boolean
  field :d, as: :when, type: DateTime
  embedded_in :user
end
