namespace :scrape do
  desc 'scrape players'
  task :players, [:player_name] => [:environment] do |t, args|
    players = [Player.find_by_name!(args[:player_name])] if args[:player_name]
    players ||= Player.unscraped
    players.each do |player|
      puts "Scraping #{player.name}"
      player_page = Nokogiri::HTML(open(player.url))
      if fantasy_content_id = player_page.at_css("#fantasy-content")
        fantasy_content = JSON.parse(fantasy_content_id.text)
        player.news = fantasy_content["mostRecentNews"].try(:[], "news")
        player.spin = fantasy_content["mostRecentNews"].try(:[], "spin")
        player.outlook = fantasy_content["seasonOutlook"].try(:[], "outlook")
      end

      if player_status = player_page.at_css('#player-status-main')
        status_container = player_status.at_css('.player-status')

        player.status = status_container.text.try(:strip)
        player.status_description = status_container.try(:next).try(:text)
      end

      player.scraped = true
      player.save!
    end
  end
end
