class CreatePointsOfInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :points_of_interests do |t|
      t.string :name

      t.timestamps
    end
  end
end
