class CreateRankingDays < ActiveRecord::Migration[6.0]
  def change
    create_table :ranking_days do |t|
      t.references :day, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :points
      t.integer :ranking

      t.timestamps
    end
  end
end
