class AddDescAndDateToTrail < ActiveRecord::Migration
  def change
    add_column :trails, :desc, :string
    add_column :trails, :date, :datetime
  end
end
