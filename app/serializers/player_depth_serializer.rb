class PlayerDepthSerializer < ActiveModel::Serializer
  attributes :id, :depth, :position_code

  def position_code
    object.position.code
  end
end
