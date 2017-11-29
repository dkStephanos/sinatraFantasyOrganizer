class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :point_guard
      t.string :shooting_guard
      t.string :small_forward
      t.string :power_forward
      t.string :center
      t.string :sixth_man
      t.integer :user_id
    end
  end
end
