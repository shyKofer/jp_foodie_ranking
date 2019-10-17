require 'nokogiri'
require 'open-uri'

class Api::Collectors::V1::Batch::TabelogController < ApplicationController
    # GET /tabelog
    def index()
        puts 'xxxxxx'
        collectTabelogURI()
        # Model
        # @restaurants =  TabelogRestaurant.all
        # render json: @restaurants
    end

    def crawlTabelogRestaurants()
        # TabelogRestaurantInfo
        @restaurants_info = TabelogRestaurantInfo.new
        # prefecture
        # restaurants_name
        # district
        # rating
        # reviews
        #TabelogRestaurantInfo
        doc = Nokogiri::HTML(open('https://tabelog.com/tokyo/A1301/A130103/13220829/'))
        restaurant_name = doc.css('.display-name').text.strip
        restaurant_rating_score = doc.css('.rdheader-rating__score-val-dtl').text
    end

    def collectTabelogURI()
        for i in 1..31 do
            uri_postfix_no = (1300 + i).to_s
            uri_area = 'A' + uri_postfix_no
            getAreaUriInfo(uri_area);
        end
        # tokyo uri : tokyo/A1301 ~ tokyo/A1331
        # 丸の内・大手町
        # https://tabelog.com/tokyo/A1302/A130201/
    end

    def getAreaUriInfo(area_group_uri)
        tabelog_url = 'https://tabelog.com/tokyo/' + area_group_uri
        puts "URL : #{tabelog_url}"

        doc = Nokogiri::HTML(open(tabelog_url))
        area_count = doc.css('.list-balloon__list-item a').count
        puts "area_count : #{area_count}"

        for i in 0..area_count-1 do
            puts "Loop Count i : #{i}"
            @tabelogUri = TabelogUri.new
            @tabelogUri.prefecture = 'tokyo'
            @tabelogUri.area_group_uri = area_group_uri
            #@tabelogUri.area_group_name = doc.css('.c-link-arrow span')[i+1].text
            @tabelogUri.area_uri = doc.css('.list-balloon__list-item a')[i]['href'].strip
            @tabelogUri.area_name = doc.css('.c-link-arrow span')[i+1].text
            sleep 1
            @tabelogUri.save
            puts "Insert OK"
        end
    end

end