class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_revenue
    total_revenue - discount_revenue
  end

  def discount_revenue
    invoice_items.joins(:bulk_discounts)
              .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
              .select("invoice_items.* AS all_items, bulk_discounts.percentage AS discount")
              .sum("invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percentage / 100)")
  end
end
