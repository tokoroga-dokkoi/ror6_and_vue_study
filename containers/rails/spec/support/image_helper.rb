module ImageHelper
    # file_pathで指定されたファイルを/factories/image/から読み取り、返す
    # @param (String) file_name ファイル名
    # @retrun (String) base64_encoded_image base64でエンコードしたファイル
    def image_to_base64(file_name)
        #ファイルの読み取り
        begin
          file_path   = "#{Rails.root}/spec/factories/image/#{file_name}"
          binary_data = File.read(file_path)
          'data:image/png;base64,' + Base64.strict_encode64(binary_data)
        rescue => exception
          puts error.message
        end
    end
end