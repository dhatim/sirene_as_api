class SireneAsAPIInteractor
  include Interactor

  def log_prefix
    '------> '
  end

  def stdout_info_log(msg)
    output = "#{log_prefix} #{msg.capitalize}"
    Rails.logger.warn(output)
    puts output
  end

  def stdout_success_log(msg)
    output = seven_spaces + "#{check_mark}  #{msg.capitalize}".green
    Rails.logger.warn(output)
    puts output
  end

  def stdout_warn_log(msg)
    output = seven_spaces + "#{warning_mark} #{msg.capitalize}".yellow
    Rails.logger.error(output)
    puts output
  end

  def stdout_error_log(msg)
    output = seven_spaces + "#{error_mark} #{msg.capitalize}".red
    Rails.logger.fatal(output)
    puts output
  end

  def seven_spaces
    ' ' * 7
  end

  def warning_mark
    "\xE2\x9A\xA0"
  end

  def check_mark
    "\xE2\x9C\x93"
  end

  def error_mark
    "\xe2\x9c\x96"
  end

  def time_now
    Time.now
    # Edge case : If you are early january of a year, and you want the last monthly
    # patch of december / the last daily patches, replace Time.now by this :
    # Time.new(2017, 12, 31)
  end

  def current_year
    time_now.year.to_s
  end

  def current_month
    # we need to format month from '3' to '03'
    format('%02d', time_now.month.to_s)
  end

  def last_year
    (time_now.year - 1).to_s
  end

  def last_month
    return format('%02d', (time_now.month - 1).to_s) if current_month != '01'
    return '12'
  end
end
