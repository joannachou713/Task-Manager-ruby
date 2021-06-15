class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.datetime :start
      t.datetime :endtime
      t.integer :priority
      t.integer :status

      t.timestamps
    end
  end
end
