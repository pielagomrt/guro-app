# https://api.rubyonrails.org/classes/Time.html  (see: Adding your own time formats to to_formatted_s)
Time::DATE_FORMATS[:short_custom]  = ->(time) { time.strftime("%b %d %Y") }
