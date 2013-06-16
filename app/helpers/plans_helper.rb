module PlansHelper
  def time_spent_in_words(minutes)
    Time.at(minutes * 60).utc.strftime("%Hh %Mm")
  end
end
