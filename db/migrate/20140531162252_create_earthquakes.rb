class CreateEarthquakes < ActiveRecord::Migration
  def change
    create_table :earthquakes do |t|
      t.float :magnitude
      t.datetime :time
      t.string :location
      t.timestamps
    end
  end
end
