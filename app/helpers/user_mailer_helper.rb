module UserMailerHelper

  def h1_header
    'font-size: 20px; color: darkorange;text-shadow: #ffffff 0px 1px 0px;font-weight: bold;padding-top: 10px;'
  end

  def well
    'background-color: #eeeeee;color: #000;font-size: 16px;font-style: normal;padding: 15px;margin: 0 0 0 0;line-height: 1.5em;-webkit-border-radius: 15px;-moz-border-radius: 15px;border-radius: 15px;'
  end

  def blue_link_attr
    { style: 'color: #20a8e9; font-weight: bold;', target: '_blank' }
  end
end
