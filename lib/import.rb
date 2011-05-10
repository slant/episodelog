require 'nokogiri'
require 'open-uri'

module Import
  class Content

    def initialize
      @shows_created = 0
      @episodes_created = 0
    end


    def start
      puts # add a new line before beginning the import

      URLS.each do |url|
        doc = get_data(url)
        episodes = []

        name = doc.at_css(".title").text.strip
        short_name = url.gsub('http://www.tv.com/','').split('/')[0]

        # Ensure that show exists, if not, create it
        show = Show.where(:name => name, :short_name => short_name).first
        unless show
          show = Show.create(:name => name, :short_name => short_name)
          @shows_created = @shows_created + 1
        end

        printf "Importing #{show.name}... "

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
        new_episodes = episodes.reject { |e|
          (existing[:names].include? e.name and existing[:seasons].include? e.season and existing[:episodes].include? e.episode) or e.name == ''
        }

        show.episodes << new_episodes

        # increment the number of new episodes created
        @episodes_created = @episodes_created + new_episodes.size

        printf "#{new_episodes.size} of #{episodes.size} imported\n"
      end

      puts 
      puts "#{@shows_created > 0 ? @shows_created : "0"} new shows and #{@episodes_created > 0 ? @episodes_created : "0"} new episodes were created"
    end


    def get_data(url)
      Nokogiri::HTML(open(url))
    end

  end
end