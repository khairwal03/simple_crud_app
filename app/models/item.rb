class Item < ApplicationRecord
  scope :alive,   -> { where(soft_deleted: false) }
  scope :trashed, -> { where(soft_deleted: true) }
end
