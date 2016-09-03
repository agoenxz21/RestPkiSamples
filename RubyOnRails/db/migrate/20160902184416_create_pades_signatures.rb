class CreatePadesSignatures < ActiveRecord::Migration
  def change
    create_table :pades_signatures do |t|

      t.timestamps null: false
    end
  end
end
