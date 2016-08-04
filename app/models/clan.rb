class Clan < ApplicationRecord
  has_many :users
  has_many :quests, through: :clan_quests
end
