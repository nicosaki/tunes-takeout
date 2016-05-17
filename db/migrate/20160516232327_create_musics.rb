class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :object
      t.string :type

      t.timestamps null: false
    end
  end
end
