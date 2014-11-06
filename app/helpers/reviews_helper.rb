module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    rating = rating.round
      p "=============="
      p remainder = (5 - rating)
      p "★" * rating + "☆" * remainder
    end
  end
