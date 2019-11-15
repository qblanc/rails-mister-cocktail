class Dose < ApplicationRecord
  belongs_to :ingredient
  belongs_to :cocktail

  validates :cocktail, presence: true, uniqueness: { scope: :ingredient }
end
