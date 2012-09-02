class PlayerDepth < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  belongs_to :position

  attr_accessible :depth
  validates :depth, presence: true, uniqueness: { scope: [:team_id, :position_id] }

  default_scope order(:depth)

  scope :at_position, ->(position) do
    if position.is_a? String
      position_id = Position.find_by_code(position)
    else
      position_id = position.id
    end
    where(position_id: position_id)
  end

  def self.maximum_depth
    self.select("max(depth)").pluck("max(depth)").first
  end

  def self.depth_range
    (1..maximum_depth)
  end
end
