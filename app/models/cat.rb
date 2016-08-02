class Cat < ActiveRecord::Base
  validates :sex, inclusion: { in: ["M", "F"] }
  validates :name, :color, :sex, :description, :birth_date, presence: true
end
