class AddColorToLabels < ActiveRecord::Migration[6.1]
  def change
    add_column :labels, :color, :string
  end
end
