class Api::UsersController < ApplicationController
    before_action :authenticate_api_user!

    def index
        # マイページ表示するデータを整形し、レスポンスを返すメソッド
        current_user_posts = current_api_user.posts.recent_10_posts
        if current_user_posts.count > 0
            logger.debug current_user_posts.first.image
            render json: current_user_posts, status: :ok
        else
            render status: :no_content
        end
    end
end
