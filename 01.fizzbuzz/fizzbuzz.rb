<<<<<<< HEAD
=======
require 'debug'

>>>>>>> f15a89aa5a4eefed6d4a17f02549cecb43f3e099
def fizzbuzz
  x = 20
  array = (1..x).to_a
  array.each do |num|
    if num % 15 == 0
      puts "fizzbuzz"
    elsif num % 3 == 0
      puts "fizz"
    elsif num % 5 == 0
      puts "buzz"
    else
      puts num
    end
  end
end

fizzbuzz
