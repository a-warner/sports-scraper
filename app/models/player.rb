class Player < ActiveRecord::Base
  belongs_to :team
  attr_accessible :name, :url, :spin, :news, :outlook
  validates :name, :url, :team_id, presence: true
  validates :name, uniqueness: { scope: :name }

  has_many :player_depths

  scope :unscraped, where("news is null")
end
