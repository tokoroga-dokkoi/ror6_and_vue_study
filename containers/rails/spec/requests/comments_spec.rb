require 'rails_helper'

RSpec.describe "Comments", type: :request do
  shared_context :login do
    let(:user) {create(:user)}
    before do
      @headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      @headers.merge! user.create_new_auth_token
    end
  end

  shared_context :create_comment do
    let(:commented_user) {create(:user)}
    before do
      @commented_post = commented_user.posts.first
      @comment        = user.comments.create(post_id: @commented_post.id, content: "TEST COMMENT")
      @target_path    = "/api/v1/comments/#{@comment.id}"
    end
  end

  shared_context :create_comment_other_user do
    let(:commented_user) {create(:user)}
    before do
      @commented_post = commented_user.posts.first
      @comment        = commented_user.comments.create(post_id: @commented_post.id, content: "TEST COMMENT")
      @target_path    = "/api/v1/comments/#{@comment.id}"
    end
  end

  describe "POST /comment" do
    context "リクエストパラメータが妥当な場合" do
      include_context :login
      before do
        commented_user    = create(:user)
        @commented_post    = commented_user.posts.first
        @params           = attributes_for(:comment)
        @params[:post_id] = @commented_post.id
      end

      it "リクエストが成功する" do
        post api_comments_path, params:{comment: @params}.to_json, headers: @headers
        expect(response.status).to be 201
      end
      it "Commentテーブルにレコードが1件登録される" do
        expect do
          post api_comments_path, params:{comment: @params}.to_json, headers: @headers
        end.to change(Comment, :count).by(1)
      end
      it "コメントした投稿に紐づいてる" do
        post api_comments_path, params: {comment: @params}.to_json, headers: @headers
        body          = JSON.parse(response.body)
        commented_id  = body["comment"]["id"].to_int
        expect(@commented_post.comments.count).to be 1
        expect(@commented_post.comments.find_by(id: commented_id)).to be_truthy
      end
    end

    context "post_idが指定されていない場合" do
      include_context :login
      before do
        commented_user = create(:user)
        @params         = attributes_for(:comment)
      end
      it "リクエストに失敗する" do
        post api_comments_path, params: {comment: @params}.to_json, headers: @headers
        expect(response.status).to be 422
      end
      it "Commentテーブルにレコードが登録されていない" do
        expect do
          post api_comments_path, params: {comment: @params}.to_json, headers: @headers
        end.to change(Comment, :count).by(0)
      end
    end

    context "文字数を超過したコメントの場合" do
      include_context :login
      before do
        commented_user  = create(:user)
        @commented_post = commented_user.posts.first
        @params          = attributes_for(:comment, :too_long_comment)
        @params[:post_id] = @commented_post.id
      end
      it "リクエストに失敗する" do
        post api_comments_path, params: {comment: @params}.to_json, headers: @headers
        expect(response.status).to be 422
      end
      it "Commentテーブルにレコードが登録されていない" do
        expect do
          post api_comments_path, params: {comment: @params}.to_json, headers: @headers
        end.to change(Comment, :count).by(0)
      end
    end
  end

  describe "PUT /comment/{:id}" do
    context "存在するコメントをアップデートする場合" do
      include_context :login
      include_context :create_comment
      it "リクエストに成功する" do
        put @target_path, params: {comment: {content: "UPDATE COMMENT"}}.to_json, headers: @headers
        expect(response.status).to be 204
        expect(@comment.reload.content).to eq "UPDATE COMMENT"
      end
    end
    context "存在するコメントを文字数を超過してアップデートする場合" do
      include_context :login
      include_context :create_comment
      before do
        @update_comment = attributes_for(:comment, :too_long_comment)
      end
      it "リクエストに失敗する" do
        put @target_path, params: {comment: @update_comment}.to_json, headers: @headers
        expect(response.status).to be 422
        expect(@comment.reload.content).not_to eq @update_comment[:content]
      end
    end
    context "存在しないコメントをアップデートする場合" do
      include_context :login
      before do
        commented_user = create(:user)
        commented_post = commented_user.posts.first
        @target_path   = "/api/v1/comments/#{commented_post.id}"
      end
      it "リクエストに失敗する" do
        put @target_path, params: {comment: {content: "UPDATE COMMENT"}}.to_json, headers: @headers
        expect(response.status).to be 404
        body = JSON.parse(response.body)
        expect(body["message"]).to be_truthy
      end
    end
  end

  describe "DELETE /comment/{:id}" do
    context "存在するコメントを削除する場合" do
      include_context :login
      include_context :create_comment
      it "リクエストに成功し、対象のコメントが削除されている" do
        expect do
          delete @target_path, headers: @headers
          expect(response.status).to be 204
          expect(Comment.find_by(id: @comment.id)).to be_falsey
        end.to change(Comment, :count).by(-1)
      end
    end
    context "自分以外のコメントを削除する場合" do
      include_context :login
      include_context :create_comment_other_user
      it "リクエストに失敗し、対象のコメントが削除されていない" do
        expect do
          delete @target_path, headers: @headers
          expect(response.status).to be 404
          expect(Comment.find_by(id: @comment.id)).to be_truthy  
        end.to change(Comment, :count).by(0)
      end
    end
  end
end
