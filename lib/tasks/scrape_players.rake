namespace :scrape do
  desc 'scrape players'
  task :players, [:player_name] => [:environment] do |t, args|
    players = [Player.find_by_name!(args[:player_name])] if args[:player_name]
    players ||= Player.unscraped

    queue = Queue.new
    players.each { |p| queue << p }

    mutex = Mutex.new

    workers = 5.times.map do
      Thread.new do
        while player = queue.pop(true) rescue nil
          begin
            player.scrape!(mutex)
          rescue StandardError => e
            print "Error scraping #{player.name}: #{e.inspect}\n"
          end
        end
      end
    end

    workers.each(&:join)

    puts "Done"
  end
end
