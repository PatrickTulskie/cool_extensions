require "test_helper"

# This is a visual test to make sure that fputs does stay on one line.  You can
# Run this test from teh command line by navigating to the tests folder
# and running `ruby jtest.rb`
100.times do |i|
  fputs ((i+1)/100.to_f).to_s
  sleep 0.05
end