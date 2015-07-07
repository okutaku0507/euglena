module ApplicationHelper
  include HtmlBuilder
  def page_title
    title = "Euglena (ユーグレナ)"
    title = @title + " - " + title if @title
    title
  end
  
  # 改行文字 => BR
  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />").html_safe
  end
  
  # flash
  def flash_messages
    markup do |m|
      m.div(flash[:alert], class: 'alert alert-danger', role: 'alert') if flash[:alert].present?
      m.div(flash[:notice], class: 'alert alert-info', role: 'alert') if flash[:notice].present?
    end
  end
  
  # エラーメッセージの表示
  def translate_field_name(form, field)
    t(field, scope: [ :activerecord, :attributes, form.object.class.to_s.underscore ])
  end

  def format_error_message(model, field, form)
    messages = model.errors[field]
    messages = [ messages ].flatten
    text = raw('')
    messages.each do |message|
      text << content_tag(:p,
        translate_field_name(form, field) + ' ' + message,
        class: "error_message")
    end
    text
  end
  
  def organism_image_tag(organism, options = {})
    if organism.data.present?
      path = organism_path(organism, format: organism.extension)
      image_tag(path, { alt: 'organism_image' }.merge(options))
    end
  end
end
