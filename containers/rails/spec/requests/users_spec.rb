require 'rails_helper'
include ActionController::RespondWith

RSpec.describe "Users", type: :request do

  # ログイン処理
  shared_context :login do
    let(:user) {create(:user)}
    before do
      @headers = { 'CONTENT_TYPE' => 'application/json', 'ACCECPT' => 'application/json'}
      @headers.merge! user.create_new_auth_token
    end
  end
  describe "GET /api/v1/auth" do
    let(:user) { create(:user) }
    context "パラメータが正常な場合" do
      it "リクエストに成功する" do
        post api_user_registration_path, params: FactoryBot.attributes_for(:user).to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
        expect(response.status).to eq 200
      end
      it "ユーザが登録されている" do
        expect do
          post api_user_registration_path, params: FactoryBot.attributes_for(:user).to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
        end.to change(User, :count).by(1)
      end
    end

    context "必須入力項目が入力されていない場合" do
      it "リクエストに失敗する" do
        post api_user_registration_path, params: { name: "invalid", email: "invalid@exsample.com", password: "password", password_confirmation: ""}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
        expect(response.status).to eq 422
      end

      it "ユーザが登録されていない" do
        expect do
          post api_user_registration_path, params: { name: "invalid", email: "invalid@exsample.com", password: "password", password_confirmation: ""}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
        end.to change(User, :count).by(0)
      end
    end
  end

  describe "POST /api/v1/auth/sign_in" do
    let(:user) { create(:user) }
    context "ログイン情報が正しい場合" do
      before do
        @params  = { email: user.email, password: user.password }.to_json
        @headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      end
      it "リクエストが成功する" do
        post api_user_session_path, params: @params, headers: @headers
        expect(response.status).to eq 200
      end
      it "レスポンスにユーザ情報が含まれたデータが帰ってくる" do
        post api_user_session_path, params: @params, headers: @headers
        body   = JSON.parse(response.body)
        expect(response.has_header?('uid')).to be_truthy
        expect(response.has_header?('access-token')).to be_truthy
        expect(body['data']['email']).to eq user.email
        expect(body['data']['id']).to eq user.id
      end
    end

    context "ログイン情報が誤っている場合" do
      before do
        @params  = { email: user.email, password: 'invalid'}.to_json
        @headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      end

      it "リクエストに失敗する" do
        post api_user_session_path, params: @params, headers: @headers
        expect(response.status).to eq 401
      end

      it "認証エラーメッセージがレスポンスに含まれる" do
        post api_user_session_path, params: @params, headers: @headers
        body = JSON.parse(response.body)
        expect(body["success"]).to be_falsey
        expect(body["errors"]).to include "Invalid login credentials. Please try again."
      end

      it "アクセストークンがheaderに含まれていない" do
        post api_user_session_path, params: @params, headers: @headers
        expect(response.has_header?("uid")).to be_falsey
        expect(response.has_header?("access_token")).to be_falsey
      end
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    let(:user) { create(:user) }
    context 'ログインした状態でログアウトする場合' do
      before do
        # ログインしておく
        @params = { email: user.email, password: user.password}.to_json
        @headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
        post api_user_session_path, params: @params, headers: @headers
        @headers.merge!(get_auth_params_from_login_response_headers(response))
      end
      it "ログアウトができる" do
        delete destroy_api_user_session_path, headers: @headers
        expect(response.status).to eq 200
        body = JSON.parse(response.body)
        expect(body["success"]).to be_truthy
      end
    end
    context 'ログインしていない状態でログアウトする場合' do
      it "ログアウトができない" do
        delete destroy_api_user_session_path, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
        expect(response.status).to eq 404
        body = JSON.parse(response.body)
        puts body
        expect(body["success"]).to be_falsey
      end
    end
  end

  describe "GET /api/v1/users" do
    context "ユーザがログインしている場合" do
      #ログイン
      include_context :login
      it 'リクエストが成功する' do
        get api_users_path, headers: @headers
        expect(response.status).to eq 200
      end
    end
  end



  def get_auth_params_from_login_response_headers(response)
    client     = response.headers['client']
    token      = response.headers['access-token']
    expiry     = response.headers['expiry']
    token_type = response.headers['token_type']
    uid        = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token_type' => token_type
    }

    auth_params
  end
end
