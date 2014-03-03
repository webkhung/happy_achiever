module GratefulsHelper
  def show_gratefuls
    @user.gratefuls.map{ |g| [g.grateful_1, g.grateful_2, g.grateful_3, g.grateful_4, g.grateful_5].compact }.flatten.sample(3).map{ |g| "<p>#{g}</p>" }.join('').html_safe
  end
end
