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

  def votable_button(votable, size = :regular)
    path = send("support_#{votable.class.to_s.underscore}_path", votable)
    path += '?' + ({back: request.url}).to_query

    case size
      when :regular
        link_to(
          image_tag('support.png', size: '40x40') + ' Support',
          path,
          class: 'btn btn-mini',
          method: :put,
          data: { behavior: 'disable_after_click'}
        ) + ' ' + supporters(votable, :span)
      when :small
        count = votable.upvotes.size > 0 ? '&middot;'.html_safe + image_tag('support-small.png') + " #{votable.upvotes.size}" : ''
        link_to("Support", path, method: :put, data: { behavior: 'disable_after_click'}) + count
    end
  end

  def supporters(votable, klass = :p)
    content_tag(klass, class: 'supporters') do
      "#{pluralize(votable.upvotes.size, 'support')} by ".html_safe +
      votable.votes.up.by_type(User).voters.uniq.reject(&:nil?).map do |u|
        next if u.nil?
        link_to(u.display_name, user_path(u))
      end.to_sentence.html_safe
    end if votable.upvotes.size > 0
  end

  def date_and_days_ago(date)
    days_ago = (DateTime.now - date.to_date).to_i
    days_ago_text = days_ago == 0 ? 'Today' : "<span class='badge badge-info'>#{days_ago}</span> days ago"
    "<strong>#{date.strftime('%D')} (#{days_ago_text})</strong>".html_safe
  end
end
