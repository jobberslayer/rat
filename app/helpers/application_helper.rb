module ApplicationHelper
  def validation_value(obj, col, validator_num, option)
    obj.validators_on(col)[validator_num].options[option]
  end

  def myconfig(opt)
    Rails.application.config.send(opt)
  end

  def short_date(date)
    date.nil? ? 'none' : l(date, format: :short_date_only)
  end

  def long_date(date)
    date.nil? ? 'none' : l(date, format: :long_date_only)
  end
end
