# Sports scraper

Scrapes ESPN for fantasy content and allows quick access with a web UI.  ESPN's search is too slow for quick lookups during the draft.

## Setup

    bundle
    rake db:create && rake db:migrate && rake db:seed && rake scrape:all

## Disclaimer

I wrote this quickly and as such it's a little quick and dirty - there are probably better ways to do what I did. It won't scale blah blah blah.
