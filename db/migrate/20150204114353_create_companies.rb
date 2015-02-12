class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :category
      t.string :link
      t.integer :year_of_approval

      t.timestamps
    end
  end
end
