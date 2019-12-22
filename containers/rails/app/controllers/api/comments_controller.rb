class Api::CommentsController < ApplicationController
    before_action :authenticate_api_user!

    def create
        comment = current_api_user.comments.new(comment_params)
        if comment.save
            render json: { comment: comment }, status: :created
        else
            render json: comment.errors, status: :unprocessable_entity
        end
    end

    def update
        comment = current_api_user.comments.find_by(id: params[:id])
        skip_if_not_found(comment) and return
        if comment.update(update_params)
            head :no_content
        else
            render json: comment.errors, status: :unprocessable_entity
        end
    end

    def destroy
        comment = current_api_user.comments.find_by(id: params[:id])
        skip_if_not_found(comment) and return
        if comment.destroy
            head :no_content
        else
            render json: {message: "Can't delete."}, status: :unprocessable_entity
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :post_id)
    end

    def update_params
        params.require(:comment).permit(:content)
    end

    def skip_if_not_found(comment)
        if comment.nil?
            render json: {message: "Comment is not found."}, status: :not_found
            return true
        end
    end
end
