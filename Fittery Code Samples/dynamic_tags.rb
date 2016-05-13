module DynamicTags
  
  def set_gender
    if @item.gender.nil? || @item.gender.name.blank?
      "Men's"
    else
      gender = @item.gender.name
      gender_sub = gender.gsub(/^[Male]+$/, "Men's")
    end
  end

  def set_pattern
    if @item.pattern_families[0].nil?
      ""
    else @item.pattern_families[0].blank? || @item.pattern_families[0].name
      @item.pattern_families[0].name
    end
  end

  def set_display_name
    if @item.brand.display_name.nil?
      ""
    else @item.brand.display_name.blank? || @item.brand.display_name
      @item.brand.display_name
    end
  end

  def set_item_name
    if @item.item_name.nil?
      ""
    else @item.item_name.blank? || @item.item_name
      @item.item_name
    end
  end

  def set_color
    if @item.color.nil?
      ""
    else @item.color.blank? || @item.color
      @item.color
    end
  end

  def description_item_string
    gender = set_gender
    brand = set_display_name
    item_name = set_item_name
    color = set_color
    pattern = set_pattern
    "#{gender} #{brand} #{item_name} in #{color} #{pattern}".html_safe
  end

  def brand_selected
    if @filters[:brands].empty?
    elsif @filters[:brands][0][1] && @filters[:brands][1]
    else
      brands = @filters[:brands][0][1]
    end
    "#{brands}"
  end

  def color_selected
    if @filters[:colors].empty?
    elsif @filters[:colors][0][1] && @filters[:colors][1]
    else
      colors = @filters[:colors][0][1]
    end
    "#{colors}"
  end

  def pattern_selected
    if @filters[:patterns].empty?
    elsif @filters[:patterns][0][1] && @filters[:patterns][1]
    else
      patterns = @filters[:patterns][0][1]
    end
    "#{patterns}"
  end

  def set_filters
    pretty_print_filter_options_string(brand_selected, color_selected, pattern_selected)
  end

  def category_string
    title_params = params[:categories].split("/")
    category = (title_params.fourth|| title_params.third || title_params.second || title_params.first)
    "#{category}"
  end

  def gender_string
    title_params = params[:categories].split("/")
    "#{title_params.first.titleize}'s"
  end

  def pretty_print_filter_options_string(*filters)
    filters.delete("")
    string = filters.join(" ")
    if string.nil? || string.empty?
      "#{gender_string} #{category_string}"
    else
      "#{gender_string} #{string} #{category_string}".html_safe
    end
  end

  def srp_h1_string
    pretty_print_filter_options_string(brand_selected) 
  end
end