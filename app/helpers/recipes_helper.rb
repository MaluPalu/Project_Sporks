module RecipesHelper

  def stars_html(num)
    if !num.is_a?(Integer) || num > 5 || num < 1
      return
    elsif num == 1
      return '&#9733;'
    else
      return '&#9733;' + stars_html(num-1)
    end
  end

  def star_rating(recipe)
    if recipe.reviews.count == 0
      "No ratings yet"
    else
      ratings_arr = recipe.reviews.map { |x| x.rating }
      rating = ((ratings_arr.inject(0){ |sum, x| sum + x })/ratings_arr.length).round
      stars_html(rating)
    end
  end

  def difficulty_string(str)
    num = str.to_i
    difficulty_level = ['', '', 'Easy', 'Medium', 'Hard']
    if num < 0 || num > 4
      ''
    else
      difficulty_level[num]
    end
  end

end
