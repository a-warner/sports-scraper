class PlayerDepth < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  belongs_to :position

  attr_accessible :depth
  validates :depth, presence: true, uniqueness: { scope: [:team, :position] }
end
