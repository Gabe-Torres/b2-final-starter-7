class BulkDiscount < ApplicationRecord
  validates :percentage, presence: true
  validates :quantity_threshold, presence: true

  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
end
