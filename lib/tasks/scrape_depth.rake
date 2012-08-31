namespace :scrape do
  desc 'scrape depth chart'
  task :depth, [:team_name] => [:environment] do |t, args|
    if team_name = args[:team_name]
      teams_to_scrape = [Team.find_by_name!(team_name)]
      puts "Scraping #{team_name}"
    else
      teams_to_scrape = Team.all
      puts "Scraping all teams"
    end

    teams_to_scrape.each do |t|
      depth_page = Nokogiri::HTML(open(t.depth_chart_uri))

      wr_num = 1
      mappings = (depth_page.css('tr.oddrow') + depth_page.css("tr.evenrow")).inject({}) do |h, tr|
        tds = tr.css("td")
        position_code = tds.shift.text
        (position_code += wr_num.to_s) && (wr_num += 1) if position_code == "WR"
        h[position_code] = tds
        h
      end.select { |k| Set.new(Position.pluck(:code)).include?(k) }

      mappings.each do |code, tds|
        depth = 1
        tds.css('a').map do |a|
          player = t.players.find_or_create_by_name_and_url(a.text, a.attributes["href"].value)
          t.player_depths.find_or_create_by_player_id_and_position_id_and_depth(player.id, Position.find_by_code!(code).id, depth)
          depth += 1
        end
      end
    end
  end
end
