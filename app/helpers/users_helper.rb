module UsersHelper

  def favorited_recipe?
    fav_arr = current_user.favorites.map { |x| x.id }
    fav_arr.include?(params[:id].to_i)
  end

end
