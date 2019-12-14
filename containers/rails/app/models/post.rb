class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  attr_accessor :image

  scope :recent_10_posts, -> { order(id: :desc).limit(10)}

  def parse_base64(image)
    if image.present? && !rex_image(image).nil?
      # 拡張子を取得
      content_type = create_extension(image)
      # data:image/png;base64の後を抜き出し
      contents     = image.sub %r/data:((image|application))\/.{3,},/, ''
      # base64をデコード
      decoded_data = Base64.decode64(contents)
      # /tmpフォルダに一時格納
      filename     = Time.zone.now.to_s + '.' + content_type
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
      attach_image(filename)
    end
  end

  def attachment_url
    self.picture.attached? ? 
      Rails.application.routes.url_helpers.rails_blob_url(picture) :
      nil
  end

  private
  # base64でエンコードされたファイルから拡張子を取得する
  # @param [String] image base64でエンコードされたファイル
  # @return [String] content_type[%r/\b(?!.*\/).*/] ファイルの拡張子
  def create_extension(image)
    content_type = rex_image(image)
    content_type[%r/\b(?!.*\/).*/]
  end

  # base64でエンコードされたファイルからContentTypeを取得する
  # @param [String] image base64でエンコードされたファイル
  # @return [String] image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/] ContentType
  def rex_image(image)
    image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
  end

  # /tmp配下に保存されたファイルを自分自身にアタッチする
  # @param [String] filename 保存されているファイルパス
  def attach_image(filename)
    file_path = "#{Rails.root}/tmp/#{filename}"
    picture.attach(io: File.open(file_path), filename: filename)
    # 一時保存したファイルを削除
    FileUtils.rm(file_path)
  end
end