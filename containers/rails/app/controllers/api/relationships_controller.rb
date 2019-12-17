class Api::RelationshipsController < ApplicationController
    before_action :authenticate_api_user!

    def create
        followed_user = User.find_by(id: params[:followed_id])
        unless followed_user 
            render json: {mes: "User is not found"}, status: :not_found and return
        end
        if current_api_user.following?(followed_user)
            render json: {mes: "User has already followed"}, status: :conflict and return
        end

        current_api_user.follow(followed_user)
        render json: {mes: "Success."}, status: :ok
    end

    def destroy
        unfollowed_user = current_api_user.following.find_by(id: params[:id])
        unless unfollowed_user
            render json: {mes: "User is not found"}, status: :not_found and return
        end
        current_api_user.unfollow(unfollowed_user)
        render json: {mes: "Unfollowed"}, status: :ok
    end

end
