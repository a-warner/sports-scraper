class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :url

  has_many :players
end
