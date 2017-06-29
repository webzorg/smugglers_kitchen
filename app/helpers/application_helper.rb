module ApplicationHelper
  def active_class(link_path)
    "active" if current_page?(link_path)
  end

  def alertifyjs_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "notice"
      type = "warning" if type == "warning"
      type = "error"   if type == "alert"
      text = "<script>alertify.#{type}('#{message}'); </script>"
      flash_messages << text.html_safe if message
    end

    flash_messages.join("\n").html_safe
  end
end
