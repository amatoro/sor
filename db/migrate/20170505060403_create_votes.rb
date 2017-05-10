class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true

      t.timestamps
    end
    add_reference :votes, :user, foreign_key: true
  end
end
