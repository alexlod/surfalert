class SurfPreference < ActiveRecord::Base
  attr_accessible :max_size, :min_size, :min_shape, :spot_id, :user,
                  :start_time, :end_time

  belongs_to :user
  
  validates_presence_of :max_size, :min_size, :min_shape, :spot_id,
                        :start_time, :end_time
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

  def check_surf_conditions(surf_json)
    surf_min_size = surf_json["minSize"]
    surf_max_size = surf_json["maxSize"]
    current_time = Time.now.strftime("%H%M").to_i
    start_i = start_time.strftime("%H%M").to_i
    end_i = end_time.strftime("%H%M").to_i

    Rails.logger.debug surf_min_size.to_s + " > " + min_size.to_s
    Rails.logger.debug surf_max_size.to_s + " < " + max_size.to_s
    Rails.logger.debug shape_good_enough?(surf_json["avgShape"]).to_s
    Rails.logger.debug (current_time >= start_i).to_s
    Rails.logger.debug (current_time <= end_i).to_s

    if surf_min_size >= min_size and 
       surf_max_size <= max_size and
       shape_good_enough?(surf_json["avgShape"]) and
       current_time >= start_i and
       current_time <= end_i

      msg = "Surf size is " + surf_min_size.to_s + "' to " + surf_max_size.to_s + "'"
      return true, msg
    else
      msg = "Conditions could be better... Size of surf: " +
            surf_min_size.to_s + "' to " + surf_max_size.to_s + "'"
      return false, msg
    end
  end


end
