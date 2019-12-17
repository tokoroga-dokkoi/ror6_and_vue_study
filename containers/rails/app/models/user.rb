# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :posts, dependent: :destroy
  
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follower_relationships

  def get_timeline_data
    timelines = self.posts.recent_10_posts.with_attached_picture
    timelines.map do |timeline|
      {
        timeline: timeline,
        image: timeline.attachment_url
      }
    end
  end

  def follow(other_user)
    following_relationships.create!(followed_id: other_user.id)
  end

  def unfollow(other_user)
    logger.debug(other_user.email)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
