require 'parallel'

def fibonacci(n)
    case 
    when n==0   then
        return 0
    when n==1   then
        return 1
    when n < 0 then
        p   "Parameter should be positive integers"
    end
    return fibonacci(n-2) + fibonacci(n-1)
end

m=ARGV[0].to_i  #引数

start_time = Time.now
# :in_threds => スレッド数
Parallel.each(1..m, in_threds: 200) do |list|
    fibonacci(m)
  end

  p "TIME #{Time.now - start_time}s"