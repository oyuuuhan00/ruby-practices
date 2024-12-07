def fizzbuzz
  x = 100
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
