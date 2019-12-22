require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "レコードを作成する" do
    let(:user) {create(:user)}
    let(:commented_user) {create(:user)}
    context "パラメータが妥当な場合" do
      before do
        @post = commented_user.posts.first
      end
      it "バリデーションが通る" do
        params  = {user_id: user.id, post_id: @post.id, content: "Test Comment"}
        comment = Comment.new(params)
        expect(comment).to be_valid
      end
    end
    context "パラメータが妥当ではない場合" do
      before do
        @post = commented_user.posts.first
      end
      it "バリデーションに失敗する" do
        params  = {post_id: @post.id, content: "Test Comment"}
        comment = Comment.new(params)
        expect(comment).not_to be_valid
      end
    end
  end
end
