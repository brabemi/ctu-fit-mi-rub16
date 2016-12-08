class Thesis < ApplicationRecord
  validates :title, presence: true

  belongs_to :faculty
end
