class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.references :taggable, :polymorphic => true
      t.references :user
      t.timestamps
    end
  end
end
