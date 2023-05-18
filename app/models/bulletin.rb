# frozen_string_literal: true

class Bulletin < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image,
            attached: true,
            content_type: %i[png jpg jpeg],
            size: { less_than: 5.megabytes }
end