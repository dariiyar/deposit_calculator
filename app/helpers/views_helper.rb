module Sinatra
  module ViewsHelper
    JS_ESCAPE_MAP = {
      '\\' => '\\\\',
      '</' => '<\/',
      '\r\n' => '\n',
      '\n' => '\n',
      '\r' => '\n',
      '"' => '\\"',
      "'" => "\\'",
      '`' => '\\`',
      '$' => '\\$'
    }.freeze

    def escape_javascript(javascript)
      javascript = javascript.to_s
      expr = %r{/(\\|<\/|\r\n|\342\200\250|\342\200\251|[\n\r"']|[`]|[$])/u}
      result = javascript.empty? ? '' : javascript.gsub(expr, JS_ESCAPE_MAP)
      javascript.html_safe? ? result.html_safe : result
    end

    def dropdown_field_tag(name, options)
      input = content_tag(:input, '', name: name, type: :hidden, value: options[:value])
      button = content_tag(:button,
                           options[:default_text],
                           class: 'btn btn-secondary dropdown-toggle', type: 'button', id: "dropdown_#{name}",
                           data: { toggle: 'dropdown', 'aria-haspopup' => 'true', 'aria-expanded' => 'false' })
      content_tag(:div, class: 'dropdown') do
        (input + button + content_tag(:div, dropdown_items(options[:items]), class: 'dropdown-menu')).html_safe
      end
    end

    def form_group_control_tag(type, name, options = {})
      input_options = options[:input_options]
      input_options[:class] = form_class(name, 'form-control', input_options[:class])
      content_tag :div, class: form_class(name, 'form-group', options[:class]) do
        send("#{type}_tag", name, input_options) +
          content_tag(:div, '', class: 'help-block hidden')
      end
    end

    private

    def form_class(name, class_name, classes = '')
      classes ||= ''
      classes + " #{name} #{class_name}"
    end

    def dropdown_items(items)
      el = items.inject('') do |memo, item|
        memo + content_tag(:div, item.first, class: 'dropdown-item', data: { value: item.last })
      end
      el.html_safe
    end
  end
end
