module CategoriesHelper
  def category_colors(category_name)
    colors = {
      "Travel" => "#75b9be",
      "Sports & Hiking" => "#AF7A6D",
      "Music" => "#cc76a1",
      "Art" => "#F5A623",
      "Technology" => "#797b84",
      "Books" => "#de7c5a",
      "Food & Drink" => "#9ae19d",
      "Health & Fitness" => "#b7990d",
      "Movies" => "#4a90e2",
      "Fashion & Beauty" => "#d14d72",
      "Faith & Spirituality" => "#ffbfb7",
      "Science" => "#bbc5aa"
    }
    colors[category_name] || { background: "#9B9B9B" }
  end

  def category_icon(category)
    icons = {
      "Travel" => "fa-solid fa-plane",
      "Sports & Hiking" => "fa-solid fa-person-hiking",
      "Music" => "fa-solid fa-music",
      "Art" => "fa-solid fa-palette",
      "Technology" => "fa-solid fa-microchip",
      "Books" => "fa-solid fa-book",
      "Food & Drink" => "fa-solid fa-utensils",
      "Health & Fitness" => "fa-solid fa-heart-pulse",
      "Movies" => "fa-solid fa-film",
      "Fashion & Beauty" => "fa-solid fa-shirt",
      "Faith & Spirituality" => "fa-solid fa-spa",
      "Science" => "fa-solid fa-flask"
    }
    icons[category.name] || "fa-solid fa-tag"
  end
end
