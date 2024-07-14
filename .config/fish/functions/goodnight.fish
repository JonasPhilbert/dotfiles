function goodnight --description 'Dims the screen and schedules a hibernation in between 60 and 120 minutes.'
  echo 'Goodnight <3'
  echo 30 > /sys/class/backlight/intel_backlight/brightness
  sleep (math (random 60 120) x 60)
  systemctl suspend
end
