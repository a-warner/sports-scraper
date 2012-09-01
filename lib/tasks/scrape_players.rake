namespace :scrape do
  desc 'scrape players'
  task :players, [:player_name] => [:environment] do |t, args|
    players = [Player.find_by_name!(args[:player_name])] if args[:player_name]
    players ||= Player.unscraped
    players.each do |player|
      puts "Scraping #{player.name}"
      player_page = Nokogiri::HTML(open(player.url))
      fantasy_content = JSON.parse(player_page.at_css("#fantasy-content").text)
      player.update_attributes!(news: fantasy_content["mostRecentNews"].try(:[], "news"),
                               spin: fantasy_content["mostRecentNews"].try(:[], "spin"),
                               outlook: fantasy_content["seasonOutlook"].try(:[], "outlook"))
    end
  end
end
