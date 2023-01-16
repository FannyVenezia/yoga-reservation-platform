class AddColumnsToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :day, :string
    add_column :courses, :professor, :string
  end
end
