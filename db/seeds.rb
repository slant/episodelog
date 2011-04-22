# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'nokogiri'
require 'open-uri'

# url = "http://www.tv.com/the-x-files/show/61/episode.html?shv=guide&season=All"
urls = [
  'http://www.tv.com/doctor-who/show/34391/episode.html?season=All', # Doctor Who
  'http://www.tv.com/firefly/show/7097/episode.html?season=All', # Firefly
  'http://www.tv.com/greys-anatomy/show/24440/episode.html?season=All', # Grey's Anatomy
  'http://www.tv.com/lost/show/24313/episode.html?season=All', # Lost
  'http://www.tv.com/star-trek-the-next-generation/show/137/episode.html?season=All', # Star Trek: The Next Generation
  'http://www.tv.com/the-x-files/show/61/episode.html?season=All' # The X-Files
]

urls.each do |url|
  doc = Nokogiri::HTML(open(url))
  episodes = []

  name = doc.at_css(".title").text.strip
  short_name = url.gsub('http://www.tv.com/','').split('/')[0]

  # Ensure that show exists, if not, create it
  show = Show.where(:name => name, :short_name => short_name).first || Show.create(:name => name, :short_name => short_name)
  puts "Importing #{show.name}"

  if show
    doc.css("#episode_guide_list .episode").each do |item|
      episode = {}
      episode[:name] = item.at_css("h3").text.strip
      # episode[:tv_com_url] = item.at_css("h3 a")['href'] # url to episode at tv.com

      synopsis = item.at_css(".synopsis").text.strip
      episode[:synopsis] = (synopsis == "No synopsis available. Write a synopsis." ? '' : synopsis)
      
      meta = item.at_css(".info .meta").text.gsub(/\s+/, ' ').strip

      air_date = /Aired: \d+\/\d+\/\d{4}/.match(meta)
      episode[:air_date] = air_date.to_a.any? ? Date.strptime(air_date[0].gsub('Aired: ',''), '%m/%d/%Y') : nil

      season = /Season \d+/.match(meta)
      episode[:season] = season.to_a.any? ? season[0].gsub('Season ','') : nil

      episode_number = /Episode \d+/.match(meta)
      episode[:episode] = episode_number.to_a.any? ? episode_number[0].gsub('Episode ','') : nil

      episodes << Episode.new(episode)
    end
  end

  existing = {}
  existing_episodes = show.episodes
  existing[:names] = existing_episodes.collect(&:name)
  existing[:seasons] = existing_episodes.collect(&:season)
  existing[:episodes] = existing_episodes.collect(&:episode)

  # Prevent duplicate show-specific episodes from being created
  episodes.reject! { |e| existing[:names].include? e.name and existing[:seasons].include? e.season and existing[:episodes].include? e.episode }

  show.episodes << episodes
end