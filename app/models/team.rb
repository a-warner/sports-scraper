class Team < ActiveRecord::Base
  attr_accessible :name, :url
  validates :name, :url, presence: true
  validates :name, uniqueness: { scope: :name }
end
