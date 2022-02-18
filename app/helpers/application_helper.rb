module ApplicationHelper

  def full_title(subtitle = "")
    main_title = "Instagram"
    subtitle.empty? ? main_title : subtitle + " | " + main_title
  end
end
