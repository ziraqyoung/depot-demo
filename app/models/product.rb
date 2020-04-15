class Product < ApplicationRecord
  has_many :line_items

  validates :title, uniqueness: true
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url, allow_blank: true, format: {
                with: %r{\.(gif|jpg|png)\Z}i,
                message: "must be a valid URL for PNG, JPG or GIF image",
              }
  before_destroy :ensure_not_referenced_by_any_line_item

  private
    # ensure that there are no line_items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items Present')
        throw :abort
      end
    end
end
