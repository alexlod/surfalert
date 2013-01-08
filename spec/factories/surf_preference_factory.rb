FactoryGirl.define do
  factory :surf_preference do
    max_size 8
    min_size 2
    min_shape "fg"
    spot_id 114
    start_time Time.now
    end_time Time.now
  end
end
