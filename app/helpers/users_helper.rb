module UsersHelper

  def favorited_recipe?
    fav_arr = current_user.favorites.map { |x| x.id }
    fav_arr.include?(params[:id].to_i)
  end

  def following_user?
    following_arr = current_user.followings.map { |x| x.id }
    following_arr.include?(params[:id].to_i)
  end

end
