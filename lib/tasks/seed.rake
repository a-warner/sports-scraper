namespace :db do
  task :seed do
    ['WR1', 'WR2', 'RB', 'TE', 'QB', 'FB'].each do |code|
      Position.find_or_create_by_code! code
    end
  end
end
