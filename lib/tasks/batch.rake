require 'net/http'
require 'json'

namespace :batch do
  desc "Read and parse current HM Standing"
  task parse_standing: :environment do
    today = Date.today
    unless Day.exists?(date: today)
      Day.create(:date => today)
    end
    day_id = Day.find_by(date: today).id
    for skip in 0..254 do
      url = "https://hockeymanager.ch/api/VirtualClubScores/globalRating?limit=50&skip=#{skip*50}"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      parsed = JSON.parse(response)
      parsed["vClubs"].each do |club|
        name = club['Name']
        unless Team.exists?(name: name)
          Team.create(:name => name)
        end
        position = club['Position']
        points = club['Score']
        team_id = Team.find_by(name: name).id
        unless RankingDay.exists?(team_id: team_id, day_id: day_id)
          RankingDay.create(:day_id => day_id, :team_id => team_id, :points => points, :ranking => position)
        end
      end
    end
  end
end
