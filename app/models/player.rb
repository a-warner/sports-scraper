class Player < ActiveRecord::Base
  belongs_to :team
  attr_accessible :name, :url
  validates :name, :url, :team_id, presence: true
  validates :name, uniqueness: { scope: :name }

  has_many :player_depths
end
