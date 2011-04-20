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
  'http://www.tv.com/the-x-files/show/61/episode.html?season=All',
  'http://www.tv.com/greys-anatomy/show/24440/episode.html?season=All',
  'http://www.tv.com/star-trek-the-next-generation/show/137/episode.html?season=All'
]

urls.each do |url|
  doc = Nokogiri::HTML(open(url))

  name = doc.at_css(".title").text.strip
  short_name = url.gsub('http://www.tv.com/','').split('/')[0]
  show = Show.create( :name => name, :short_name => short_name )

  if show
    doc.css("#episode_guide_list .episode").each do |item|
      episode = {}
      episode[:name] = item.at_css("h3").text.strip
      # episode[:url] = item.at_css("h3 a")['href']
      episode[:synopsis] = item.at_css(".synopsis").text.strip

      # meta
      meta = item.at_css(".info .meta").text.gsub(/\s+/, ' ')
      episode[:air_date] = meta.gsub(/.+Aired: (\d+\/\d+\/\d{4})/, '\1').strip
      episode[:season] = meta.gsub(/.+Season (\d+).+/,'\1').strip
      episode[:episode] = meta.gsub(/.+Episode (\d+).+/,'\1').strip

      show.episodes << Episode.create(episode)
    end
  end
end