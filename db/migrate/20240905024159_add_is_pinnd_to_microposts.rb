class AddIsPinndToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :is_pinned, :boolean, null: false, default: false
  end
end
