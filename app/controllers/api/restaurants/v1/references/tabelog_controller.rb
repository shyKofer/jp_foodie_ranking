class Api::Restaurants::V1::References::TabelogController < ApplicationController
    # GET /tabelog
    def index
        # Model
        @restaurants =  TabelogRestaurant.all
        render json: @restaurants
    end
end
