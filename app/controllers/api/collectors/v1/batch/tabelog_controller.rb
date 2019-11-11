require 'nokogiri'
require 'open-uri'

class Api::Collectors::V1::Batch::TabelogController < ApplicationController
    # POST api/collectors/v1/batch/tabelog
    def create()
        collect_tabelog_uris()
    end

    # 食べログの東京のアリアのURIを保存
    def collect_tabelog_uris()
        # Tokyo Area URIs : tokyo/A1301 ~ tokyo/A1331 (A1301~31)
        for i in 1..31 do
            uri_postfix_no = (1300 + i).to_s
            uri_area = 'A' + uri_postfix_no
            getAreaUriInfo(uri_area)
        end
    end

    def getAreaUriInfo(area_group_uri)
        group_area_uri = 'https://tabelog.com/tokyo/' + area_group_uri
        logger.debug("group_area_uri:#{group_area_uri}")
        doc = Nokogiri::HTML(open(group_area_uri))
        area_count = doc.css('.list-balloon__list-item a').count
        logger.debug("area_count:#{area_count}")
        for i in 0..area_count-1 do
            logger.debug("Loop Count:#{i}")
            @tabelogUri = TabelogUri.new
            @tabelogUri.prefecture = 'tokyo'
            @tabelogUri.area_group_uri = area_group_uri
            @tabelogUri.area_uri = doc.css('.list-balloon__list-item a')[i]['href'].strip
            @tabelogUri.area_name = doc.css('.c-link-arrow span')[i+1].text
            sleep 1
            @tabelogUri.save
            puts "Insert OK"
        end
    end

end