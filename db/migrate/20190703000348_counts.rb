class Counts < ActiveRecord::Migration[5.2]
  def change
    create_table :counts do |t|
      t.datetime :created_at
    end
  end
end
