class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :spin, :news, :outlook, :status, :status_description
  has_many :player_depths
end
