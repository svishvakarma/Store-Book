class Book < ApplicationRecord
  
  validates :name, :author_name, :price, :quantity_available, :isbn,  presence: true

  def stock_status
    quantity_available&.zero? ? 'out_of_stock' : 'in_stock'
  end
end
