class Api::Collectors::V1::Batch::TabelogResturantController < ApplicationController

        # GET /tabelog
        def create()
            puts 'create'
            crawl_restaurants()
        end

        def crawl_restaurants()
            @tabelog_uris = tabelog_uri.all
            uri = @tabelog_uris[0].area_uri
            restaurant_cnt = extract_area_restaurant_cnt(uri);
            restaurant_cnt_per_page = 20
            page_cnt = (restaurant_cnt_per_page / restaurant_cnt)
            for tabelog_uri in @tabelog_uris
                tabelog_uri.area_uri
                doc = Nokogiri::HTML(open(tabelog_uri.area_uri))
                restaurant_name = doc.css('.display-name').text.strip
                restaurant_rating_score = doc.css('.rdheader-rating__score-val-dtl').text
            end
            @restaurants_info = TabelogRestaurantInfo.new
        end

        def extract_area_restaurant_cnt

end
