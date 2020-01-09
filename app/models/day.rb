class Day < ApplicationRecord
  has_many :ranking_days
  has_many :teams, through: :ranking_days
end
