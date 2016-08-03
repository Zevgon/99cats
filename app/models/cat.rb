class Cat < ActiveRecord::Base
  validates :sex, inclusion: { in: ["M", "F"] }
  validates :name, :color, :sex, :description, :birth_date, presence: true

  has_many :requests,
  primary_key: :id,
  foreign_key: :cat_id,
  class_name: :CatRentalRequest,
  dependent: :destroy
end
