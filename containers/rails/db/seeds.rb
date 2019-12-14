## Create User
user = User.create!(
    [
        {
            email: "testuser1@exsample.com",
            name: "test1",
            password: "password",
            password_confirmation: "password"
        },
        {
            email: "testuser2@exsample.com",
            name: "test2",
            password: "password",
            password_confirmation: "password"
        },
        {
            email: "testuser3@exsample.com",
            name: "test3",
            password: "password",
            password_confirmation: "password"
        }
    ]
)

## Get Image Files
def get_image_files()
    file_path = "#{Rails.root}/spec/factories/image/*"
    Dir.glob(file_path)
end

## Create Base64 Image
def image_to_base64(file_path)
    begin
        # ファイル読み込み
        img_data     = File.read(file_path)
        # base64にデコード
        encoded_data = 'data:image/png;base64,' + Base64.strict_encode64(img_data)
        encoded_data
    rescue => exception
        puts "Error"
        puts exception
    end
end

## Create Posts
file_list = get_image_files()

User.all.each do |user|
    5.times do |n|
        img_file                = file_list.sample
        img_file_encoded_base64 = image_to_base64(img_file)
        post = user.posts.create!({
            content: Faker::Book.title,
            latitude: Random.new().rand(100.0),
            longitude: Random.new().rand(100.0),
            is_public: [true, false].sample
        })
        #画像をアタッチ
        post.parse_base64(img_file_encoded_base64)
    end
end

