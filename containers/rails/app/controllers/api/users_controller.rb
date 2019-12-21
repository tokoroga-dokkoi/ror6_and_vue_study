class Api::UsersController < ApplicationController
    before_action :authenticate_api_user!

    def index
        current_user_posts = current_api_user.get_timelines
        render json: current_user_posts, status: :ok
    end
end
