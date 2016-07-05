class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :email
      t.text :content

      t.timestamps null: false
    end
  end
end
