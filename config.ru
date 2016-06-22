<<<<<<< HEAD
# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
=======
require_relative 'lib/application'

$stdout.sync = true
$stderr.sync = true

run Routes
>>>>>>> 0-0-1
