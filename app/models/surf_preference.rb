class SurfPreference < ActiveRecord::Base
  attr_accessible :max_size, :min_size, :min_shape, :spot_id, :user

  belongs_to :user
  
  validates_presence_of :max_size, :min_size, :min_shape, :spot_id
  validates :max_size, :numericality => {
    :only_integer => true,
    :greater_than => 0,
    :less_than => 100
  }
  validates :min_size, :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0,
    :less_than => 100
  }
  validates :spot_id, :numericality => {:only_integer => true}
  
  # NOTE: the order of the hash determines how shapes are compared to one another.
  # the first shape should be the lowest, and the last shape should be the highest
  # (or best).
  SHAPES = {
    "p" => "Poor",
    "pf" => "Poor-Fair",
    "f" => "Fair",
    "fg" => "Fair-Good",
    "g" => "Good"
  }.freeze
  
  SPOTS = {
    113 => "Fort Point",
    114 => "North Ocean Beach",
    117 => "South Ocean Beach"
  }.freeze
  
  # determines if the shape is good enough according to the `min_shape` value in this preference.
  def shape_good_enough?(actual_shape_symbol)
    ordered_shapes = SHAPES.keys
    actual_index = ordered_shapes.index(actual_shape_symbol)
    desired_index = ordered_shapes.index(min_shape)
    raise "Unexpected results: #{actual_shape_symbol} : #{min_shape}" if actual_index.nil? or desired_index.nil?
    return actual_index >= desired_index
  end
end
