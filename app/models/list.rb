class List
  include Mongoid::Document
  field :name, type: String
  field :level, type: Integer
  has_and_belongs_to_many :words, inverse_of: nil
end
