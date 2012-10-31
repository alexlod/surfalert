class SurfPreference < ActiveRecord::Base
  attr_accessible :max_size, :min_size, :min_shape, :spot_id, :phone_no
  
  validates_presence_of :max_size, :min_size, :min_shape, :spot_id, :phone_no
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
end
