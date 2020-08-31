class AddOrderToLineItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :line_items, :order,  foreign_key: true
  end
end
