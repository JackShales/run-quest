class User < ApplicationRecord
  has_secure_password
  validates :char_name, presence: true
  validates_uniqueness_of :char_name
  validates :email, presence: true
  validates_uniqueness_of :email
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

  def achievements
    user_achievements = []

    if endurance > 1
      achievement = {name: "Endurance Apprentice", detail: "Completed 1 endurance quest", icon: "fa-road"}
      user_achievements << achievement
    end

    if endurance > 5
      achievement = {name: "Endurance Practitioner", detail: "Completed 5 endurance quests", icon: "fa-road"}
      user_achievements << achievement
    end

    if endurance > 10
      achievement = {name: "Endurance Adept", detail: "Completed 10 endurance quests", icon: "fa-road"}
      user_achievements << achievement
    end

    if endurance > 20
      achievement = {name: "Endurance Pro", detail: "Completed 20 endurance quests", icon: "fa-road"}
      user_achievements << achievement
    end

    if endurance > 50
      achievement = {name: "Endurance Journeyman", detail: "Completed 50 endurance quests", icon: "fa-road"}
      user_achievements << achievement
    end

    if endurance > 100
      achievement = {name: "Endurance Master", detail: "Completed 100 endurance quests", icon: "fa-road"}
      user_achievements << achievement
    end

    if mental > 1
      achievement = {name: "Mental Apprentice", detail: "Completed 1 mental quest", icon: "fa-flask"}
      user_achievements << achievement
    end

    if mental > 5
      achievement = {name: "Mental Practitioner", detail: "Completed 5 mental quests", icon: "fa-flask"}
      user_achievements << achievement
    end

    if mental > 10
      achievement = {name: "Mental Adept", detail: "Completed 10 mental quests", icon: "fa-flask"}
      user_achievements << achievement
    end

    if mental > 20
      achievement = {name: "Mental Pro", detail: "Completed 20 mental quests", icon: "fa-flask"}
      user_achievements << achievement
    end

    if mental > 50
      achievement = {name: "Mental Journeyman", detail: "Completed 50 mental quests", icon: "fa-flask"}
      user_achievements << achievement
    end

    if mental > 100
      achievement = {name: "Mental Master", detail: "Completed 100 mental quests", icon: "fa-flask"}
      user_achievements << achievement
    end

    if speed > 1
      achievement = {name: "Speed Apprentice", detail: "Completed 1 speed quest", icon: "fa-bolt"}
      user_achievements << achievement
    end

    if speed > 5
      achievement = {name: "Speed Practitioner", detail: "Completed 5 speed quests", icon: "fa-bolt"}
      user_achievements << achievement
    end

    if speed > 10
      achievement = {name: "Speed Adept", detail: "Completed 10 speed quests", icon: "fa-bolt"}
      user_achievements << achievement
    end

    if speed > 20
      achievement = {name: "Speed Pro", detail: "Completed 20 speed quests", icon: "fa-bolt"}
      user_achievements << achievement
    end

    if speed > 50
      achievement = {name: "Speed Journeyman", detail: "Completed 50 speed quests", icon: "fa-bolt"}
      user_achievements << achievement
    end

    if speed > 100
      achievement = {name: "Speed Master", detail: "Completed 100 speed quests", icon: "fa-bolt"}
      user_achievements << achievement
    end
    user_achievements
  end
end
