module SurfPreferencesHelper
  def shape_selector_options(selected)
    return selector_options_helper(SurfPreference::SHAPES, selected)
  end
  
  def spot_selector_options(selected)
    return selector_options_helper(SurfPreference::SPOTS, selected)
  end
  
  private
  
    def selector_options_helper(values, selected)
      options = []
      values.each do |symbol, label|
        if symbol == selected
          s = " selected"
        else
          s = ""
        end
        options.push("<option value='#{symbol}' #{s}>#{label}</option>")
      end
      return options.join(" ")
    end
end