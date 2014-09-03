namespace :scrape do
  task :all => [:environment, 'db:migrate', 'db:seed', :teams, :depth, :players]
end
