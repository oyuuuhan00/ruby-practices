def fizzbuzz
  number = 20
  (1..number).each do |num|
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
