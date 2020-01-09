class Team < ApplicationRecord
  has_many :ranking_days
  has_many :days, through: :ranking_days
end
