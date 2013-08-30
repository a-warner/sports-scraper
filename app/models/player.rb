class Player < ActiveRecord::Base
  belongs_to :team
  attr_accessible :name, :url, :spin, :news, :outlook, :status, :status_description
  validates :name, :url, :team_id, presence: true
  validates :name, uniqueness: { scope: :name }

  has_many :player_depths

  scope :unscraped, -> { where(scraped: false) }

  scope :for_query, ->(query) do
    where("name like ?", "%#{query}%")
  end

  def status
    super || 'OK'
  end

  def status_ok?
    status == 'OK'
  end

  def short_status
    status[0].capitalize
  end
end
