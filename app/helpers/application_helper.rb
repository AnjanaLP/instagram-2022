module ApplicationHelper

  def full_title(subtitle = "")
    main_title = "Instagram"
    subtitle.empty? ? main_title : subtitle + " | " + main_title
  end

  def move_flash_messages?
    params[:controller] == "sessions" && params[:action] == "create"
  end

  def no_nav?
    params[:controller] == "posts" && params[:action] == "show"
  end
end
