class Team < ActiveRecord::Base
  attr_accessible :name, :url
  validates :name, :url, presence: true
  validates :name, uniqueness: { scope: :name }
  has_many :players
  has_many :player_depths

  def depth_chart_uri
    url.gsub("team","team/depth")
  end
end
