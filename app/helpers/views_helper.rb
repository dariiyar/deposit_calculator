module Sinatra
  module ViewsHelper
    def dropdown_tag(name, options)
      input = content_tag(:input, '', name: name, type: :hidden)
      button = content_tag(:button,
                           options[:default_text],
                           class: 'btn btn-secondary dropdown-toggle', type: 'button', id: "dropdown_#{name}",
                           data: { toggle: 'dropdown', 'aria-haspopup' => 'true', 'aria-expanded' => 'false' })
      content_tag(:div, class: 'dropdown') do
        (input + button + content_tag(:div, dropdown_items(options[:items]), class: 'dropdown-menu')).html_safe
      end
    end

    private

    def dropdown_items(items)
      el = ''
      items.each do |item|
        el += content_tag(:div, item.first, class: 'dropdown-item', data: { value: item.last })
      end
      el.html_safe
    end
  end
end
