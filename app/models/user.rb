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

  def level_change
    level_bar = 0
    level_change_value = 0
    level_hash = {}
    (1..100).each do |level_number|
      level_hash.merge!(level_number => level_bar)
      level_bar += 250 * level_number
    end
    (1..100).each do |level_number|
      if experience > level_hash[level_number] 
        level_change_value = level_number
      end
    end
    level_change_value
  end

  def level_up?
    level_bar = 0
    level_hash = {}
    (1..100).each do |level_number|
      level_hash.merge!(level_number => level_bar)
      level_bar += 250 * level_number
    end
    return true if experience > level_hash[level]
  end

  def exp_ratio
    level_bar = 0
    level_hash = {}
    (1..100).each do |level_number|
      level_hash.merge!(level_number => level_bar)
      level_bar += 250 * level_number
    end
    exp_bar = level_hash[(level + 1)]
    level_ratio = (experience.to_f / exp_bar.to_f) * 100
    level_ratio
  end

  def exp_to_go
    level_bar = 0
    level_hash = {}
    (1..100).each do |level_number|
      level_hash.merge!(level_number => level_bar)
      level_bar += 250 * level_number
    end
    exp_bar = level_hash[(level + 1)]
    exp_to_next_level = exp_bar - experience
    exp_to_next_level
  end
end
