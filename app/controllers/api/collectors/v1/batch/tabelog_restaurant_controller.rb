class Api::Collectors::V1::Batch::TabelogRestaurantController < ApplicationController

    # api/collectors/v1/batch/tabelog_restaurant
    # Method : POST
    def create()
        logger.debug("Start")
        crawl_tabelog_restaurants()
        logger.debug("End")
    end

    def crawl_tabelog_restaurants()
        @tabelog_uris = TabelogUri.all
        for tabelog_uri in @tabelog_uris
            crawling_uri = tabelog_uri.area_uri
            logger.debug("crawling_uri:#{crawling_uri}")
            crawling_page_cnt = get_page_cnt(crawling_uri)
            logger.debug("crawling_page_cnt:#{crawling_page_cnt}")
            save_restaurants(crawling_uri, crawling_page_cnt)
        end
    end

    # エリアのレストランの件数を取得
    def crawl_area_restaurant_cnt(uri)
        dom = Nokogiri::HTML(open(uri))
        return Integer(dom.css(".c-page-count__num")[2].text)
    end

    # ページ数を取得
    def get_page_cnt(crawling_uri)
        restaurant_cnt = crawl_area_restaurant_cnt(crawling_uri)
        logger.debug("restaurant_cnt:#{restaurant_cnt}")
        max_posting_cnt_per_page = 20
        page_cnt = restaurant_cnt / max_posting_cnt_per_page
        page_cnt += (restaurant_cnt % max_posting_cnt_per_page) > 0 ? 1 : 0
        return page_cnt >= 60 ? 60 : page_cnt
    end

    # 1ページ当りレストラン数を取得
    def get_posting_cnt_per_page(posting_no_range_dom)
        posting_cnt_from = Integer(posting_no_range_dom[0].text)
        posting_cnt_to   = Integer(posting_no_range_dom[1].text)
        logger.debug("posting_cnt_from:#{posting_cnt_from}")
        logger.debug("posting_cnt_to:#{posting_cnt_to}")
        return (posting_cnt_to - posting_cnt_from) + 1
    end

    # レストラン情報をクローリングしてDBに保存
    def save_restaurants(uri, crawling_page_cnt)
        for page in (1..crawling_page_cnt) do
            sleep 0.3
            crawling_page_url = uri + "rstLst/" + page.to_s
            logger.debug("crawling_page_url:#{crawling_page_url}")
            restaurants_html = Nokogiri::HTML(open(crawling_page_url))
            posting_cnt = get_posting_cnt_per_page(restaurants_html.css('.c-page-count__num strong'))
            logger.debug("posting_cnt:#{posting_cnt}")

            for posting_index in (0..posting_cnt-1) do
                begin
                    logger.debug("crawling_page_url:#{crawling_page_url}")
                    logger.debug("posting_index:#{posting_index}")
                    @restaurant = TabelogRestaurantInfo.new
                    restaurant_info_dom = restaurants_html.css('.js-open-new-window')[posting_index]
                    @restaurant.uri_id  = Integer(restaurants_html.css('.cpy-rst-name')[posting_index]['href'].split("/")[6].strip)
                    logger.debug("uri_id:#{@restaurant.uri_id}")
                    @restaurant.name = restaurant_info_dom.css('.cpy-rst-name').text
                    logger.debug("name:#{@restaurant.name}")
                    if @restaurant.name.nil? || @restaurant.name.blank?
                        next
                    end
                    @restaurant.genre = restaurant_info_dom.css('.cpy-area-genre').text.split("/")[1].strip
                    logger.debug("genre:#{@restaurant.genre}")
                    @restaurant.nearby_station = restaurant_info_dom.css('.cpy-area-genre').text.split("/")[0].split(" ")[0].strip
                    logger.debug("nearby_station:#{@restaurant.nearby_station}")
                    @restaurant.distance_from_station = restaurant_info_dom.css('.cpy-area-genre').text.split("/")[0].split(" ")[1].strip
                    logger.debug("distance_from_station:#{@restaurant.distance_from_station}")
                    @restaurant.rating = restaurant_info_dom.css('.list-rst__rating-val').text
                    logger.debug("rating:#{@restaurant.rating}")
                    @restaurant.review_cnt = restaurant_info_dom.css('.cpy-review-count').text
                    logger.debug("review_cnt:#{@restaurant.review_cnt}")
                    @restaurant.lunch_budget = restaurant_info_dom.css('.cpy-lunch-budget-val').text
                    logger.debug("lunch_budget:#{@restaurant.lunch_budget}")
                    @restaurant.dinner_budget = restaurant_info_dom.css('.cpy-dinner-budget-val').text
                    logger.debug("dinner_budget:#{@restaurant.dinner_budget}")
                    logger.debug("@restaurant:#{@restaurant.inspect}")
                    @restaurant.save
                rescue Exception
                    next
                end

            end
        end
    end

end
