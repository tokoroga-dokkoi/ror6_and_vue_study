class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post

    after_validation :remove_null_bytes
    validates :content, presence: true, length: { maximum: 200 }

    private
    def remove_null_bytes
        content.delete!("\u0000")
    end
end
