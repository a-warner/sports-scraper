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

  def scrape!(db_monitor = nil)
    print "Scraping #{name}\n"
    player_page = Nokogiri::HTML(open(url))
    if fantasy_content_id = player_page.at_css("#fantasy-content")
      fantasy_content = JSON.parse(fantasy_content_id.text)

      self.news = fantasy_content["mostRecentNews"].try(:[], "news")
      self.spin = fantasy_content["mostRecentNews"].try(:[], "spin")
      self.outlook = fantasy_content["seasonOutlook"].try(:[], "outlook")
    end

    if player_status = player_page.at_css('#player-status-main')
      status_container = player_status.at_css('.player-status')

      self.status = status_container.text.try(:strip).try(:capitalize)
      self.status_description = status_container.try(:next).try(:text)
    end

    self.scraped = true

    if db_monitor
      db_monitor.synchronize { save! }
    else
      save!
    end
  end
end
