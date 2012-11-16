module ApplicationHelper
  def notice_msg(msg)
    "<div class='alert alert-success'>#{msg}</div>".html_safe
  end
  
  def alert_msg(msg)
    "<div class='alert'>#{msg}</div>".html_safe
  end
end
