class AllowNullForTeacherId < ActiveRecord::Migration[6.0]
  def change
    change_column :tickets, :teacher_id, :bigint, :null => true
  end
end
