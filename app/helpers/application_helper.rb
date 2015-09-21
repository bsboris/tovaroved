module ApplicationHelper
  def nav_item(label, path, match)
    css_class = request.path =~ match ? 'active' : nil

    content_tag :li, class: css_class do
      link_to label, path
    end
  end

  def page_header(page_title, &block)
    buttons = capture(&block) if block_given?
    content_tag :div, class: "page-header clearfix" do
      concat content_tag :div, content_tag(:h2, page_title.to_s.html_safe), class: "pull-left"
      concat content_tag :div, buttons, class: "controls pull-right"
    end
  end

  def edit_link(record, opts = {})
    link_to 'Редактировать', [:edit, record], opts
  end
end
