require 'rails_helper'

RSpec.describe "Relationships", type: :request do
    let(:user) {create(:user)}
    shared_context :login do
        before do
            @headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
            @headers.merge! user.create_new_auth_token
        end
    end

    shared_context :follow do
        before do
            @followed_user = create(:user)
            user.follow(@followed_user)
        end
    end

    describe "POST /api/v1/relationships" do
        context "パラメータにフォローしていないユーザのIDが含まれている場合" do
            include_context :login
            before do
                @following_user = create(:user)
            end
            it "リクエストに成功する" do
                post  api_relationships_path, headers: @headers, params: { followed_id: @following_user.id }.to_json
                expect(response.status).to eq 200
            end
            it "Relationshipテーブルのレコードが1件追加される" do
                expect do
                    post api_relationships_path, headers: @headers, params: { followed_id: @following_user.id }.to_json
                end.to change(Relationship, :count).by(1)
            end
            it "指定したユーザがフォローされている" do
                post api_relationships_path, headers: @headers, params: { followed_id: @following_user.id }.to_json
                expect(user.following?(@following_user)).to be_truthy
            end
        end
        context "パラメータにすでにフォローしているユーザのIDが含まれている場合" do
            include_context :login
            before do
                @following_user = create(:user)
                user.follow(@following_user)
            end
            it "リクエストに失敗する" do
                post api_relationships_path, headers: @headers, params: {followed_id: @following_user.id}.to_json
                expect(response.status).to eq 409
            end
            it "Relationshipテーブルにレコードが登録されていない" do
                expect do
                    post api_relationships_path, headers: @headers, params: {followed_id: @following_user.id}.to_json
                end.to change(Relationship, :count).by(0)
            end
            it "指定したユーザがフォローされている" do
                post api_relationships_path, headers: @headers, params: {followed_id: @following_user.id}.to_json
                expect(user.following?(@following_user)).to be_truthy
            end
        end
    end

    describe "DELETE /api/v1/relations/{:id}" do
        context "フォロー済みユーザのフォローを解消する場合" do
            include_context :login
            include_context :follow

            it "リクエストに成功する" do
                delete "/api/v1/relationships/#{@followed_user.id}", headers: @headers
                expect(response.status).to be 200
            end

            it "Relationテーブルから1件レコードが削除される" do
                expect do
                    delete "/api/v1/relationships/#{@followed_user.id}", headers: @headers
                end.to change(Relationship, :count).by(-1)
            end

            it "フォローから外れている" do
                delete "/api/v1/relationships/#{@followed_user.id}", headers: @headers
                expect(user.following?(@followed_user)).to be_falsey
            end
        end

        context "フォローしていないユーザのフォローを解消する場合" do
            include_context :login
            before do
                @unfollow_user = create(:user)
                @url           = "/api/v1/relationships/#{@unfollow_user.id}"
            end

            it "リクエストに失敗し、レスポンス404が帰ってくる" do
                delete @url, headers: @headers
                expect(response.status).to be 404
            end

            it "Relationテーブルのレコード数が変わらない" do
                expect do
                    delete @url, headers: @headers
                end.to change(Relationship, :count).by(0)
            end
        end

        context "存在しないユーザのフォローを解消する場合" do
            include_context :login
            before do
                @url           = "/api/v1/relationships/9999"
            end
            it "リクエストに失敗し、レスポンス404が帰ってくる" do
                delete @url, headers: @headers
                expect(response.status).to be 404
            end
            it "Relationshipテーブルのレコード数が変わらない" do
                expect do
                    delete @url, headers: @headers
                end.to change(Relationship, :count).by(0)
            end
        end
    end
end