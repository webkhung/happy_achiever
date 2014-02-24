# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def votable_button(votable)
    if current_user.liked? votable
      content_tag(:a, class: 'btn', disabled: true) do
        image_tag('support.png', size: '48x48') +
        "Supported by #{pluralize(votable.likes.size, 'person')}"
      end +

      content_tag(:p) do
       'Supporters: '.html_safe +
        votable.likes.by_type(User).voters.map do |u|
          link_to(u.display_name, user_path(u)).html_safe
        end.to_sentence
      end
    else
      link_to support_plan_path(votable), class: 'btn', method: :put do
        image_tag('support.png', size: '48x48') + ' Support'
      end
    end
  end
end
