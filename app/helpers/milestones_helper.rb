module MilestonesHelper
  def status_icon(status)
    case status
    when 0 then icon_for :star_empty, 'Not done'
    when 1 then icon_for :star_half_empty, 'In progress'
    when 2 then icon_for :star, 'Completed!'
    end
  end
end
