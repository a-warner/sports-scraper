namespace :scrape do
  desc 'scrape teams'
  task :teams => [:environment] do
    teams_page = Nokogiri::HTML(open('http://espn.go.com/nfl/teams'))
    teams = teams_page.css('.bi').map { |a| [a.children.to_s, a.attributes["href"].value] }
    teams.each do |t|
      Team.find_or_create_by_name_and_url!(t.first, t.second)
    end
  end
end
