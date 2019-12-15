# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :posts, dependent: :destroy

  def get_timeline_data
    timelines = self.posts.recent_10_posts.with_attached_picture
    timelines.map do |timeline|
      {
        timeline: timeline,
        image: timeline.attachment_url
      }
    end
  end

end
