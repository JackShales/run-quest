class User < ApplicationRecord
  has_secure_password
  has_many :activities
  has_many :user_quests
  has_many :quests, through: :user_quests
  has_many :assigners, through: :quests, source: :assigner
  has_many :assignees, through: :quests, source: :assignee
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: :Friendship, foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  def all_relationships
    friendships + inverse_friendships
  end

  def pending_friends
    all_relationships.select {|relationship| relationship.status_code == 0 }
  end

  def confirmed_friends
    all_relationships.select {|relationship| relationship.status_code == 1 }
  end

  def friend?(person)
    response = false
    all_relationships.each do |friendship|
      if friendship.user == person || friendship.friend == person
        response = true
      end
    end
    response
  end
end
