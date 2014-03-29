module OverDueHelper
  def hide_from_other_users(uid)
    if !current_user.admin? && current_user.id != uid
      'style="display:none"'.html_safe
    end
  end
end
