module ApplicationHelper
  def validation_value(obj, col, validator_num, option)
    obj.validators_on(col)[validator_num].options[option]
  end

  def myconfig(opt)
    Rails.application.config.send(opt)
  end

  def tors(obj)
    if obj.instance_of?(Task)
      return obj
    else
      return obj.task
    end
  end

  def short_date(date)
    date.nil? ? 'none' : l(date, format: :short_date_only)
  end

  def long_date(date)
    date.nil? ? 'none' : l(date, format: :long_date_only)
  end

  def c(msg)
    content_for :crumbs, "<strong>#{msg}</strong>".html_safe
  end

  def same(a, b, c)
    return a == b ? c : ''
  end

  def not_same(a, b, c)
    return a != b ? c : ''
  end
end
