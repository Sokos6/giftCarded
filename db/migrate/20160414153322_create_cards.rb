class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
    	t.string :issuing_company
    	t.string :card_number
    	t.float :balance, :precision => 8, :scale => 2
        t.timestamps
    end
  end
end
