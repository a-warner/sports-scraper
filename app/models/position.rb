class Position < ActiveRecord::Base
  attr_accessible :code
  validates :code, presence: true, uniqueness: true
  has_many :player_depths
end
