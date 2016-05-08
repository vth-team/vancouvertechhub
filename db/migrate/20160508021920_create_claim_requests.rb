class CreateClaimRequests < ActiveRecord::Migration
  def change
    create_table :claim_requests do |t|
      t.boolean :status
      t.references :user, index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
