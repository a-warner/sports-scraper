class Team < ActiveRecord::Base
  attr_accessible :name, :url
  validates :name, :url, presence: true
  validates :name, uniqueness: { scope: :name }
  has_many :players
  has_many :player_depths

  default_scope order(:name)

  scope :for_query, ->(query) do
    where("name like ?", "%#{query}%")
  end

  def depth_chart_uri
    url.gsub("team","team/depth")
  end
end
