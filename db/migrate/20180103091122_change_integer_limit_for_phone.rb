class ChangeIntegerLimitForPhone < ActiveRecord::Migration[5.1]
  def change
    change_column :employees, :phone, :integer, limit: 10
  end
end
