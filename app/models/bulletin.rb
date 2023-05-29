# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  aasm skip_validation_on_save: true, whiny_transitions: false, column: 'state' do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderation do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :to_archive do
      transitions from: %i[under_moderation published rejected draft], to: :archived
    end
  end

  has_one_attached :image
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image,
            attached: true,
            content_type: %i[png jpg jpeg],
            size: { less_than: 5.megabytes }

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id title state]
  end
end
