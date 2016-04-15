class CreateTransaction < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
        
        t.belongs_to :card
        
        t.string :tx_type
        t.float :tx_amount, :precision => 8, :scale => 2
        t.timestamps
    end
  end
end
