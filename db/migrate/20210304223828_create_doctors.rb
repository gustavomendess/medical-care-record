class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.integer :crm
      t.string :crm_uf
    end
    add_index :doctors, [:crm, :crm_uf], unique: true
  end
end
