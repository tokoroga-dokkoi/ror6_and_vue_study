class Api::PostsController < ApplicationController
    before_action :authenticate_api_user!


    def index
        #自分のTweetを取得
        posts  = current_api_user.get_timeline_data
        render json: posts, status: :ok
    end
    def create
        post = current_api_user.posts.new(post_params)
        if post.save
            #添付ファイルを保存する
            post.parse_base64(post_params[:image])
            render json: post, status: :created
        else
            # エラー時には422を返す
            render json: post.errors, status: :unprocessable_entity
        end
    end


    private
    def post_params
        params.require(:post).permit(:content,:image,:latitude, :longitude, :is_public)
    end
end
