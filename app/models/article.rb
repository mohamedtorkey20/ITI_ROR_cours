class Article < ApplicationRecord
  include Visible
  
  has_one_attached :avatar
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy
  validates :reports_count, presence: true
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

end
